import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const Failure._();

  const factory Failure.server([@Default('Server Error') String message]) = ServerFailure;
  const factory Failure.cache([@Default('Cache Error') String message]) = CacheFailure;
  const factory Failure.network([@Default('Network Error') String message]) = NetworkFailure;
  const factory Failure.authentication([@Default('Authentication Failure') String message]) = AuthenticationFailure;
  const factory Failure.validation([@Default('Validation Error') String message]) = ValidationFailure;
  const factory Failure.dataParsing([@Default('Data Parsing Error') String message]) = DataParsingFailure;
  const factory Failure.unknown([@Default('Unknown Error') String message]) = UnknownFailure;

  List<dynamic> get properties => [message];
}
