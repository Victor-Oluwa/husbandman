import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';
import 'package:husbandman/src/product_manager/domain/usecase/fetch_farmer_products.dart';
import 'package:mocktail/mocktail.dart';

import 'Mocked/mock_product_manager_repo.dart';

void main() {
  late ProductManagerRepo repo;
  late FetchFarmerProduct usecase;

  final tProductEntityList = [ProductEntity.empty()];
  const farmerEmail = 'user-id';
  final serverFailure = ServerFailure(
    message: 'Failed to fetch products',
    statusCode: 500,
  );

  setUp(() {
    repo = MockProductManagerRepo();
    usecase = FetchFarmerProduct(repo);
  });
  group('Fetch Farmers Products', () {
    test(
      'Should call [ProductManager Repo] and return Right<List<ProductEntity>>',
          () async {
        when(() => repo.fetchFarmerProducts(any())).thenAnswer(
              (_) async => Right(
                tProductEntityList,
          ),
        );

        final result = await usecase(farmerEmail);
        expect(
          result,
          equals(
            Right<dynamic, List<ProductEntity>>(tProductEntityList),
          ),
        );

        verify(() => repo.fetchFarmerProducts(farmerEmail)).called(1);
        verifyNoMoreInteractions(repo);
      },
    );

    test(
      'Should call [ProductManager Repo] and return Right<ProductEntity>',
          () async {
        when(() => repo.fetchFarmerProducts(any())).thenAnswer(
              (_) async => Left(
            serverFailure,
          ),
        );

        final result = await usecase(farmerEmail);
        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(serverFailure),
          ),
        );

        verify(() => repo.fetchFarmerProducts(farmerEmail)).called(1);
        verifyNoMoreInteractions(repo);
      },
    );
  });
}
