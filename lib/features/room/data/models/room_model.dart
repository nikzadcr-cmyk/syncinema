import '../../domain/entities/room.dart';

class RoomModel {
  final Room room;
  RoomModel({required this.room});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      room: Room(
        id: json['id'] as String,
        name: json['name'] as String? ?? 'Room',
        hostId: json['hostId'] as String,
        createdAt: DateTime.fromMillisecondsSinceEpoch((json['createdAt'] as int?) ?? DateTime.now().millisecondsSinceEpoch),
        participantIds: (json['participantIds'] as List?)?.cast<String>() ?? [],
        allowAllControl: json['allowAllControl'] as bool? ?? true,
        isMusicMode: json['isMusicMode'] as bool? ?? false,
        currentMediaName: json['currentMediaName'] as String?,
        currentMediaDurationMs: json['currentMediaDurationMs'] as int? ?? 0,
        state: _parseState(json['state'] as String?),
        inviteLink: json['inviteLink'] as String?,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': room.id,
        'name': room.name,
        'hostId': room.hostId,
        'createdAt': room.createdAt.millisecondsSinceEpoch,
        'participantIds': room.participantIds,
        'allowAllControl': room.allowAllControl,
        'isMusicMode': room.isMusicMode,
        'currentMediaName': room.currentMediaName,
        'currentMediaDurationMs': room.currentMediaDurationMs,
        'state': room.state.name,
        'inviteLink': room.inviteLink,
      };

  static RoomState _parseState(String? s) {
    switch (s) {
      case 'playing': return RoomState.playing;
      case 'paused': return RoomState.paused;
      case 'syncing': return RoomState.syncing;
      default: return RoomState.waiting;
    }
  }
}
