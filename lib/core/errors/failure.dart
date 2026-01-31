import 'package:equatable/equatable.dart';

// Clase base para todos los errores del sistema
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// Error específico del servidor (API 500, 404, etc)
class ServerFailure extends Failure {
  const ServerFailure({String message = 'Server Failure'}) : super(message);
}

// Error de conexión a internet
class ConnectionFailure extends Failure {
  const ConnectionFailure({String message = 'Connection Failure'}) : super(message);
}