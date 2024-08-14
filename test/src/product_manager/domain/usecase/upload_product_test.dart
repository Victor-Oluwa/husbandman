import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';
import 'package:husbandman/src/product_manager/domain/usecase/upload_product.dart';
import 'package:mocktail/mocktail.dart';

import 'Mocked/mock_product_manager_repo.dart';

void main() {
  late ProductManagerRepo repo;
  late UploadProduct usecase;

  final tProductEntity = ProductEntity.empty();
  final params = UploadProductParams.empty();
  final serverFailure = ServerFailure(
    message: 'Failed to upload product',
    statusCode: 500,
  );

  setUp(() {
    repo = MockProductManagerRepo();
    usecase = UploadProduct(repo);
  });
  group('Upload Product', () {
    test(
      'Should call [ProductManager Repo] and return Right<ProductEntity>',
      () async {
        when(
          () => repo.uploadProduct(
            image: any(named: 'image'),
            deliveryLocation: any(named: 'deliveryLocation'),
            price: any(named: 'price'),
            video: any(named: 'video'),
            sold: any(named: 'sold'),
            quantity: any(named: 'quantity'),
            deliveryTime: any(named: 'deliveryTime'),
            description: any(
              named: 'description',
            ),
            name: any(named: 'name'),
            sellerName: any(named: 'sellerName'),
            sellerEmail: any(named: 'sellerEmail'),
            rating: any(named: 'rating'),
            measurement: any(named: 'measurement'),
            likes: any(named: 'likes'),
            available: any(named: 'available'),
            alwaysAvailable: any(named: 'alwaysAvailable'),
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
          () => repo.uploadProduct(
            image: params.image,
            deliveryLocation: params.deliveryLocation,
            price: params.price,
            video: params.video,
            sold: params.sold,
            quantity: params.quantity,
            deliveryTime: params.deliveryTime,
            description: params.description,
            name: params.name,
            sellerName: params.sellerName,
            sellerEmail: params.sellerEmail,
            rating: params.rating,
            measurement: params.measurement,
            likes: params.likes,
            available: params.available,
            alwaysAvailable: params.alwaysAvailable,
          ),
        ).called(1);
        verifyNoMoreInteractions(repo);
      },
    );

    test(
      'Should call [ProductManager Repo] and return Left<ServerFailure>',
      () async {
        when(
          () => repo.uploadProduct(
            image: any(named: 'image'),
            deliveryLocation: any(named: 'deliveryLocation'),
            price: any(named: 'price'),
            video: any(named: 'video'),
            sold: any(named: 'sold'),
            quantity: any(named: 'quantity'),
            deliveryTime: any(named: 'deliveryTime'),
            description: any(
              named: 'description',
            ),
            name: any(named: 'name'),
            sellerName: any(named: 'sellerName'),
            sellerEmail: any(named: 'sellerEmail'),
            rating: any(named: 'rating'),
            measurement: any(named: 'measurement'),
            likes: any(named: 'likes'),
            available: any(named: 'available'),
            alwaysAvailable: any(named: 'alwaysAvailable'),
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
          () => repo.uploadProduct(
            image: params.image,
            deliveryLocation: params.deliveryLocation,
            price: params.price,
            video: params.video,
            sold: params.sold,
            quantity: params.quantity,
            deliveryTime: params.deliveryTime,
            description: params.description,
            name: params.name,
            sellerName: params.sellerName,
            sellerEmail: params.sellerEmail,
            rating: params.rating,
            measurement: params.measurement,
            likes: params.likes,
            available: params.available,
            alwaysAvailable: params.alwaysAvailable,
          ),
        ).called(1);
        verifyNoMoreInteractions(repo);
      },
    );
  });
}
