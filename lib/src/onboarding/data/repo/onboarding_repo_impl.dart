import 'package:dartz/dartz.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:husbandman/src/onboarding/domain/repo/onboarding_repo.dart';

//This class will depend on a remote or local data source
class OnboardingRepoImpl implements OnboardingRepo {
  const OnboardingRepoImpl(this._localDataSource);

  final OnboardingLocalDataSource _localDataSource;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
     final result = await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = await _localDataSource.checkIfUserIsFirstTimer();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
