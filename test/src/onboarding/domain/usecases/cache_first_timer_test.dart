import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/onboarding/domain/repo/onboarding_repo.dart';
import 'package:husbandman/src/onboarding/domain/usecases/cache_first_timer.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repo.mock.dart';

void main() {
  //The dependency
  late OnboardingRepo repo;
  //Class to be tested
  late CacheFirstTimer usecase;

//From flutter_test package
  setUp(() {
    repo = MockOnboardingRepo();
    usecase = CacheFirstTimer(repo);
  });

  test(
    'Should call the [OnboardingRepo.cacheFirstTimer] '
    'and return a a server failure',
    () async {
      when(
        () => repo.cacheFirstTimer(),
      ).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'An Error Occurred', statusCode: 500),
        ),
      );

      final result = await usecase();

      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(
              message: 'An Error Occurred',
              statusCode: 500,
            ),
          ),
        ),
      );
      verify(() => repo.cacheFirstTimer()).called(1);

      verifyNoMoreInteractions(repo);
    },
  );
}
