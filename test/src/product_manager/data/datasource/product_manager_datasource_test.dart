import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/common/app/provider/seller_products_provider.dart';
import 'package:husbandman/core/common/app/public_methods/cloudinary_upload/cloudinary_upload.dart';
import 'package:husbandman/core/common/app/public_methods/file-picker/file_picker.dart';
import 'package:husbandman/core/common/app/public_methods/file_compressor/file_compressor.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/enums/update_product.dart';
import 'package:husbandman/core/enums/update_user.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/src/product_manager/data/datasource/product_manager_datasource.dart';
import 'package:husbandman/src/product_manager/data/datasource/product_manager_datasource_impl.dart';
import 'package:husbandman/src/product_manager/domain/usecase/upload_product.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockCloudinaryUpload extends Mock implements CloudinaryUpload {}

class MockFilePicker extends Mock implements PickFile {}

class MockFileCompressor extends Mock implements FileCompressor {}

class MockRiverpod extends Mock implements Ref {}

void main() {
  late http.Client client;
  late Ref ref;
  late ProductManagerDatasource datasource;
  late CloudinaryUpload cloudinaryUpload;
  late PickFile pickFile;
  late FileCompressor compressor;

  const exceptionMessage = 'Something went wrong';
  const exceptionStatus = 500;

  const productManagerException = ProductManagerException(
      message: exceptionMessage, statusCode: exceptionStatus);

  setUp(() {
    client = MockHttpClient();
    ref = MockRiverpod();
    cloudinaryUpload = MockCloudinaryUpload();
    pickFile = MockFilePicker();
    compressor = MockFileCompressor();
    datasource = ProductManagerDatasourceImpl(
      client,
      ref,
      cloudinaryUpload,
      pickFile,
      compressor,
    );
  });

  setUpAll(() {
    registerFallbackValue(Uri());
    registerFallbackValue(SetProductType.renew);
    registerFallbackValue(UpdateUserCulprit.values);
  });

  group('Compress Product Image', () {
    final uint8List1 = [
      Uint8List.fromList([1, 2, 3, 4, 5])
    ];
    final tFiles = [File('image_path')];
    test(
      'Should call [FileCompressor]',
      () async {
        when(
          () => compressor.compressFile(
            any(),
          ),
        ).thenAnswer(
          (_) async => uint8List1,
        );

        final result = await datasource.compressProductImage(tFiles);
        expect(result, equals(uint8List1));

        verify(() => compressor.compressFile(tFiles)).called(1);
        verifyNoMoreInteractions(compressor);
      },
    );

    test(
      'Should throw [Product Manager Exception] if compression fails',
      () async {
        when(() => compressor.compressFile(any())).thenThrow(
          const CompressorException(
              message: 'Failed to compress', statusCode: 500),
        );

        final methodCall = datasource.compressProductImage;
        expect(methodCall(tFiles), throwsA(isA<CompressorException>()));

        verify(() => compressor.compressFile(tFiles)).called(1);
        verifyNoMoreInteractions(compressor);
      },
    );
  });

  group('Delete Product', () {
    const productId = 'product-id';
    final productEntities = [ProductModel.empty().toMap()];
    final productList = [ProductModel.empty()];
    test(
      'Should call [Client]  and return status code or [200] or [201] when successful',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(jsonEncode(productEntities), 200),
        );

        final result = await datasource.deleteProduct(productId);
        expect(result, equals(productList));

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kDeleteProductEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({'productId': productId}),
          ),
        );

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should return call [Client] and return status code of [200] or [201] when successful',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response('Something went wrong', 500),
        );

        final methodCall = datasource.deleteProduct;
        expect(
          () => methodCall(productId),
          equals(
            throwsA(productManagerException),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kDeleteProductEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({'productId': productId}),
          ),
        );

        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Fetch Products', () {
    final productsMap = [ProductModel.empty().toMap()];
    final productModel = [ProductModel.empty()];

    const fetched = ['Hey'];
    const limit = 20;
    test(
      'Should call [Client] and return status code of [200] or [201] when successful',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(jsonEncode(productsMap), 200),
        );

        final result = await datasource.fetchProducts(
          limit: limit,
          fetched: fetched,
        );
        expect(result, equals(productModel));

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kFetchProductsEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
              {'limit': limit, 'fetched': fetched},
            ),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should call [Client] and throw ProductManagerException when unsuccessful',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(exceptionMessage, exceptionStatus),
        );

        final methodCall = datasource.fetchProducts;
        expect(
          methodCall(limit: limit, fetched: fetched),
          throwsA(productManagerException),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kFetchProductsEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
              {'limit': limit, 'fetched': fetched},
            ),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Fetch Products By Category', () {
    final productsMap = [ProductModel.empty().toMap()];
    final productModel = [ProductModel.empty()];

    const fetched = ['empty.fetched'];
    const limit = 20;
    const category = 'Rice';
    test(
      'Should call [Client] and return status code of [200] or [201] when successful',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(jsonEncode(productsMap), 200),
        );

        final result = await datasource.fetchProductsByCategory(
          limit: limit,
          fetched: fetched,
          category: category,
        );
        expect(result, equals(productModel));

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kFetchProductsByCategoryEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
              {
                'limit': limit,
                'fetched': fetched,
                'category': category,
              },
            ),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should call [Client] and throw ProductManagerException when unsuccessful',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(exceptionMessage, exceptionStatus),
        );

        final methodCall = datasource.fetchProductsByCategory;
        expect(
          methodCall(category: category, limit: limit, fetched: fetched),
          throwsA(productManagerException),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kFetchProductsByCategoryEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
              {
                'limit': limit,
                'fetched': fetched,
                'category': category,
              },
            ),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Fetch Farmer Product', () {
    const farmerEmail = 'farmeremail@gmail.com';
    final productsAsMap = [ProductModel.empty().toMap()];
    final productsAsModel = [ProductModel.empty()];

    test(
      'Should call [client] and return status code of [200] or [201] when successful',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(jsonEncode(productsAsMap), 200),
        );

        final result = await datasource.fetchFarmerProducts(farmerEmail);
        expect(result, equals(productsAsModel));

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kFetchFarmerProductsEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'farmerEmail': farmerEmail,
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should throw [ProductManagerException when status code is not [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response('Something went wrong', 500),
        );

        final methodCall = datasource.fetchFarmerProducts;
        expect(
          methodCall(farmerEmail),
          throwsA(productManagerException),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kFetchFarmerProductsEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'farmerEmail': farmerEmail,
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Get Product Image Url', () {
    final unit8List = [
      Uint8List.fromList([0, 2, 5, 7, 42, 255]),
    ];
    const imageUrls = ['image-url'];
    const sellerName = 'seller name';
    const isByte = true;

    test(
      'Should call [Cloudinary Upload return List<String> when successful]',
      () async {
        when(
          () => cloudinaryUpload.uploadImage(
            compressedFile: any(named: 'compressedFile'),
            sellerName: any(named: 'sellerName'),
          ),
        ).thenAnswer((_) async => imageUrls);

        final result = await datasource.getProductImageUrl(
          sellerName: sellerName,
          compressedFile: unit8List,
          isByte: isByte,
        );
        expect(result, equals(imageUrls));

        verify(
          () => cloudinaryUpload.uploadImage(
            compressedFile: unit8List,
            sellerName: sellerName,
          ),
        ).called(1);
        verifyNoMoreInteractions(cloudinaryUpload);
      },
    );

    test(
      'Should call [Cloudinary Upload throw [CloudinaryException] when unsuccessful]',
      () async {
        when(
          () => cloudinaryUpload.uploadImage(
            compressedFile: any(named: 'compressedFile'),
            sellerName: any(named: 'sellerName'),
          ),
        ).thenThrow(
          const CloudinaryException(
            message: 'Failed to get url',
            statusCode: 500,
          ),
        );

        final methodCall = datasource.getProductImageUrl;
        expect(
          methodCall(
            compressedFile: unit8List,
            sellerName: sellerName,
            isByte: isByte,
          ),
          throwsA(
            const CloudinaryException(
              message: 'Failed to get url',
              statusCode: 500,
            ),
          ),
        );

        verify(
          () => cloudinaryUpload.uploadImage(
            compressedFile: unit8List,
            sellerName: sellerName,
          ),
        ).called(1);
        verifyNoMoreInteractions(cloudinaryUpload);
      },
    );
  });

  group('Like Product', () {
    final product = ProductModel.empty();
    const productId = 'product-Id';

    test(
      'Should call [Client] and return status code [200] or [201] when successful',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            jsonEncode(product.toMap()),
            200,
          ),
        );

        final result = await datasource.likeProduct(productId);
        expect(result, equals(product));

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kLikeProductEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
              {
                'productId': productId,
              },
            ),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should call [Client] and throw ProductManagerException when unsuccessful',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenThrow(productManagerException);

        final methodCall = datasource.likeProduct;
        expect(methodCall(productId), throwsA(productManagerException));

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kLikeProductEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'productId': productId,
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Pick Product Image', () {
    final imageFiles = [File('file_path')];

    test(
      'Should call [File Picker] and return List<File> when successful',
      () async {
        when(() => pickFile.pickMultiple()).thenAnswer((_) async => imageFiles);

        final result = await datasource.pickProductImage();
        expect(result, equals(imageFiles));

        verify(() => pickFile.pickMultiple()).called(1);
        verifyNoMoreInteractions(pickFile);
      },
    );

    test(
      'Should call [File Picker] and return List<File> when successful',
      () async {
        when(() => pickFile.pickMultiple()).thenThrow(
          const FilePickerException(
            message: 'Failed to pick file',
            statusCode: 500,
          ),
        );

        final methodCall = datasource.pickProductImage;
        expect(
            methodCall(),
            throwsA(
              const FilePickerException(
                message: 'Failed to pick file',
                statusCode: 500,
              ),
            ));

        verify(() => pickFile.pickMultiple()).called(1);
        verifyNoMoreInteractions(pickFile);
      },
    );
  });

  group('Rate Product', () {
    final product = ProductModel.empty();
    const productId = 'product-Id';

    test(
      'Should call [Client] and return status code [200] or [201] when successful',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            jsonEncode(product.toMap()),
            200,
          ),
        );

        final result = await datasource.rateProduct(productId);
        expect(result, equals(product));

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kRateProductEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(
              {
                'productId': productId,
              },
            ),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should call [Client] and throw ProductManagerException when unsuccessful',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(exceptionMessage, exceptionStatus),
        );

        final methodCall = datasource.rateProduct;
        expect(methodCall(productId), throwsA(productManagerException));

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kRateProductEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'productId': productId,
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Search Product', () {
    final productsAsMaps = [ProductModel.empty().toMap()];
    final productsAsModel = [ProductModel.empty()];
    const userId = 'user-id';
    const query = 'Rice';
    const searchBy = 'name';
    test(
      'Should call [Client]  and return status code of [200] or [201] when successful',
      () async {
        when(
          () => client.post(
            any(),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(jsonEncode(productsAsMaps), 200),
        );

        final result = await datasource.searchProduct(
          userId: userId,
          query: query,
          searchBy: searchBy,
        );
        expect(result, equals(productsAsModel));

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kSearchProductEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'userId': userId,
              'query': query,
              'searchBy': searchBy,
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should call [Client] and return status code of [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(exceptionMessage, exceptionStatus),
        );

        final methodCall = datasource.searchProduct;
        expect(
          methodCall(userId: userId, query: query, searchBy: searchBy),
          throwsA(productManagerException),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kSearchProductEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'userId': userId,
              'query': query,
              'searchBy': searchBy,
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Set Seller Product', () {
    final products = [ProductModel.empty()];
    final product = ProductModel.empty();
    const setProductType = SetProductType.renew;

    // test(
    //   'Should call [Ref] and return [SellerProductNotifier] when successful',
    //   () async {
    //     when(
    //       () => ref.read(sellerProductProvider.notifier).renewList(
    //             pProductList: any(named: 'pProductList'),
    //             mProductList: any(named: 'mProductList'),
    //           ),
    //     );
    //
    //     await datasource.setSellerProduct(productObject: products);
    //
    //     verify(
    //       () => ref.read(sellerProductProvider.notifier).renewList(
    //             pProductList: products,
    //           ),
    //     ).called(1);
    //     verifyNoMoreInteractions(ref);
    //   },
    // );

    test(
      'Should call [Ref] and throw [ProductManagerException] when unsuccessful',
      () async {
        when(
          () => ref.read(sellerProductProvider.notifier).renewList(
                pProductList: any(named: 'pProductList'),
                mProductList: any(named: 'mProductList'),
              ),
        ).thenThrow(Exception());

        final methodCall = datasource.setSellerProduct;
        expect(
          methodCall(productObject: products, setProductType: setProductType),
          throwsA(
            isA<ProductManagerException>(),
          ),
        );
      },
    );
  });

  group('Update Product', () {
    const newData = 20000;
    const culprit = UpdateProductCulprit.price;
    final productMap = ProductModel.empty().toMap();
    final productResult = ProductModel.empty();
    test(
      'Should call [Client] and return status code [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(productMap), 200));

        final result = await datasource.updateProduct(
          newData: newData,
          culprit: culprit,
        );
        expect(result, equals(productResult));

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kUpdateProductEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'newData': newData,
              'culprit': culprit.name,
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should call [Client] and throw ProductManagerException when unsuccessful',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(exceptionMessage, exceptionStatus),
        );

        final methodCall = datasource.updateProduct;
        expect(
          methodCall(newData: newData, culprit: culprit),
          throwsA(productManagerException),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kUpdateProductEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'newData': newData,
              'culprit': culprit.name,
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Upload Product', () {
    final params = UploadProductParams.empty();
    const newData = 20000;
    const culprit = UpdateProductCulprit.price;
    final productMap = ProductModel.empty().toMap();
    final productResult = ProductModel.empty();
    test(
      'Should call [Client] and return status code [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(productMap), 200));

        final result = await datasource.uploadProduct(
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
        expect(result, equals(productResult));

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kUploadProductEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'name': params.name,
              'video': params.video,
              'image': params.image,
              'sellerName': params.sellerName,
              'sellerEmail': params.sellerEmail,
              'available': params.available,
              'sold': params.sold,
              'quantity': params.quantity,
              'price': params.price,
              'deliveryTime': params.deliveryTime,
              'description': params.description,
              'measurement': params.measurement,
              'alwaysAvailable': params.alwaysAvailable,
              'deliveryLocation': params.deliveryLocation,
              'rating': params.rating,
              'likes': params.likes,
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should call [Client] and throw ProductManagerException when unsuccessful',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(exceptionMessage, exceptionStatus),
        );

        final methodCall = datasource.uploadProduct;
        expect(
          methodCall(
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
          throwsA(productManagerException),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kUploadProductEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'name': params.name,
              'video': params.video,
              'image': params.image,
              'sellerName': params.sellerName,
              'sellerEmail': params.sellerEmail,
              'available': params.available,
              'sold': params.sold,
              'quantity': params.quantity,
              'price': params.price,
              'deliveryTime': params.deliveryTime,
              'description': params.description,
              'measurement': params.measurement,
              'alwaysAvailable': params.alwaysAvailable,
              'deliveryLocation': params.deliveryLocation,
              'rating': params.rating,
              'likes': params.likes,
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });
}
