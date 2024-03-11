// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:husbandman/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDataSource {
  const OnboardingLocalDataSource();

  Future<void> cacheFirstTimer();

  Future<bool> checkIfUserIsFirstTimer();
}

const kFirstTimerKey = 'new-comer';

class OnboardingLocalDataSrcImpl implements OnboardingLocalDataSource {
  const OnboardingLocalDataSrcImpl(
    this.prefs,
  );

  final SharedPreferences prefs;

  @override
  Future<void> cacheFirstTimer() async {
    try {
      await prefs.setBool(kFirstTimerKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    try {
      return prefs.getBool(kFirstTimerKey) ?? true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
