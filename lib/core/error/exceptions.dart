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

class CartException extends Equatable implements Exception {
  const CartException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  List<dynamic> get props => [message, statusCode];
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

class CloudinaryException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const CloudinaryException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object> get props => [message, statusCode];
}

class CompressorException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const CompressorException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object> get props => [message, statusCode];
}

class FilePickerException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const FilePickerException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object> get props => [message, statusCode];
}

class FirebaseException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const FirebaseException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object> get props => [message, statusCode];
}

class ProductManagerException extends Equatable implements Exception {
  const ProductManagerException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class PaymentException extends Equatable implements Exception{
  const PaymentException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;
  @override
  List<dynamic> get props => [];
}

class SuperBaseException extends Equatable implements Exception {
 const SuperBaseException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  List<dynamic> get props => [message, statusCode];
}

class OrderException extends Equatable implements Exception{
  const OrderException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

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
