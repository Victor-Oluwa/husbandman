import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:husbandman/core/common/app/entities/cart_entity.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/common/app/provider/general_product_provider.dart';
import 'package:husbandman/core/common/app/provider/picked_product_image_provider.dart';
import 'package:husbandman/core/common/app/provider/seller_products_provider.dart';
import 'package:husbandman/core/common/app/provider/user_provider.dart';
import 'package:husbandman/core/common/app/public_methods/cloudinary_upload/cloudinary_upload.dart';
import 'package:husbandman/core/common/app/public_methods/file-picker/file_picker.dart';
import 'package:husbandman/core/common/app/public_methods/file_compressor/file_compressor.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/enums/update_product.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/core/utils/typedef.dart';
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
  );

  final http.Client _client;
  final CloudinaryUpload _cloudinaryUpload;
  final PickFile _pickFile;
  final FileCompressor compressor;
  final Ref _ref;

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
      log('Add to cart Err: ' + responseData.toString());
      return CartEntity.fromMap(responseData);
    } on DioException catch (dioError) {
      log('Dio error asshole: $dioError');
      final errorMessage =
          dioError.response?.data.toString() ?? dioError.message;
      final statusCode = dioError.response?.statusCode ?? 500;
      throw ProductManagerException(
        message: errorMessage!,
        statusCode: statusCode,
      );
    } on ProductManagerException catch(e){
      rethrow;
    }catch (e) {
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
  Future<List<ProductEntity>> deleteProduct(String id) async {
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
          .map(ProductModel.fromMap)
          .toList();

      return products;
    } on ProductManagerException catch (e) {
      rethrow;
    } catch (e) {
      throw ProductManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<ProductEntity>> fetchProducts({
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
          .map((data) => ProductModel.fromMap(data as Map<String, dynamic>))
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
  Future<List<ProductEntity>> fetchProductsByCategory({
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
          .map(ProductModel.fromMap)
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
  Future<List<ProductEntity>> fetchFarmerProducts(String farmerEmail) async {
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
          .map(ProductModel.fromMap)
          .toList();
    } on ProductManagerException catch (e) {
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
    } on CloudinaryException catch (e) {
      rethrow;
    } catch (e) {
      throw CloudinaryException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<ProductEntity> likeProduct(String id) async {
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

      return ProductModel.fromMap(jsonDecode(response.body) as DataMap);
    } on ProductManagerException catch (e) {
      rethrow;
    } catch (e) {
      throw ProductManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<File>> pickProductImage() async {
    try {
      final result = await _pickFile.pickMultiple();

      _ref.read(pickedProductImageProvider.notifier).state = result;

      return result;
    } on FilePickerException catch (e) {
      rethrow;
    } catch (e) {
      throw FilePickerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<ProductEntity> rateProduct(String id) async {
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

      return ProductModel.fromMap(jsonDecode(response.body) as DataMap);
    } on ProductManagerException catch (e) {
      rethrow;
    } catch (e) {
      throw ProductManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<ProductEntity>> searchProduct(
      {required String userId,
      required String query,
      required String searchBy}) async {
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
          .map(ProductModel.fromMap)
          .toList();
    } on ProductManagerException catch (e) {
      rethrow;
    } catch (e) {
      throw ProductManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<ProductModel> setSellerProduct({
    required SetProductType setProductType,
    List<DataMap>? productMap,
    List<ProductModel>? productObject,
  }) async {
    var firstProduct = ProductModel.empty();
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
                .renewList(pProductList: productObject);
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
                .addNewProduct(newProductModel: productObject);
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
                .removeProduct(pScapegoat: productObject);
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
                .replaceProduct(pNewProduct: productObject);
          }

          if (productMap != null) {
            firstProduct = _ref
                .read(sellerProductProvider.notifier)
                .replaceProduct(mNewProduct: productMap);
          }
      }

      return firstProduct;
    } on ProductManagerException catch (e) {
      rethrow;
    } catch (e) {
      throw ProductManagerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> setGeneralProducts({
    required SetProductType setProductType,
    List<DataMap>? productMap,
    List<ProductModel>? productObject,
  }) async {
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
            _ref
                .read(generalProductProvider.notifier)
                .renewList(pProductList: productObject);
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
                .addNewProduct(newProductModel: productObject);
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
                .removeProduct(pScapegoat: productObject);
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
                .replaceProduct(pNewProduct: productObject);
          }

          if (productMap != null) {
            _ref
                .read(generalProductProvider.notifier)
                .replaceProduct(mNewProduct: productMap);
          }
      }
    } on ProductManagerException catch (e) {
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

      return ProductModel.fromMap(jsonDecode(response.body) as DataMap);
    } on ProductManagerException catch (e) {
      rethrow;
    } catch (e) {
      throw ProductManagerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<ProductModel> uploadProduct(
      {required String name,
      required String video,
      required List<String> image,
      required String sellerName,
      required String sellerEmail,
      required bool available,
      required int sold,
      required int quantity,
      required double price,
      required String deliveryTime,
      required String description,
      required String measurement,
      required bool alwaysAvailable,
      required List<String> deliveryLocation,
      required List<int> rating,
      required int likes}) async {
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
          'available': available,
          'sold': sold,
          'quantity': quantity,
          'price': price,
          'deliveryTime': deliveryTime,
          'description': description,
          'measurement': measurement,
          'alwaysAvailable': alwaysAvailable,
          'deliveryLocation': deliveryLocation,
          'rating': rating,
          'likes': likes,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ProductManagerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      log('Printing response: ${response.body}');

      return ProductModel.fromMap(
        DataMap.from(jsonDecode(response.body) as DataMap),
      );
    } on ProductManagerException catch (e) {
      rethrow;
    } catch (e) {
      throw ProductManagerException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
