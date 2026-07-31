class ServerException implements Exception {
  final String message;
  final int? code;
  ServerException(this.message, {this.code});
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

class PermissionException implements Exception {
  final String message;
  PermissionException(this.message);
}

class FileException implements Exception {
  final String message;
  FileException(this.message);
}

class SyncException implements Exception {
  final String message;
  SyncException(this.message);
}

class RoomException implements Exception {
  final String message;
  final int? code;
  RoomException(this.message, {this.code});
}
