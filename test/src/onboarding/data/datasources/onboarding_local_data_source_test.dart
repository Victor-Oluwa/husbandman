import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/src/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnboardingLocalDataSource localDataSource;

  setUp(() {
    prefs = MockSharedPreferences();
    localDataSource = OnboardingLocalDataSrcImpl(prefs);
  });

  group('cache first timer', () {
    test('should call shared preferences to cache first timer', () async {
      when(() => prefs.setBool(any(), any())).thenAnswer((_) async => false);

      await localDataSource.cacheFirstTimer();

      verify(() => prefs.setBool(kFirstTimerKey, false));
      verifyNoMoreInteractions(prefs);
    });

    test(
        'should throw a [Cache Exception] when write to shared preference fails',
        () async {
      when(() => prefs.setBool(any(), any())).thenThrow(Exception());

      final methodCall = localDataSource.cacheFirstTimer;

      expect(methodCall, throwsA(isA<CacheException>()));

      verify(() => prefs.setBool(kFirstTimerKey, false));
      verifyNoMoreInteractions(prefs);
    });
  });

  group('checkIfUserIsFirstTimer', () {
    test(
        'should check if user is first timer and return the right data '
        'if the data exist in storage', () async {
      when(() => prefs.getBool(any())).thenAnswer((_) => false);

      final result = await localDataSource.checkIfUserIsFirstTimer();

      expect(result, equals(false));

      verify(() => prefs.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test('should return true if the data does not exist in storage', () async {
      when(() => prefs.getBool(any())).thenAnswer((_) => null);

      final result = await localDataSource.checkIfUserIsFirstTimer();

      expect(result, equals(true));

      verify(() => prefs.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test('should throw [CacheException] when there is an error', () async {
      when(() => prefs.getBool(any())).thenThrow(Exception());

      final methodCall = localDataSource.checkIfUserIsFirstTimer;

      expect(methodCall, throwsA(isA<CacheException>()));

      verify(() => prefs.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });
}
