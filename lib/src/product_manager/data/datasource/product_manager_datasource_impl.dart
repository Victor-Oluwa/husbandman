import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';
import 'package:husbandman/src/product_manager/data/model/product_model.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/general_product_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/seller_products_provider.dart';
import 'package:husbandman/core/common/app/public_methods/cloudinary_upload/cloudinary_upload.dart';
import 'package:husbandman/core/common/app/public_methods/file-picker/file_picker.dart';
import 'package:husbandman/core/common/app/public_methods/file_compressor/file_compressor.dart';
import 'package:husbandman/core/common/app/public_methods/superbase_upload/superbase_upload.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/enums/update_product.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/entity/cart_entity.dart';
import 'package:husbandman/src/product_manager/data/datasource/product_manager_datasource.dart';

const kDeleteProductEndpoint = '/farmer/product/delete';
const kFetchFarmerProductsEndpoint = '/farmer/products';
const kGetProductImageUrlEndpoint = '/product/image-url';
const kLikeProductEndpoint = '/product/like';
const kRateProductEndpoint = '/product/rate';
const kSearchProductEndpoint = '/product/search';
const kUpdateProductEndpoint = '/product/update';
const kUploadProductEndpoint = '/product/upload';
const kFetchProductsEndpoint = '/product/all';
const kFetchProductsByCategoryEndpoint = '/product/category';
const kAddProductToCartEndpoint = '/product/add-to-cart';

class ProductManagerDatasourceImpl implements ProductManagerDatasource {
  const ProductManagerDatasourceImpl(
    this._client,
    this._ref,
    this._cloudinaryUpload,
    this._pickFile,
    this.compressor,
    this._superBaseUpload,
  );

  final http.Client _client;
  final CloudinaryUpload _cloudinaryUpload;
  final PickFile _pickFile;
  final FileCompressor compressor;
  final Ref _ref;
  final SuperBaseUpload _superBaseUpload;

  @override
  Future<CartEntity> addProductToCart({
    required String productId,
    required int quantity,
    required String cartOwnerId,
  }) async {
    try {
      final response = await Dio().post<DataMap>(
        '$kBaseUrl$kAddProductToCartEndpoint',
        data: jsonEncode({
          'productId': productId,
          'quantity': quantity,
          'cartOwnerId': cartOwnerId,
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      final responseData = response.data;

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ProductManagerException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }

      if (responseData == null) {
        throw ProductManagerException(
          message: 'Operation returned null',
          statusCode: response.statusCode ?? 500,
        );
      }
      return CartEntity.fromJson(responseData);
    } on DioException catch (dioError) {

      if (dioError.response != null) {
        throw ProductManagerException(
          message: dioError.response?.data.toString() ?? '',
          statusCode: 500,
        );
      } else {
        throw ProductManagerException(
          message: dioError.message ?? '',
          statusCode: 500,
        );
      }
    } on ProductManagerException {
      rethrow;
    } catch (e) {
      throw ProductManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<Uint8List?>> compressProductImage(List<File> images) async {
    try {
      final result = await compressor.compressFile(images);
      return result;
    } on CompressorException catch (_) {
      rethrow;
    } catch (e) {
      throw CompressorException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<List<ProductModel>> deleteProduct(String id) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kDeleteProductEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'productId': id,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ProductManagerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      final products = List<DataMap>.from(jsonDecode(response.body) as List)
          .map(ProductModel.fromJson)
          .toList();

      return products;
    } on ProductManagerException {
      rethrow;
    } catch (e) {
      throw ProductManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<ProductModel>> fetchProducts({
    required int limit,
    required List<String> fetched,
  }) async {
    try {
      final response = await Dio()
          .post<List<dynamic>>(
            '$kBaseUrl$kFetchProductsEndpoint',
            data: jsonEncode({
              'limit': limit,
              'fetched': fetched,
            }),
            options: Options(
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
            ),
          )
          .timeout(const Duration(seconds: 30));

      final responseData = response.data;

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ProductManagerException(
          message: response.data.toString(),
          statusCode: response.statusCode!,
        );
      }

      if (responseData == null) {
        throw const ProductManagerException(
          message: 'The response was empty',
          statusCode: 500,
        );
      }

      return responseData
          .map((data) => ProductModel.fromJson(data as Map<String, dynamic>))
          .toList();
    } on ProductManagerException catch (e) {
      log('Fetch product error: ${e.message}');
      rethrow;
    } catch (e) {
      log('Fetch product error: $e');
      throw ProductManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<ProductModel>> fetchProductsByCategory({
    required String category,
    required int limit,
    required List<String> fetched,
  }) async {
    try {
      log('Check 1');

      final response = await Dio().post<List<dynamic>>(
        '$kBaseUrl$kFetchProductsByCategoryEndpoint',
        data: {
          'limit': limit,
          'fetched': fetched,
          'category': category,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      log('Check 2');

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ProductManagerException(
          message: response.data.toString(),
          statusCode: response.statusCode!,
        );
      }

      return List<DataMap>.from(response.data!)
          .map(ProductModel.fromJson)
          .toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw ProductManagerException(
          message: e.response!.data.toString(),
          statusCode: e.response!.statusCode!,
        );
      } else {
        throw ProductManagerException(
          message: e.message ?? '',
          statusCode: 500,
        );
      }
    } catch (e) {
      throw ProductManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<ProductModel>> fetchFarmerProducts(String farmerEmail) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kFetchFarmerProductsEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'farmerEmail': farmerEmail}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ProductManagerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map(ProductModel.fromJson)
          .toList();
    } on ProductManagerException {
      rethrow;
    } catch (e) {
      throw ProductManagerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<List<String>> getProductImageUrl({
    required String sellerName,
    required bool isByte,
    List<Uint8List?>? compressedFile,
    List<File>? file,
  }) async {
    try {
      if (isByte && compressedFile == null) {
        throw const CloudinaryException(
          message: 'Compressed file cannot be null when isByte is set to true',
          statusCode: 202,
        );
      }
      if (!isByte && file == null) {
        throw const CloudinaryException(
          message: 'file cannot be null when isByte is set to false',
          statusCode: 202,
        );
      }

      if (file == null && compressedFile == null) {
        throw const CloudinaryException(
          message: 'Both "file" and "compressedFile" cannot be null together',
          statusCode: 202,
        );
      }
      if (isByte) {
        return await _cloudinaryUpload.uploadImage(
          compressedFile: compressedFile,
          sellerName: sellerName,
        );
      } else {
        return await _cloudinaryUpload.uploadImageAsFile(
          file: file,
          sellerName: sellerName,
        );
      }
    } on CloudinaryException {
      rethrow;
    } catch (e) {
      throw CloudinaryException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<ProductModel> likeProduct(String id) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kLikeProductEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'productId': id,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ProductManagerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return ProductModel.fromJson(jsonDecode(response.body) as DataMap);
    } on ProductManagerException {
      rethrow;
    } catch (e) {
      throw ProductManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<String>> pickProductImage() async {
    try {
      final result = await _pickFile.pickMultiple();

      return result;
    } on FilePickerException {
      rethrow;
    } catch (e) {
      throw FilePickerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<ProductModel> rateProduct(String id) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kRateProductEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'productId': id,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ProductManagerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return ProductModel.fromJson(jsonDecode(response.body) as DataMap);
    } on ProductManagerException {
      rethrow;
    } catch (e) {
      throw ProductManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<ProductModel>> searchProduct({
    required String userId,
    required String query,
    required String searchBy,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kSearchProductEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'userId': userId,
          'query': query,
          'searchBy': searchBy,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ProductManagerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map(ProductModel.fromJson)
          .toList();
    } on ProductManagerException {
      rethrow;
    } catch (e) {
      throw ProductManagerException(message: e.toString(), statusCode: 500);
    }
  }

  //TODO(): Correct this method
  @override
  Future<ProductModel> setSellerProduct({
    required SetProductType setProductType,
    List<DataMap>? productMap,
    List<ProductEntity>? productObject,
  }) async {
    var productModel = <ProductModel>[];
    if (productObject != null) {
      productModel =
          productObject.map((entity) => entity as ProductModel).toList();
    }
    var firstProduct = ProductModel.empty;
    try {
      if (productMap == null && productObject == null) {
        throw const ProductManagerException(
          message: 'Both product map and product object cannot be null',
          statusCode: 404,
        );
      }
      switch (setProductType) {
        case SetProductType.renew:
          if (productObject != null) {
            firstProduct = _ref
                .read(sellerProductProvider.notifier)
                .renewList(pProductList: productModel);
          }

          if (productMap != null) {
            firstProduct = _ref
                .read(sellerProductProvider.notifier)
                .renewList(mProductList: productMap);
          }
        case SetProductType.insertNew:
          if (productObject != null) {
            firstProduct = _ref
                .read(sellerProductProvider.notifier)
                .addNewProduct(newProductModel: productModel);
          }

          if (productMap != null) {
            firstProduct = _ref
                .read(sellerProductProvider.notifier)
                .addNewProduct(newProductMap: productMap);
          }
        case SetProductType.remove:
          if (productObject != null) {
            firstProduct = _ref
                .read(sellerProductProvider.notifier)
                .removeProduct(pScapegoat: productModel);
          }

          if (productMap != null) {
            firstProduct = _ref
                .read(sellerProductProvider.notifier)
                .removeProduct(mScapeGoat: productMap);
          }
        case SetProductType.replace:
          if (productObject != null) {
            firstProduct = _ref
                .read(sellerProductProvider.notifier)
                .replaceProduct(pNewProduct: productModel);
          }

          if (productMap != null) {
            firstProduct = _ref
                .read(sellerProductProvider.notifier)
                .replaceProduct(mNewProduct: productMap);
          }
      }

      return firstProduct;
    } on ProductManagerException {
      rethrow;
    } catch (e) {
      throw ProductManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> setGeneralProducts({
    required SetProductType setProductType,
    List<DataMap>? productMap,
    List<ProductEntity>? productObject,
  }) async {
    try {
      var productModel = <ProductModel>[];
      if (productObject != null) {
        productModel =
            productObject.map((entity) => entity as ProductModel).toList();
      }
      if (productMap == null && productObject == null) {
        throw const ProductManagerException(
          message: 'Both product map and product object cannot be null',
          statusCode: 404,
        );
      }
      switch (setProductType) {
        case SetProductType.renew:
          if (productObject != null) {
            _ref
                .read(generalProductProvider.notifier)
                .renewList(pProductList: productModel);
          }

          if (productMap != null) {
            _ref
                .read(generalProductProvider.notifier)
                .renewList(mProductList: productMap);
          }
        case SetProductType.insertNew:
          if (productObject != null) {
            _ref
                .read(generalProductProvider.notifier)
                .addNewProduct(newProductModel: productModel);
          }

          if (productMap != null) {
            _ref
                .read(generalProductProvider.notifier)
                .addNewProduct(newProductMap: productMap);
          }
        case SetProductType.remove:
          if (productObject != null) {
            _ref
                .read(generalProductProvider.notifier)
                .removeProduct(pScapegoat: productModel);
          }

          if (productMap != null) {
            _ref
                .read(generalProductProvider.notifier)
                .removeProduct(mScapeGoat: productMap);
          }
        case SetProductType.replace:
          if (productObject != null) {
            _ref
                .read(generalProductProvider.notifier)
                .replaceProduct(pNewProduct: productModel);
          }

          if (productMap != null) {
            _ref
                .read(generalProductProvider.notifier)
                .replaceProduct(mNewProduct: productMap);
          }
      }
    } on ProductManagerException {
      rethrow;
    } catch (e) {
      throw ProductManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<ProductModel> updateProduct({
    required dynamic newData,
    required UpdateProductCulprit culprit,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kUpdateProductEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'newData': newData,
          'culprit': culprit.name,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ProductManagerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return ProductModel.fromJson(jsonDecode(response.body) as DataMap);
    } on ProductManagerException {
      rethrow;
    } catch (e) {
      throw ProductManagerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<ProductModel> uploadProduct({
    required String name,
    required String sellerName,
    required String sellerEmail,
    required String sellerId,
    required String video,
    required List<String> image,
    required bool isLive,
    required int quantityAvailable,
    required double price,
    required String deliveryDate,
    required String description,
    required String measurement,
    required bool isAlwaysAvailable,
    required List<String> deliveryLocations,
    required String category,
  }) async {
    /*
    [log] ProductManagerError from ProductUploadBlocConsumerWidget: 500 Error:
     StorageException(message: The resource already exists, statusCode: 409,
     error: Duplicate)

     delete item if deplicate error occures in superbase upload
    */
    log('Passed  name: $name');
    log('Passed  measurement: $measurement');

    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kUploadProductEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': name,
          'video': video,
          'image': image,
          'sellerName': sellerName,
          'sellerEmail': sellerEmail,
          'sellerId': sellerId,
          'quantityAvailable': quantityAvailable,
          'price': price,
          'deliveryDate': deliveryDate,
          'description': description,
          'measurement': measurement,
          'isAlwaysAvailable': isAlwaysAvailable,
          'deliveryLocations': deliveryLocations,
          'category': category,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ProductManagerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      log('Printing response: ${response.body}');

      return ProductModel.fromJson(
        jsonDecode(response.body) as DataMap,
      );
    } on ProductManagerException {
      rethrow;
    } catch (e) {
      throw ProductManagerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<List<String>> getImgUrlFromSupaBase({
    required List<String> filePaths,
    required String folderPath,
  }) async {
    try {
      final response =
          await _superBaseUpload.uploadMultipleImages(filePaths, folderPath);
      if (response.isEmpty) {
        throw const ProductManagerException(
          message: 'Empty List was returned from uploadMultipleImages function',
          statusCode: 500,
        );
      }

      log(
        'Log from ProductManagerDatasourceImpl: getImgUrlFromSupaBase response: $response',
      );
      return response;
    } on SuperBaseException {
      rethrow;
    } on ProductManagerException {
      rethrow;
    } catch (e) {
      throw ProductManagerException(message: e.toString(), statusCode: 500);
    }
  }
}
