import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import '../domain/entities/media_file.dart';
import '../domain/entities/audio_track.dart';
import '../domain/entities/subtitle_track.dart';
import '../../sync/domain/entities/sync_event.dart';
import '../../sync/engine/sync_engine.dart';
import '../../room/presentation/providers/room_provider.dart';
import '../../room/data/datasources/room_remote_datasource.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/di/providers.dart';

class PlayerState {
  final Player? player;
  final VideoController? videoController;
  final MediaFile? mediaFile;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final double speed;
  final double volume;
  final bool isBuffering;
  final List<AudioTrackInfo> audioTracks;
  final List<SubtitleTrackInfo> subtitleTracks;
  final AudioTrackInfo? selectedAudio;
  final SubtitleTrackInfo? selectedSubtitle;
  final SubtitleStyleConfig subtitleStyle;
  final String? error;
  final bool isReady;
  final PlaybackState syncPlayback;

  const PlayerState({
    this.player,
    this.videoController,
    this.mediaFile,
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.speed = 1.0,
    this.volume = 1.0,
    this.isBuffering = false,
    this.audioTracks = const [],
    this.subtitleTracks = const [],
    this.selectedAudio,
    this.selectedSubtitle,
    this.subtitleStyle = const SubtitleStyleConfig(),
    this.error,
    this.isReady = false,
    this.syncPlayback = const PlaybackState(),
  });

  PlayerState copyWith({
    Player? player,
    VideoController? videoController,
    MediaFile? mediaFile,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    double? speed,
    double? volume,
    bool? isBuffering,
    List<AudioTrackInfo>? audioTracks,
    List<SubtitleTrackInfo>? subtitleTracks,
    AudioTrackInfo? selectedAudio,
    SubtitleTrackInfo? selectedSubtitle,
    SubtitleStyleConfig? subtitleStyle,
    String? error,
    bool? isReady,
    PlaybackState? syncPlayback,
  }) =>
      PlayerState(
        player: player ?? this.player,
        videoController: videoController ?? this.videoController,
        mediaFile: mediaFile ?? this.mediaFile,
        isPlaying: isPlaying ?? this.isPlaying,
        position: position ?? this.position,
        duration: duration ?? this.duration,
        speed: speed ?? this.speed,
        volume: volume ?? this.volume,
        isBuffering: isBuffering ?? this.isBuffering,
        audioTracks: audioTracks ?? this.audioTracks,
        subtitleTracks: subtitleTracks ?? this.subtitleTracks,
        selectedAudio: selectedAudio ?? this.selectedAudio,
        selectedSubtitle: selectedSubtitle ?? this.selectedSubtitle,
        subtitleStyle: subtitleStyle ?? this.subtitleStyle,
        error: error ?? this.error,
        isReady: isReady ?? this.isReady,
        syncPlayback: syncPlayback ?? this.syncPlayback,
      );
}

class PlayerNotifier extends StateNotifier<PlayerState> {
  final Ref _ref;
  final RoomRemoteDataSource _ds;
  StreamSubscription? _messageSub;
  StreamSubscription? _positionSub;
  SyncEngine? _syncEngine;
  Timer? _controlTimer;

  PlayerNotifier(this._ref, this._ds) : super(const PlayerState());

  Future<void> init({required String roomId, required String userId, required bool isHost}) async {
    // Initialize media_kit player
    final player = Player(configuration: const PlayerConfiguration(logLevel: MPVLogLevel.warn));
    final videoController = VideoController(player);

    state = state.copyWith(player: player, videoController: videoController);

    // Listen to player streams
    player.stream.position.listen((pos) {
      state = state.copyWith(position: pos);
      // Update local sync state
      _syncEngine?.updateLocalState(PlaybackState(
        isPlaying: state.isPlaying,
        positionMs: pos.inMilliseconds.toDouble(),
        speed: state.speed,
        lastUpdateTimestamp: DateTime.now().millisecondsSinceEpoch,
      ));
    });

    player.stream.duration.listen((dur) {
      state = state.copyWith(duration: dur);
    });

    player.stream.playing.listen((playing) {
      state = state.copyWith(isPlaying: playing);
    });

    player.stream.buffering.listen((buf) {
      state = state.copyWith(isBuffering: buf);
    });

    player.stream.tracks.listen((tracks) {
      AppLogger.info('Tracks updated: audio=${tracks.audio.length} subtitle=${tracks.subtitle.length}');
      final audio = tracks.audio.asMap().entries.map((e) {
        return AudioTrackInfo(
          id: e.value.id,
          index: e.key,
          language: e.value.language ?? 'unknown',
          title: e.value.title ?? 'Audio ${e.key + 1}',
        );
      }).toList();

      final subs = tracks.subtitle.asMap().entries.map((e) {
        return SubtitleTrackInfo(
          id: e.value.id,
          index: e.key,
          language: e.value.language ?? 'unknown',
          title: e.value.title ?? 'Subtitle ${e.key + 1}',
          isEmbedded: true,
        );
      }).toList();

      state = state.copyWith(audioTracks: audio, subtitleTracks: subs);
    });

    // Sync engine
    _syncEngine = SyncEngine(
      sendEvent: (event) {
        final map = event.toJson();
        map['positionMs'] = event.positionMs;
        _ds.send({
          'type': 'sync_${event.type.name}',
          'roomId': event.roomId,
          'userId': event.userId,
          'positionMs': event.positionMs,
          'isPlaying': event.isPlaying,
          'speed': event.speed,
          'timestamp': event.timestamp,
        });
      },
      applyState: (pos, playing, speed) async {
        await _applyRemoteState(pos, playing, speed);
      },
    );

    _syncEngine!.init(roomId: roomId, userId: userId, isHost: isHost);

    // Listen to sync messages
    _messageSub = _ds.messages.listen((msg) {
      final t = msg['type'] as String?;
      if (t == null) return;
      if (t.startsWith('sync_')) {
        final eventTypeStr = t.replaceFirst('sync_', '');
        final eventType = SyncEventType.values.firstWhere((e) => e.name == eventTypeStr, orElse: () => SyncEventType.syncResponse);
        final event = SyncEvent(
          type: eventType,
          roomId: msg['roomId'] as String? ?? roomId,
          userId: msg['userId'] as String? ?? 'unknown',
          timestamp: msg['timestamp'] as int? ?? DateTime.now().millisecondsSinceEpoch,
          positionMs: (msg['positionMs'] as num?)?.toDouble(),
          isPlaying: msg['isPlaying'] as bool?,
          speed: (msg['speed'] as num?)?.toDouble() ?? 1.0,
          metadata: msg,
        );
        _syncEngine?.handleRemoteEvent(event);
      }
    });

    state = state.copyWith(isReady: true);
    AppLogger.info('Player initialized for room $roomId');
  }

  Future<void> loadMedia(String path) async {
    final player = state.player;
    if (player == null) return;
    try {
      final file = Media(path);
      await player.open(file, play: false);
      
      // Create mediaFile placeholder, actual extraction could be done separately
      final mediaFile = MediaFile(
        path: path,
        name: path.split('/').last,
        size: 0,
        duration: player.state.duration,
        audioTracks: [],
        subtitleTracks: [],
        createdAt: DateTime.now(),
      );
      state = state.copyWith(mediaFile: mediaFile);
      AppLogger.info('Loaded media: $path');
    } catch (e) {
      state = state.copyWith(error: e.toString());
      AppLogger.error('Failed to load media', error: e);
    }
  }

  Future<void> play() async {
    final room = _ref.read(roomProvider);
    final canControl = room.isHost || (room.room?.allowAllControl ?? true);
    if (!canControl) {
      AppLogger.warning('No permission to play');
      return;
    }
    await state.player?.play();
    _syncEngine?.sendPlay(state.position, speed: state.speed);
  }

  Future<void> pause() async {
    final room = _ref.read(roomProvider);
    final canControl = room.isHost || (room.room?.allowAllControl ?? true);
    if (!canControl) return;
    await state.player?.pause();
    _syncEngine?.sendPause(state.position);
  }

  Future<void> togglePlayPause() async {
    if (state.isPlaying) await pause(); else await play();
  }

  Future<void> seek(Duration position) async {
    final room = _ref.read(roomProvider);
    final canControl = room.isHost || (room.room?.allowAllControl ?? true);
    if (!canControl) return;
    await state.player?.seek(position);
    _syncEngine?.sendSeek(position, isPlaying: state.isPlaying);
  }

  Future<void> setSpeed(double speed) async {
    await state.player?.setRate(speed);
    state = state.copyWith(speed: speed);
    _syncEngine?.sendSpeed(speed, state.position);
  }

  Future<void> setVolume(double vol) async {
    await state.player?.setVolume(vol * 100);
    state = state.copyWith(volume: vol);
  }

  Future<void> selectAudioTrack(AudioTrackInfo track) async {
    await state.player?.setAudioTrack(AudioTrack(track.id, track.title, track.language));
    state = state.copyWith(selectedAudio: track);
  }

  Future<void> selectSubtitleTrack(SubtitleTrackInfo? track) async {
    if (track == null) {
      await state.player?.setSubtitleTrack(SubtitleTrack.no());
      state = state.copyWith(selectedSubtitle: null);
    } else {
      if (track.isExternal && track.path != null) {
        await state.player?.setSubtitleTrack(SubtitleTrack.uri(track.path!));
      } else {
        await state.player?.setSubtitleTrack(SubtitleTrack(track.id, track.title, track.language));
      }
      state = state.copyWith(selectedSubtitle: track);
    }
  }

  Future<void> loadExternalSubtitle(String path) async {
    final track = SubtitleTrackInfo(
      id: 'external_${DateTime.now().millisecondsSinceEpoch}',
      index: state.subtitleTracks.length,
      language: 'external',
      title: path.split('/').last,
      isExternal: true,
      path: path,
    );
    state = state.copyWith(subtitleTracks: [...state.subtitleTracks, track]);
    await selectSubtitleTrack(track);
  }

  void updateSubtitleStyle(SubtitleStyleConfig style) {
    state = state.copyWith(subtitleStyle: style);
  }

  Future<void> _applyRemoteState(Duration pos, bool playing, double speed) async {
    final player = state.player;
    if (player == null) return;
    final diff = (state.position - pos).inMilliseconds.abs();
    if (diff > 300) {
      await player.seek(pos);
    }
    if (playing && !state.isPlaying) {
      await player.play();
    } else if (!playing && state.isPlaying) {
      await player.pause();
    }
    if ((state.speed - speed).abs() > 0.01) {
      await player.setRate(speed);
      state = state.copyWith(speed: speed);
    }
  }

  @override
  void dispose() {
    _messageSub?.cancel();
    _positionSub?.cancel();
    _controlTimer?.cancel();
    _syncEngine?.dispose();
    state.player?.dispose();
    super.dispose();
  }
}

final playerProvider = StateNotifierProvider<PlayerNotifier, PlayerState>((ref) {
  final ds = ref.watch(roomDataSourceProvider);
  return PlayerNotifier(ref, ds);
});
