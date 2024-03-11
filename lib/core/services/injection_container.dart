import 'package:get_it/get_it.dart';
import 'package:husbandman/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:husbandman/src/onboarding/data/repo/onboarding_repo_impl.dart';
import 'package:husbandman/src/onboarding/domain/repo/onboarding_repo.dart';
import 'package:husbandman/src/onboarding/domain/usecases/cache_first_timer.dart';
import 'package:husbandman/src/onboarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:husbandman/src/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  sl
    ..registerLazySingleton(() => prefs)
    ..registerFactory(
      () => OnboardingCubit(
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ),
    )
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
    ..registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSrcImpl(sl()),
    )
    ..registerSingleton<OnboardingRepo>(OnboardingRepoImpl(sl()));
}
