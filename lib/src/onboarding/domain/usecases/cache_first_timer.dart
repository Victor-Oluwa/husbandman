import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/onboarding/domain/repo/onboarding_repo.dart';

class CacheFirstTimer extends UseCaseWithoutParams<void> {
  CacheFirstTimer(
    this._repo,
  );
  final OnboardingRepo _repo;

  @override
  ResultFuture<void> call() => _repo.cacheFirstTimer();
}
