// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:husbandman/core/error/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final dynamic statusCode;

  Failure({
    required this.message,
    required this.statusCode,
  }) : assert(
          statusCode is String || statusCode is int,
          'Status Code cannot be a ${statusCode.runtimeType}',
        );

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<dynamic> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  CacheFailure({
    required super.message,
    required super.statusCode,
  });
}

class AuthFailure extends Failure {
  AuthFailure({
    required super.message,
    required super.statusCode,
  });

  AuthFailure.fromException(AuthException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class AdminFailure extends Failure {
  AdminFailure({
    required super.message,
    required super.statusCode,
  });

  AdminFailure.fromException(AdminException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class ServerFailure extends Failure {
  ServerFailure({
    required super.message,
    required super.statusCode,
  });

  ServerFailure.fromException(ServerException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}
