import 'package:get_it/get_it.dart';
import '../network/websocket_service.dart';
import '../network/latency_monitor.dart';
import '../storage/local_storage.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {
  // Must init storage first
  await LocalStorage.init();
  
  // Core
  sl.registerLazySingleton<WebSocketService>(() => WebSocketService());
  sl.registerLazySingleton<LatencyMonitor>(() => LatencyMonitor());
  
  // Data sources
  // sl.registerLazySingleton<RoomRemoteDataSource>(() => RoomRemoteDataSourceImpl(sl()));
  
  // Repositories will be registered via Riverpod providers primarily
  // but keep GetIt for non-riverpod usage
  
  // Additional services
}

Future<void> disposeInjection() async {
  await sl<WebSocketService>().disconnect();
  sl.reset();
}
