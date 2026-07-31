import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? code;
  const Failure(this.message, {this.code});

  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code});
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message, {super.code});
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

class FileFailure extends Failure {
  const FileFailure(super.message);
}

class PlayerFailure extends Failure {
  const PlayerFailure(super.message);
}

class RoomFailure extends Failure {
  const RoomFailure(super.message, {super.code});
}

class SyncFailure extends Failure {
  const SyncFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
