import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:husbandman/src/onboarding/data/repo/onboarding_repo_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingLocalDataSrc extends Mock
    implements OnboardingLocalDataSource {}

void main() {
  late OnboardingLocalDataSource localDataSource;
  late OnboardingRepoImpl repoImpl;

  setUp(() {
    localDataSource = MockOnboardingLocalDataSrc();
    repoImpl = OnboardingRepoImpl(localDataSource);
  });

  group('cacheFirstTimer', () {
    test(
      'Should complete successfully',
      () async {
        when(
          () => localDataSource.cacheFirstTimer(),
        ).thenAnswer(
          (_)async => Future.value(),
        );
        final result = await repoImpl.cacheFirstTimer();

        expect(result, equals(const Right<dynamic, void>(null)));

        verify(() => localDataSource.cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
        'should return [CacheFailure] when call to local data source is unsuccessful',
        () async {
      when(() => localDataSource.cacheFirstTimer())
          .thenThrow(const CacheException(message: 'Insufficient Storage'));

      final result = await repoImpl.cacheFirstTimer();

      expect(
        result,
        Left(CacheFailure(message: 'Insufficient Storage', statusCode: 500)),
      );

      verify(() => localDataSource.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });

  group('checkIfUserIsFirstTimer', () {
    test(
        'should return a Right(false) if operation is successful and user is not first timer',
        () async {
      when(() => localDataSource.checkIfUserIsFirstTimer())
          .thenAnswer((_) async => false);

      final result = await repoImpl.checkIfUserIsFirstTimer();

      expect(result, equals(const Right<dynamic, bool>(false)));

      verify(() => localDataSource.checkIfUserIsFirstTimer());
      verifyNoMoreInteractions(localDataSource);
    });

    test('should return [CachedFailure] when operation is unsuccessful',
        () async {
      when(() => localDataSource.checkIfUserIsFirstTimer())
          .thenThrow(const CacheException(message: "I can't find my shoes"));

      final result = await repoImpl.checkIfUserIsFirstTimer();
      expect(
        result,
        Left(
          CacheFailure(message: "I can't find my shoes", statusCode: 500),
        ),
      );

      verify(() => localDataSource.checkIfUserIsFirstTimer());
      verifyNoMoreInteractions(localDataSource);
    });
  });
}
