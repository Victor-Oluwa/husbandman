// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AuthException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const AuthException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<dynamic> get props => [message, statusCode];
}

class AdminException extends Equatable implements Exception {
  const AdminException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class CacheException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const CacheException({
    required this.message,
    this.statusCode = 500,
  });

  @override
  List<dynamic> get props => [message, statusCode];
}

class ServerException extends Equatable implements Exception {
  final String message;
  final String statusCode;

  const ServerException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<dynamic> get props => [message, statusCode];
}
