# 🎬 Syncinema - Watch Together, Listen Together

**Professional Production-Ready Android app for synchronized movie watching & music listening with local files + realtime cloud sync.**

[![Flutter](https://img.shields.io/badge/Flutter-3.24.5-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.5.4-0175C2?logo=dart)](https://dart.dev)
[![Cloudflare Workers](https://img.shields.io/badge/Cloudflare-Workers-F38020?logo=cloudflare)](https://workers.cloudflare.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## ✨ Features

### Core
- ✅ Create / Join rooms with 6-char code
- ✅ Invite via link & QR Code
- ✅ Realtime sync with <150ms drift correction
- ✅ Chat, emoji, reactions, typing indicators
- ✅ Host transfer, permission management (allow all / host only)
- ✅ Ping, connection quality, online users

### Player (Local Files Only - Privacy First)
- 🎥 **Video**: MP4, MKV, MOV, AVI, WEBM, M4V, 3GP, FLV, WMV
- 🎵 **Audio**: MP3, FLAC, AAC, OGG, WAV, M4A, WMA, OPUS, AIFF
- 💬 **Subtitles**: Embedded detection, external SRT/VTT/ASS, RTL Persian support
  - Size, color, position, background, transparency, delay adjustment
- 🎧 **Audio Tracks**: Auto detect multi-language, switch, display language name
- Sync: Play, Pause, Seek, Speed (0.25x-2x), Auto Drift Correction, Heartbeat, Reconnect

### UI/UX - Premium
- Dark glassmorphism + blur + gradients
- Custom page transitions, micro-animations, ripple effects
- Landscape: floating chat panel without leaving movie
- Modern dialogs, bottom sheets, shimmer loading
- Material 3, Fully Persian RTL

### Backend
- Cloudflare Workers + Durable Objects
- WebSocket realtime, scalable rooms
- No media upload - only sync state

---

## 🏗️ Architecture

```
lib/
├── app/
│   ├── router/ (GoRouter + premium transitions)
│   └── theme/ (Material 3, colors, typography)
├── core/
│   ├── constants/
│   ├── errors/ (Failures, Exceptions)
│   ├── network/ (WebSocketService, LatencyMonitor)
│   ├── storage/ (LocalStorage)
│   ├── utils/
│   └── di/ (GetIt + Riverpod providers)
└── features/
    ├── home/ (Landing, recent rooms)
    ├── room/ (Create/Join, QR, users grid)
    ├── player/ (media_kit, multi-format, subtitle)
    ├── sync/ (engine, drift corrector)
    ├── chat/ (messages, typing)
    └── settings/

backend/
├── src/
│   ├── index.ts (Worker entry)
│   └── room.ts (Durable Object)
└── wrangler.toml
```

**Patterns**: Clean Architecture, MVVM, Repository Pattern, Dependency Injection, Freezed, JSON Serializable, Riverpod

---

## 🚀 Tech Stack

- **Flutter 3.24.5**, Dart 3.5.4
- **State**: flutter_riverpod + riverpod_annotation + hooks_riverpod
- **Navigation**: go_router 14.8.1
- **Immutable**: freezed + json_serializable
- **Player**: media_kit 1.1.11 (libmpv, all formats)
- **UI**: google_fonts, flutter_animate, blur, gap, shimmer, animations
- **Network**: web_socket_channel, dio, connectivity_plus
- **QR**: qr_flutter, mobile_scanner
- **Backend**: Cloudflare Workers, Durable Objects, WebSocket
- **CI/CD**: GitHub Actions

---

## 📦 Installation

### Flutter App
```bash
git clone https://github.com/yourname/syncinema.git
cd syncinema
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

### Backend
```bash
cd backend
npm install
wrangler dev
# Deploy
wrangler deploy
```

Update `lib/core/constants/api_constants.dart` with your worker URL:
```dart
static const String prodWsBase = 'wss://syncinema.your-subdomain.workers.dev';
```

---

## 🧪 Testing

```bash
# Unit
flutter test test/unit/

# Widget
flutter test test/widget/

# Integration
flutter test test/integration/

# All + coverage
flutter test --coverage
```

Tests include:
- SyncEngine (play/pause/seek/speed, drift, own-event ignore)
- FileUtils (extension detection, room ID)
- LatencyMonitor (avg, quality)
- TimeUtils (format, SRT parse)
- Widget: HomePage, PlayerControls
- Integration: Room flow

---

## 📱 APK & AAB

```bash
flutter build apk --release
flutter build appbundle --release
```
Outputs: `build/app/outputs/flutter-apk/app-release.apk`, `build/app/outputs/bundle/release/app-release.aab`

---

## 🔐 Permissions (Android)

- INTERNET, ACCESS_NETWORK_STATE
- READ_EXTERNAL_STORAGE, READ_MEDIA_VIDEO, READ_MEDIA_AUDIO
- CAMERA (QR scan)
- WAKE_LOCK (keep screen on)

---

## 🌍 Deployment

### GitHub
1. Create PAT (Personal Access Token)
2. `gh repo create syncinema --public --source=. --remote=origin`
3. `git push -u origin main`

Actions auto build APK/AAB on main push.

### Cloudflare
1. Get API Token (Edit Cloudflare Workers)
2. Set secrets in GitHub: `CLOUDFLARE_API_TOKEN`, `CLOUDFLARE_ACCOUNT_ID`
3. Workflow auto deploys backend, or manual:
```bash
cd backend
wrangler login
wrangler deploy
```

---

## 📚 Documentation

- **Sync Algorithm**: Host broadcasts state, clients apply with network delay compensation (RTT/2). Drift checker every 2s, threshold 300ms, auto correct.
- **Heartbeat**: 2s interval, RTT measured via ping/pong, quality score 0-1.
- **Reconnect**: Exponential backoff up to 10 attempts.
- **Security**: No media on server, room ID 6 chars base32, WebSocket per Durable Object isolated.

---

## 📸 Screenshots (Premium UI)

- Home: gradient orbs, glass cards, hero typography
- Create Room: mode selector (film/music), blur text fields
- Room: code display, QR, users grid with host badge
- Player: No controls visible, tap to show, double tap 10s seek, landscape chat panel
- Chat: bubble, emoji bar, typing animation

---

## 🤝 Contributing

PRs welcome! Ensure `flutter analyze` passes and tests green.

---

## 📄 License

MIT

---

## 🔗 Links

- Backend URL: `wss://syncinema.workers.dev`
- Invite format: `https://syncinema.app/join?roomId=ABC123` or `syncinema://join/ABC123`

Built with ❤️ for watching together.
