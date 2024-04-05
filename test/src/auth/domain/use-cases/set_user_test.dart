import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/auth/domain/entity/user_entity.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/set_user.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo authRepo;
  late SetUser usecase;

  final tUserMap = {'user': 'user'};
  registerFallbackValue(UserEntity.empty());

  setUp(() {
    authRepo = MockAuthRepo();
    usecase = SetUser(authRepo);
  });

  group('Set User', () {
    test('Should return [Right(void)] when successful', () async {
      when(
        () => authRepo.setUser(
          user: any(named: 'user'),
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );
      final result = await usecase(tUserMap);

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => authRepo.setUser(user: tUserMap));
      verifyNoMoreInteractions(authRepo);
    });

    test('Should return [Left(ServerFailure)] when unsuccessful', () async {
      when(
        () => authRepo.setUser(
          user: any(named: 'user'),
        ),
      ).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'Token is empty', statusCode: 500),
        ),
      );
      final result = await usecase(tUserMap);

      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(message: 'Token is empty', statusCode: 500),
          ),
        ),
      );

      verify(() => authRepo.setUser(user: tUserMap));
      verifyNoMoreInteractions(authRepo);
    });
  });
}
