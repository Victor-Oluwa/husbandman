import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';
import 'package:husbandman/src/product_manager/domain/usecase/set_product.dart';
import 'package:mocktail/mocktail.dart';

import 'Mocked/mock_product_manager_repo.dart';

void main() {
  late ProductManagerRepo repo;
  late SetProduct usecase;

  final tProductEntity = ProductEntity.empty();

  final params = SetProductParams.empty();

  final serverFailure = ServerFailure(
    message: 'Failed to set product',
    statusCode: 500,
  );

  setUpAll(() => registerFallbackValue(SetProductType.renew));

  setUp(() {
    repo = MockProductManagerRepo();
    usecase = SetProduct(repo);
  });
  group('Set Seller Product', () {
    test(
      'Should call [ProductManager Repo] and return Right<ProductEntity>',
      () async {
        when(
          () => repo.setSellerProduct(
            productMap: any(named: 'productMap'),
            productObject: any(named: 'productObject'),
            setProductType: any(named:'setProductType' ),
          ),
        ).thenAnswer(
          (_) async => Right(
            tProductEntity,
          ),
        );

        final result = await usecase(params);
        expect(
          result,
          equals(
            Right<dynamic, ProductEntity>(tProductEntity),
          ),
        );

        verify(
          () => repo.setSellerProduct(
            productMap: params.productMap,
            productObject: params.productObject,
            setProductType: params.setProductType
          ),
        ).called(1);
        verifyNoMoreInteractions(repo);
      },
    );

    test(
      'Should call [ProductManager Repo] and return Left<ServerFailure>',
      () async {
        when(
          () => repo.setSellerProduct(
            productMap: any(named: 'productMap'),
            productObject: any(named: 'productObject'),
            setProductType: any(named: 'setProductType')
          ),
        ).thenAnswer(
          (_) async => Left(
            serverFailure,
          ),
        );

        final result = await usecase(params);
        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(serverFailure),
          ),
        );

        verify(
          () => repo.setSellerProduct(
            productMap: params.productMap,
            productObject: params.productObject,
            setProductType: params.setProductType,
          ),
        ).called(1);
        verifyNoMoreInteractions(repo);
      },
    );
  });
}
