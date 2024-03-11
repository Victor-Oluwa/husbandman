import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/onboarding/domain/repo/onboarding_repo.dart';

class CheckIfUserIsFirstTimer extends UseCaseWithoutParams<bool> {
  CheckIfUserIsFirstTimer(
    this._repo,
  );
  final OnboardingRepo _repo;

  @override
  ResultFuture<bool> call() => _repo.checkIfUserIsFirstTimer();
}
