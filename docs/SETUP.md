# Setup Guide - Syncinema

## Prerequisites
- Flutter 3.24.5+
- Dart 3.5.4+
- Android SDK 34, Java 17
- Node.js 20+ (for backend)
- Cloudflare account

## Flutter App Setup

1. Clone
```bash
git clone <repo>
cd syncinema
```

2. Install deps
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

3. Configure backend URL
Edit `lib/core/constants/api_constants.dart`:
```dart
static const String prodWsBase = 'wss://YOUR_WORKER.workers.dev';
```

4. Run
```bash
flutter run --debug
```

5. Build APK/AAB
```bash
flutter build apk --release
flutter build appbundle --release
```
Outputs in `build/app/outputs/`

## Backend Setup

1. Install wrangler
```bash
npm install -g wrangler
wrangler login
```

2. Install deps
```bash
cd backend
npm install
```

3. Dev
```bash
wrangler dev
# Test: curl http://localhost:8787/health
```

4. Deploy
```bash
wrangler deploy
```

Update your `wrangler.toml` name to match your subdomain.

5. Update Flutter app with deployed URL.

## Android Permissions

Already in `AndroidManifest.xml`:
- INTERNET
- READ_EXTERNAL_STORAGE / READ_MEDIA_VIDEO / READ_MEDIA_AUDIO
- CAMERA (QR)
- WAKE_LOCK

For Android 13+, request runtime permissions via permission_handler.

## Testing

```bash
flutter test test/unit/
flutter test test/widget/
flutter test test/integration/
flutter test --coverage
```

## Troubleshooting

- **media_kit init error**: Ensure `MediaKit.ensureInitialized()` in main()
- **WebSocket fails**: Check Cloudflare worker URL, ensure wss:// not ws:// in prod
- **File picker not opening**: Check permission_handler, request storage permission
- **Drift too high**: Check ping, lower sync threshold in AppConstants
- **Gradle build fails**: Update file_picker to ^11.0.3, ensure Java 17, Android SDK 34

## Production Checklist

- [ ] Backend deployed and health check passes
- [ ] Flutter API constants point to prod worker
- [ ] APK and AAB built without errors
- [ ] Tests pass
- [ ] GitHub Actions green
- [ ] QR deep links configured
- [ ] Proguard rules if needed
- [ ] Play Store assets ready
