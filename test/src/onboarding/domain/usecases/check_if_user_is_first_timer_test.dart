import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/src/onboarding/domain/repo/onboarding_repo.dart';
import 'package:husbandman/src/onboarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repo.mock.dart';

void main() {
  late OnboardingRepo repo;
  late CheckIfUserIsFirstTimer usecase;

  setUp(() {
    repo = MockOnboardingRepo();
    usecase = CheckIfUserIsFirstTimer(repo);
  });

  test(
      'should call [OnboardingRepo.checkIfUserIsFirstTimer]'
      'and return true', () async {
    when(() => repo.checkIfUserIsFirstTimer()).thenAnswer(
      (invocation) async => const Right(
        true,
      ),
    );

    final result = await usecase();

    expect(
      result,
      equals(
        const Right<dynamic, bool>(
          true,
        ),
      ),
    );

    verify(() => repo.checkIfUserIsFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
