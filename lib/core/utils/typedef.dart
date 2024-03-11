import 'package:dartz/dartz.dart';
import 'package:husbandman/core/error/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
