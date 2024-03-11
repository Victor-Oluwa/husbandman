// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';

// part 'onboarding_state.dart';

// class OnboardingCubit extends Cubit<OnboardingState> {
//   OnboardingCubit() : super(OnboardingInitial());
// }

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:husbandman/src/onboarding/domain/usecases/cache_first_timer.dart';
import 'package:husbandman/src/onboarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({
    required CacheFirstTimer cacheFirstTimer,
    required CheckIfUserIsFirstTimer checkIfUserIsFirstTimer,
  })  : _cacheFirstTimer = cacheFirstTimer,
        _checkIfUserIsFirstTimer = checkIfUserIsFirstTimer,
        super(const OnboardingInitial());

  final CacheFirstTimer _cacheFirstTimer;
  final CheckIfUserIsFirstTimer _checkIfUserIsFirstTimer;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());
    final result = await _cacheFirstTimer();

    result.fold(
      (l) => emit(OnboardingError(l.errorMessage)),
      (_) => emit(const UserCached()),
    );
  }

  Future<void> checkIfUserIsFirstTimer() async {
    emit(const CheckingIfUserIsFirstTimer());
    final result = await _checkIfUserIsFirstTimer();

    result.fold(
      (l) => emit(const OnboardingStatus(true)),
      (r) => emit(OnboardingStatus(r)),
    );
  }
}
