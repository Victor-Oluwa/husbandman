import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/onboarding/domain/usecases/cache_first_timer.dart';
import 'package:husbandman/src/onboarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:husbandman/src/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckIfUserIsFirstTimer extends Mock
    implements CheckIfUserIsFirstTimer {}

void main() {
  late CacheFirstTimer cacheFirstTimer;
  late CheckIfUserIsFirstTimer checkIfUserIsFirstTimer;
  late OnboardingCubit cubit;

  setUp(() {
    cacheFirstTimer = MockCacheFirstTimer();
    checkIfUserIsFirstTimer = MockCheckIfUserIsFirstTimer();
    cubit = OnboardingCubit(
        cacheFirstTimer: cacheFirstTimer,
        checkIfUserIsFirstTimer: checkIfUserIsFirstTimer,);
  });

  final testFailure =
      CacheFailure(message: 'Insufficient Storage', statusCode: 500);

  test('initial state should be [OnboardingInitial]', () {
    expect(cubit.state, const OnboardingInitial());
  });

  group('cacheFirstTimer', () {
    blocTest<OnboardingCubit, OnboardingState>(
        'emits [CachingFirstTimer] and [UserCached] when successfull.',
        build: () {
          when(() => cacheFirstTimer())
              .thenAnswer((_) async => const Right(null));
          return cubit;
        },
        act: (cubit) => cubit.cacheFirstTimer(),
        expect: () => const [CachingFirstTimer(), UserCached()],
        verify: (_) {
          verify(() => cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(cacheFirstTimer);
        },);

    blocTest<OnboardingCubit, OnboardingState>(
        'emits [CachingFirstTimer] and [OnboardingError] when unsuccessful.',
        build: () {
          when(() => cacheFirstTimer())
              .thenAnswer((_) async => Left(testFailure));
          return cubit;
        },
        act: (cubit) => cubit.cacheFirstTimer(),
        expect: () => [
              const CachingFirstTimer(),
              OnboardingError(testFailure.errorMessage),
            ],
        verify: (_) {
          verify(() => cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(cacheFirstTimer);
        },);
  });

  group('checkIfUserIsFirstTimer', () {
    blocTest<OnboardingCubit, OnboardingState>(
        'emit [CheckingIfUserIsCached] [OnboardingStatus]',
        build: () {
          when(() => checkIfUserIsFirstTimer())
              .thenAnswer((invocation) async => const Right(false));
          return cubit;
        },
        act: (cubit) => cubit.checkIfUserIsFirstTimer(),
        expect: () =>
            [const CheckingIfUserIsFirstTimer(), const OnboardingStatus(false)],
        verify: (_) {
          verify(() => checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(checkIfUserIsFirstTimer);
        },);
  });
}
