import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';
import 'package:husbandman/src/admin/domain/use-cases/change_farmer_badge.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_admin_repo.dart';

void main() {
  late AdminRepo adminRepo;
  late ChangeFarmerBadge usecase;

  const changeFarmerBadgeParams = ChangeFarmerBadgeParams.empty();

  setUp(() {
    adminRepo = MockAdminRepo();
    usecase = ChangeFarmerBadge(adminRepo);
  });
  group('Change Farmer Badge', () {
    test('Should call [AdminRepo] and return [Right<void>]', () async {
      when(
        () => adminRepo.changeFarmerBadge(
          farmerId: any(named: 'farmerId'),
          badge: any(named: 'badge'),
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase(changeFarmerBadgeParams);
      expect(result, equals(const Right<dynamic, void>(null)));

      verify(
        () => adminRepo.changeFarmerBadge(
          farmerId: changeFarmerBadgeParams.farmerId,
          badge: changeFarmerBadgeParams.badge,
        ),
      ).called(1);
      verifyNoMoreInteractions(adminRepo);
    });

    test('Should call [AdminRepo] and return [Left<ServerFailure>]', () async {
      when(
        () => adminRepo.changeFarmerBadge(
          farmerId: any(named: 'farmerId'),
          badge: any(named: 'badge'),
        ),
      ).thenAnswer(
        (_) async => Left(
          ServerFailure(
            message: 'An error occurred',
            statusCode: 250,
          ),
        ),
      );

      final result = await usecase(changeFarmerBadgeParams);
      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(
              message: 'An error occurred',
              statusCode: 250,
            ),
          ),
        ),
      );

      verify(
            () => adminRepo.changeFarmerBadge(
          farmerId: changeFarmerBadgeParams.farmerId,
          badge: changeFarmerBadgeParams.badge,
        ),
      ).called(1);
      verifyNoMoreInteractions(adminRepo);
    });
  });
}
