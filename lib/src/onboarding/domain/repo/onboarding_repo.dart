import 'package:husbandman/core/utils/typedef.dart';

abstract class OnboardingRepo {
  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
