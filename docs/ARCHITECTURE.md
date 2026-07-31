# Architecture - Syncinema

## Overview
Syncinema is built with Clean Architecture + MVVM + Repository Pattern.

**Core principle**: Local media files only, cloud only syncs playback state.

## Layers

### Presentation
- Flutter widgets with premium UI (glassmorphism, blur, gradients, animations)
- Riverpod StateNotifier for state management
- GoRouter for navigation with custom transitions (FadeSlide, Premium)

### Domain
- Entities: Room, User, MediaFile, AudioTrackInfo, SubtitleTrackInfo, SyncEvent, ChatMessage
- Freezed for immutability + json_serializable
- UseCases (could be added) - currently logic in Notifiers

### Data
- DataSources: RoomRemoteDataSource (WebSocket)
- Models: RoomModel (DTO)
- Repositories: Implemented via Notifiers directly for simplicity, but interface ready

### Core
- WebSocketService: Manages connection, reconnection (exponential backoff), heartbeat, ping/pong RTT
- LatencyMonitor: Tracks average, min, max ping, quality score
- LocalStorage: SharedPreferences wrapper for userId, recent rooms, subtitle settings
- DI: GetIt + Riverpod providers centralized

## Sync Engine - Critical Component

```
Host: Player state change -> SyncEngine.sendPlay/Pause/Seek/Speed -> WebSocket -> DO -> Broadcast
Client: Remote event -> SyncEngine.handleRemoteEvent -> drift check -> applyState (seek + play/pause)
```

### Drift Correction
- Every 2s, check diff between local and remote position if both playing
- Threshold 300ms (AppConstants.maxDriftThreshold)
- If drift > threshold, auto seek to remote position
- Network delay compensation: positionWithDelay = position + (now - timestamp)*speed

### Heartbeat
- 2s interval ping with pingId, server pong immediate, client calculates RTT
- LatencyMonitor keeps last 20 samples, avg ping used for quality.

### Reconnect
- On done/error, schedule reconnect with delay = attempt*2 seconds, max 10 attempts
- State: disconnected -> connecting -> connected -> reconnecting -> failed

## Player

- media_kit (libmpv) - supports all formats requested (MP4/MKV/MOV/AVI/WEBM + MP3/FLAC/AAC/OGG/WAV)
- Tracks API: player.state.tracks.audio/subtitle gives list, language, title
- Subtitle external loading: Srt/Vtt via file picker, set via SubtitleTrack.uri
- Audio track switching: player.setAudioTrack(AudioTrack(id,...))
- Volume, Speed via setVolume, setRate

## Backend

### Cloudflare Workers + Durable Objects

- Worker (src/index.ts): Routes /health, /room/:roomId/websocket, /room/:roomId/info
  - Gets DO ID via idFromName(roomId) -> ensures same room maps to same DO
  - Forwards request to DO

- Durable Object (src/room.ts):
  - In-memory Map<WebSocket, WsSession> + Map<userId, User> + RoomState
  - Persistent storage via this.storage for room + users (survives restarts)
  - Handles: ping/pong, sync_* (permission check), chat_message, typing, host_transfer, permission_change, media_change
  - Broadcast logic: send to all or exclude sender
  - Host transfer on leave: if host leaves, next user becomes host
  - Cleanup: if no users, delete after 5 min

### Message Types
```ts
type = "ping" | "pong" | "join" | "leave" | "sync_play" | "sync_pause" | "sync_seek" | "sync_speed" | "chat_message" | "typing" | "host_transfer" | "permission_change" | "media_change" | "room_state"
```

## UI/UX Premium Approach

- No default Flutter look: custom gradients, glass (BackdropFilter blur 12-20), border 0.06 white
- Glow orbs: RadialGradient circles with opacity 0.15-0.3, positioned absolute
- Cards: 20-24 radius, gradient + shadow + border
- Animations: flutter_animate for fadeIn + slideY, scale on press, AnimatedOpacity/Slide for controls
- Landscape: Chat as floating panel 380px from right, slideX animation, blur background, no need to leave video
- Controls: Hide after 3s, double tap 10s seek, tap to toggle, blur bottom bar

## Security & Privacy

- No media upload: file_picker picks local path, media_kit opens Media(path)
- Only sync state via WebSocket (position, isPlaying, speed, chat)
- Room ID 6 chars A-Z0-9, brute force hard, but could add password later

## Scalability

- Durable Objects auto scale per room (each room is separate DO instance)
- Workers handle 100k+ concurrent WebSockets per region
- No shared state between rooms, isolated

## Testing Strategy

- Unit: SyncEngine, FileUtils, LatencyMonitor, TimeUtils
- Widget: HomePage, PlayerControls, UsersGrid, ChatPanel (mock providers)
- Integration: Room flow (create, join, host transfer)
- E2E: Manual + GitHub Actions building APK/AAB + backend deploy

## Future Improvements

- Password protected rooms
- Voice chat via WebRTC
- Watch history
- Subtitle search via OpenSubtitles API
- Picture-in-Picture
- Chromecast
