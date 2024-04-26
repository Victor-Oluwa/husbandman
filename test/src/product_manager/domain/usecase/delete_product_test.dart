import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';
import 'package:husbandman/src/product_manager/domain/usecase/delete_product.dart';
import 'package:mocktail/mocktail.dart';

import 'Mocked/mock_product_manager_repo.dart';

void main() {
  late ProductManagerRepo repo;
  late DeleteProduct usecase;

  final tProductEntities = [ProductEntity.empty()];
  const tUserId = 'user-id';
  final serverFailure = ServerFailure(
    message: 'Failed to delete product',
    statusCode: 500,
  );

  setUp(() {
    repo = MockProductManagerRepo();
    usecase = DeleteProduct(repo);
  });
  group('Delete Products', () {
    test(
      'Should call [ProductManager Repo] and return Right<ProductEntity>',
      () async {
        when(() => repo.deleteProduct(any())).thenAnswer(
          (_) async => Right(
            tProductEntities,
          ),
        );

        final result = await usecase(tUserId);
        expect(
          result,
          equals(
            Right<dynamic, List<ProductEntity>>(tProductEntities),
          ),
        );

        verify(() => repo.deleteProduct(tUserId)).called(1);
        verifyNoMoreInteractions(repo);
      },
    );

    test(
      'Should call [ProductManager Repo] and return Right<ProductEntity>',
      () async {
        when(() => repo.deleteProduct(any())).thenAnswer(
          (_) async => Left(
              serverFailure,
          ),
        );

        final result = await usecase(tUserId);
        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(serverFailure),
          ),
        );

        verify(() => repo.deleteProduct(tUserId)).called(1);
        verifyNoMoreInteractions(repo);
      },
    );
  });
}
