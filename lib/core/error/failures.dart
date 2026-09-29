import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([this.properties = const <dynamic>[]]);
  final List<dynamic> properties;
  String get message;

  @override
  List<Object?> get props => [properties];
}

class ServerFailure extends Failure {
  const ServerFailure([this.message = 'Server Error']) : super();
  @override
  final String message;

  @override
  List<Object?> get props => [message, properties];
}

class CacheFailure extends Failure {
  const CacheFailure([this.message = 'Cache Error']) : super();
  @override
  final String message;

  @override
  List<Object?> get props => [message, properties];
}

class NetworkFailure extends Failure {
  const NetworkFailure([this.message = 'Network Error']) : super();
  @override
  final String message;

  @override
  List<Object?> get props => [message, properties];
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure([this.message = 'Authentication Failure']) : super();
  @override
  final String message;

  @override
  List<Object?> get props => [message, properties];
}

class ValidationFailure extends Failure {
  const ValidationFailure([this.message = 'Validation Error']) : super();
  @override
  final String message;

  @override
  List<Object?> get props => [message, properties];
}

class DataParsingFailure extends Failure {
  const DataParsingFailure([this.message = 'Data Parsing Error']) : super();
  @override
  final String message;

  @override
  List<Object?> get props => [message, properties];
}
