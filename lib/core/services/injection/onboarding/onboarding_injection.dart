
//ONBOARDING
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/services/injection/injection_container.dart';
import 'package:husbandman/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:husbandman/src/onboarding/data/repo/onboarding_repo_impl.dart';
import 'package:husbandman/src/onboarding/domain/repo/onboarding_repo.dart';
import 'package:husbandman/src/onboarding/domain/usecases/cache_first_timer.dart';
import 'package:husbandman/src/onboarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:husbandman/src/onboarding/presentation/cubit/onboarding_cubit.dart';

final onboardingCubitProvider = Provider<OnboardingCubit>((ref) {
  return OnboardingCubit(
    cacheFirstTimer: ref.read(cacheFirstTimerProvider),
    checkIfUserIsFirstTimer: ref.read(checkIfUserIsFirstTimerProvider),
  );
});

//Onboarding Dependencies
final onboardingLocalDatasourceProvider =
Provider<OnboardingLocalDataSource>((ref) {
  return OnboardingLocalDataSrcImpl(ref.read(sharedPreferencesProvider));
});

final onBoardingRepoProvider = Provider<OnboardingRepo>((ref) {
  return OnboardingRepoImpl(ref.read(onboardingLocalDatasourceProvider));
});

//Onboarding Use-cases
final cacheFirstTimerProvider = Provider<CacheFirstTimer>((ref) {
  return CacheFirstTimer(ref.read(onBoardingRepoProvider));
});

final checkIfUserIsFirstTimerProvider =
Provider<CheckIfUserIsFirstTimer>((ref) {
  return CheckIfUserIsFirstTimer(ref.read(onBoardingRepoProvider));
});
