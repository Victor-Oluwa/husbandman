
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';
import 'package:husbandman/src/product_manager/data/model/product_model.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/enums/update_product.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/product_manager/data/datasource/product_manager_datasource.dart';
import 'package:husbandman/src/product_manager/data/repo/product_manager_repo_impl.dart';
import 'package:husbandman/src/product_manager/domain/usecase/get_product_image_url.dart';
import 'package:husbandman/src/product_manager/domain/usecase/upload_product.dart';
import 'package:mocktail/mocktail.dart';

class MockProductManagerDatasource extends Mock
    implements ProductManagerDatasource {}

void main() {
  late ProductManagerDatasource datasource;
  late ProductManagerRepoImpl productManagerRepoImpl;

  const productManagerException = ProductManagerException(
    message: 'Failed to complete task',
    statusCode: 500,
  );

  final productManagerFailure = ProductManagerFailure(
    message: 'Failed to complete task',
    statusCode: 500,
  );

  setUpAll(() {
    registerFallbackValue(SetProductType.renew);
    registerFallbackValue(UpdateProductCulprit.name);
  });

  setUp(() {
    datasource = MockProductManagerDatasource();
    productManagerRepoImpl = ProductManagerRepoImpl(datasource);
  });

  group('Delete Product', () {
    final tProductEntities = [ProductEntity.empty()];
    const tProductId = '726738839333';
    test(
      'Should call [ProductManagerDatasource] and return [Right<ProductEntity>]',
      () async {
        when(() => datasource.deleteProduct(any())).thenAnswer(
          (_) async => tProductEntities,
        );

        final result = await productManagerRepoImpl.deleteProduct(tProductId);
        expect(
          result,
          equals(
            Right<dynamic, List<ProductEntity>>(tProductEntities),
          ),
        );

        verify(() => datasource.deleteProduct(tProductId));
        verifyNoMoreInteractions(datasource);
      },
    );

    test(
      'Should call [ProductManagerDatasource] and return [Right<ProductEntity>]',
      () async {
        when(
          () => datasource.deleteProduct(any()),
        ).thenThrow(
          productManagerException,
        );

        final result = await productManagerRepoImpl.deleteProduct(tProductId);
        expect(
          result,
          equals(
            Left<ProductManagerFailure, dynamic>(productManagerFailure),
          ),
        );

        verify(() => datasource.deleteProduct(tProductId));
        verifyNoMoreInteractions(datasource);
      },
    );
  });

  group('Fetch Farmer Product', () {
    final tProductEntities = [ProductEntity.empty()];
    const farmerEmail = 'email.com';
    test(
      'Should call [ProductManagerDatasource] and return [Right<ProductEntity>]',
      () async {
        when(() => datasource.fetchFarmerProducts(any())).thenAnswer(
          (_) async => tProductEntities,
        );

        final result =
            await productManagerRepoImpl.fetchFarmerProducts(farmerEmail);
        expect(
          result,
          equals(
            Right<dynamic, List<ProductEntity>>(tProductEntities),
          ),
        );

        verify(() => datasource.fetchFarmerProducts(farmerEmail));
        verifyNoMoreInteractions(datasource);
      },
    );

    test(
      'Should call [ProductManagerDatasource] and return [Left<ProductMangerFailure>]',
      () async {
        when(
          () => datasource.fetchFarmerProducts(any()),
        ).thenThrow(
          productManagerException,
        );

        final result =
            await productManagerRepoImpl.fetchFarmerProducts(farmerEmail);
        expect(
          result,
          equals(
            Left<ProductManagerFailure, dynamic>(productManagerFailure),
          ),
        );

        verify(() => datasource.fetchFarmerProducts(farmerEmail));
        verifyNoMoreInteractions(datasource);
      },
    );
  });

  group('Get Product Image Url', () {
    final tImageUrl = ['img-urls'];
    final params = GetProductImageUrlParams.empty();
    const sellerName = 'sellerName';
    const isByte = true;
    test(
      'Should call [ProductManagerDatasource] and return [Right<ProductEntity>]',
      () async {
        when(
          () => datasource.getProductImageUrl(
            compressedFile: any(named: 'compressedFile'),
            sellerName: any(named: 'sellerName'),
            isByte: any(named: 'isByte'),
          ),
        ).thenAnswer(
          (_) async => tImageUrl,
        );

        final result = await productManagerRepoImpl.getProductImageUrl(
          sellerName: sellerName,
          isByte: isByte,
          compressedFile: params.compressedFile,
        );

        expect(
          result,
          equals(
            Right<dynamic, List<String>>(tImageUrl),
          ),
        );

        verify(
          () => datasource.getProductImageUrl(
            compressedFile: params.compressedFile,
            sellerName: sellerName,
            isByte: isByte,
          ),
        );
        verifyNoMoreInteractions(datasource);
      },
    );

    test(
      'Should call [ProductManagerDatasource] and return [Left<ProductMangerFailure>]',
      () async {
        when(
          () => datasource.getProductImageUrl(
            compressedFile: any(named: 'compressedFile'),
            sellerName: any(named: 'sellerName'),
            isByte: any(named: 'isByte'),
          ),
        ).thenThrow(
          const CloudinaryException(
            message: 'Failed to get url',
            statusCode: 500,
          ),
        );

        final result = await productManagerRepoImpl.getProductImageUrl(
          compressedFile: params.compressedFile,
          sellerName: sellerName,
          isByte: isByte,
        );
        expect(
          result,
          equals(
            Left<CloudinaryFailure, dynamic>(
              CloudinaryFailure(
                message: 'Failed to get url',
                statusCode: 500,
              ),
            ),
          ),
        );

        verify(
          () => datasource.getProductImageUrl(
            compressedFile: params.compressedFile,
            sellerName: sellerName,
            isByte: isByte,
          ),
        );
        verifyNoMoreInteractions(datasource);
      },
    );
  });

  group('Like Product', () {
    final productEntity = ProductEntity.empty();
    const tProductId = 'product-id';
    test(
      'Should call [ProductManagerDatasource] and return [Right<ProductEntity>]',
      () async {
        when(
          () => datasource.likeProduct(
            any(),
          ),
        ).thenAnswer(
          (_) async => productEntity,
        );

        final result = await productManagerRepoImpl.likeProduct(
          tProductId,
        );

        expect(
          result,
          equals(
            Right<dynamic, ProductEntity>(productEntity),
          ),
        );

        verify(
          () => datasource.likeProduct(
            tProductId,
          ),
        );
        verifyNoMoreInteractions(datasource);
      },
    );

    test(
      'Should call [ProductManagerDatasource] and return [Left<ProductMangerFailure>]',
      () async {
        when(
          () => datasource.likeProduct(
            any(),
          ),
        ).thenThrow(
          productManagerException,
        );

        final result = await productManagerRepoImpl.likeProduct(
          tProductId,
        );
        expect(
          result,
          equals(
            Left<ProductManagerFailure, dynamic>(productManagerFailure),
          ),
        );

        verify(
          () => datasource.likeProduct(
            tProductId,
          ),
        );
        verifyNoMoreInteractions(datasource);
      },
    );
  });

  group('Pick Product Image', () {
    final imageFiles = ['img-path'];
    test(
      'Should call [ProductManagerDatasource] and return [Right<ProductEntity>]',
      () async {
        when(
          () => datasource.pickProductImage(),
        ).thenAnswer(
          (_) async => imageFiles,
        );

        final result = await productManagerRepoImpl.pickProductImage();

        expect(
          result,
          equals(
            Right<dynamic, List<String>>(imageFiles),
          ),
        );

        verify(
          () => datasource.pickProductImage(),
        );
        verifyNoMoreInteractions(datasource);
      },
    );

    test(
      'Should call [ProductManagerDatasource] and return [Left<ProductMangerFailure>]',
      () async {
        when(
          () => datasource.pickProductImage(),
        ).thenThrow(
          productManagerException,
        );

        final result = await productManagerRepoImpl.pickProductImage();
        expect(
          result,
          equals(
            Left<ProductManagerFailure, dynamic>(productManagerFailure),
          ),
        );

        verify(
          () => datasource.pickProductImage(),
        );
        verifyNoMoreInteractions(datasource);
      },
    );
  });

  group('Rate Product', () {
    final productEntity = ProductEntity.empty();
    const tProductId = 'product-id';
    test(
      'Should call [ProductManagerDatasource] and return [Right<ProductEntity>]',
      () async {
        when(
          () => datasource.rateProduct(
            any(),
          ),
        ).thenAnswer(
          (_) async => productEntity,
        );

        final result = await productManagerRepoImpl.rateProduct(
          tProductId,
        );

        expect(
          result,
          equals(
            Right<dynamic, ProductEntity>(productEntity),
          ),
        );

        verify(
          () => datasource.rateProduct(
            tProductId,
          ),
        );
        verifyNoMoreInteractions(datasource);
      },
    );

    test(
      'Should call [ProductManagerDatasource] and return [Left<ProductMangerFailure>]',
      () async {
        when(
          () => datasource.rateProduct(
            any(),
          ),
        ).thenThrow(
          productManagerException,
        );

        final result = await productManagerRepoImpl.rateProduct(
          tProductId,
        );
        expect(
          result,
          equals(
            Left<ProductManagerFailure, dynamic>(productManagerFailure),
          ),
        );

        verify(
          () => datasource.rateProduct(
            tProductId,
          ),
        );
        verifyNoMoreInteractions(datasource);
      },
    );
  });

  group('Search Product', () {
    final tProductEntities = [ProductEntity.empty()];
    const userId = 'user-id';
    const query = 'query';
    const searchBy = 'none';
    test(
      'Should call [ProductManagerDatasource] and return [Right<ProductEntity>]',
      () async {
        when(
          () => datasource.searchProduct(
            userId: any(named: 'userId'),
            query: any(named: 'query'),
            searchBy: any(named: 'searchBy'),
          ),
        ).thenAnswer(
          (_) async => tProductEntities,
        );

        final result = await productManagerRepoImpl.searchProduct(
          userId: userId,
          query: query,
          searchBy: searchBy,
        );
        expect(
          result,
          equals(
            Right<dynamic, List<ProductEntity>>(tProductEntities),
          ),
        );

        verify(
          () => datasource.searchProduct(
            userId: userId,
            query: query,
            searchBy: searchBy,
          ),
        );
        verifyNoMoreInteractions(datasource);
      },
    );

    test(
      'Should call [ProductManagerDatasource] and return [Left<ProductMangerFailure>]',
      () async {
        when(
          () => datasource.searchProduct(
            userId: any(named: 'userId'),
            query: any(named: 'query'),
            searchBy: any(named: 'searchBy'),
          ),
        ).thenThrow(
          productManagerException,
        );

        final result = await productManagerRepoImpl.searchProduct(
          userId: userId,
          query: query,
          searchBy: searchBy,
        );
        expect(
          result,
          equals(
            Left<ProductManagerFailure, dynamic>(productManagerFailure),
          ),
        );

        verify(
          () => datasource.searchProduct(
            userId: userId,
            query: query,
            searchBy: searchBy,
          ),
        );
        verifyNoMoreInteractions(datasource);
      },
    );
  });

  group('Set Seller Product', () {
    final productEntity = ProductEntity.empty();
    final productObject = [ProductModel.empty()];
    final productMap = [ProductModel.empty().toMap()];
    const setProductType = SetProductType.renew;

    test(
      'Should call [ProductManagerDatasource] and return [Right<ProductEntity>]',
      () async {
        when(
          () => datasource.setSellerProduct(
            productObject: any(named: 'productObject'),
            productMap: any(named: 'productMap'),
            setProductType: any(named: 'setProductType'),
          ),
        ).thenAnswer(
          (_) async => productEntity,
        );

        final result = await productManagerRepoImpl.setSellerProduct(
          productMap: productMap,
          productObject: productObject,
          setProductType: setProductType,
        );

        expect(
          result,
          equals(
            Right<dynamic, ProductEntity>(productEntity),
          ),
        );

        verify(
          () => datasource.setSellerProduct(
            productMap: productMap,
            productObject: productObject,
            setProductType: setProductType,
          ),
        );
        verifyNoMoreInteractions(datasource);
      },
    );

    test(
      'Should call [ProductManagerDatasource] and return [Left<ProductMangerFailure>]',
      () async {
        when(
          () => datasource.setSellerProduct(
            productObject: any(named: 'productObject'),
            productMap: any(named: 'productMap'),
            setProductType: any(named: 'setProductType'),
          ),
        ).thenThrow(
          productManagerException,
        );

        final result = await productManagerRepoImpl.setSellerProduct(
          productMap: productMap,
          productObject: productObject,
          setProductType: setProductType,
        );
        expect(
          result,
          equals(
            Left<ProductManagerFailure, dynamic>(productManagerFailure),
          ),
        );

        verify(
          () => datasource.setSellerProduct(
            productObject: productObject,
            productMap: productMap,
            setProductType: setProductType,
          ),
        );
        verifyNoMoreInteractions(datasource);
      },
    );
  });

  group('Update Product', () {
    final productEntity = ProductEntity.empty();
    const dynamic newData = 'product-id';
    const culprit = UpdateProductCulprit.name;
    test(
      'Should call [ProductManagerDatasource] and return [Right<ProductEntity>]',
      () async {
        when(
          () => datasource.updateProduct(
            newData: any<String>(named: 'newData'),
            culprit: any(named: 'culprit'),
          ),
        ).thenAnswer(
          (_) async => productEntity,
        );

        final result = await productManagerRepoImpl.updateProduct(
          newData: newData,
          culprit: culprit,
        );

        expect(
          result,
          equals(
            Right<dynamic, ProductEntity>(productEntity),
          ),
        );

        verify(
          () => datasource.updateProduct(
            newData: newData,
            culprit: culprit,
          ),
        );
        verifyNoMoreInteractions(datasource);
      },
    );

    test(
      'Should call [ProductManagerDatasource] and return [Left<ProductMangerFailure>]',
      () async {
        when(
          () => datasource.updateProduct(
            culprit: any(named: 'culprit'),
            newData: any<String>(named: 'newData'),
          ),
        ).thenThrow(
          productManagerException,
        );

        final result = await productManagerRepoImpl.updateProduct(
          culprit: culprit,
          newData: newData,
        );
        expect(
          result,
          equals(
            Left<ProductManagerFailure, dynamic>(productManagerFailure),
          ),
        );

        verify(
          () => datasource.updateProduct(
            culprit: culprit,
            newData: newData,
          ),
        );
        verifyNoMoreInteractions(datasource);
      },
    );
  });

  group('Upload Product', () {
    final productEntity = ProductEntity.empty();
    final params = UploadProductParams.empty();
    test(
      'Should call [ProductManagerDatasource] and return [Right<ProductEntity>]',
      () async {
        when(
          () => datasource.uploadProduct(
            image: any(named: 'image'),
            alwaysAvailable: any(named: 'alwaysAvailable'),
            available: any(named: 'available'),
            likes: any(named: 'likes'),
            measurement: any(named: 'measurement'),
            rating: any(named: 'rating'),
            sellerEmail: any(named: 'sellerEmail'),
            sellerName: any(named: 'sellerName'),
            name: any(named: 'name'),
            description: any(named: 'description'),
            deliveryTime: any(named: 'deliveryTime'),
            quantity: any(named: 'quantity'),
            sold: any(named: 'sold'),
            video: any(named: 'video'),
            price: any(named: 'price'),
            deliveryLocation: any(named: 'deliveryLocation'),
          ),
        ).thenAnswer(
          (_) async => productEntity,
        );

        final result = await productManagerRepoImpl.uploadProduct(
          name: params.name,
          video: params.video,
          image: params.image,
          sellerName: params.sellerName,
          sellerEmail: params.sellerEmail,
          available: params.available,
          sold: params.sold,
          quantity: params.quantity,
          price: params.price,
          deliveryTime: params.deliveryTime,
          description: params.description,
          measurement: params.measurement,
          alwaysAvailable: params.alwaysAvailable,
          deliveryLocation: params.deliveryLocation,
          rating: params.rating,
          likes: params.likes,
        );

        expect(
          result,
          equals(
            Right<dynamic, ProductEntity>(productEntity),
          ),
        );

        verify(
          () => datasource.uploadProduct(
            name: params.name,
            video: params.video,
            image: params.image,
            sellerName: params.sellerName,
            sellerEmail: params.sellerEmail,
            available: params.available,
            sold: params.sold,
            quantity: params.quantity,
            price: params.price,
            deliveryTime: params.deliveryTime,
            description: params.description,
            measurement: params.measurement,
            alwaysAvailable: params.alwaysAvailable,
            deliveryLocation: params.deliveryLocation,
            rating: params.rating,
            likes: params.likes,
          ),
        );
        verifyNoMoreInteractions(datasource);
      },
    );

    test(
      'Should call [ProductManagerDatasource] and return [Left<ProductMangerFailure>]',
      () async {
        when(
          () => datasource.uploadProduct(
            image: any(named: 'image'),
            alwaysAvailable: any(named: 'alwaysAvailable'),
            available: any(named: 'available'),
            likes: any(named: 'likes'),
            measurement: any(named: 'measurement'),
            rating: any(named: 'rating'),
            sellerEmail: any(named: 'sellerEmail'),
            sellerName: any(named: 'sellerName'),
            name: any(named: 'name'),
            description: any(named: 'description'),
            deliveryTime: any(named: 'deliveryTime'),
            quantity: any(named: 'quantity'),
            sold: any(named: 'sold'),
            video: any(named: 'video'),
            price: any(named: 'price'),
            deliveryLocation: any(named: 'deliveryLocation'),
          ),
        ).thenThrow(
          productManagerException,
        );

        final result = await productManagerRepoImpl.uploadProduct(
          name: params.name,
          video: params.video,
          image: params.image,
          sellerName: params.sellerName,
          sellerEmail: params.sellerEmail,
          available: params.available,
          sold: params.sold,
          quantity: params.quantity,
          price: params.price,
          deliveryTime: params.deliveryTime,
          description: params.description,
          measurement: params.measurement,
          alwaysAvailable: params.alwaysAvailable,
          deliveryLocation: params.deliveryLocation,
          rating: params.rating,
          likes: params.likes,
        );
        expect(
          result,
          equals(
            Left<ProductManagerFailure, dynamic>(productManagerFailure),
          ),
        );

        verify(
          () => datasource.uploadProduct(
            name: params.name,
            video: params.video,
            image: params.image,
            sellerName: params.sellerName,
            sellerEmail: params.sellerEmail,
            available: params.available,
            sold: params.sold,
            quantity: params.quantity,
            price: params.price,
            deliveryTime: params.deliveryTime,
            description: params.description,
            measurement: params.measurement,
            alwaysAvailable: params.alwaysAvailable,
            deliveryLocation: params.deliveryLocation,
            rating: params.rating,
            likes: params.likes,
          ),
        );
        verifyNoMoreInteractions(datasource);
      },
    );
  });
}
