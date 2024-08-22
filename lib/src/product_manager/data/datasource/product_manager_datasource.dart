import 'dart:io';
import 'dart:typed_data';

import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/enums/update_product.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/entity/cart_entity.dart';
import 'package:husbandman/src/product_manager/data/model/product_model.dart';
import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';

abstract class ProductManagerDatasource {
  const ProductManagerDatasource();

  Future<CartEntity> addProductToCart({
    required String productId,
    required int quantity,
    required String cartOwnerId,
  });

  Future<List<Uint8List?>> compressProductImage(List<File> images);

  Future<List<ProductModel>> deleteProduct(String id);

  Future<List<ProductModel>> fetchProducts({
    required int limit,
    required List<String> fetched,
  });

  Future<List<ProductModel>> fetchProductsByCategory({
    required String category,
    required int limit,
    required List<String> fetched,
  });

  Future<List<ProductModel>> fetchFarmerProducts(String farmerEmail);

  Future<List<String>> getProductImageUrl({
    required String sellerName,
    required bool isByte,
    List<Uint8List?>? compressedFile,
    List<File>? file,
  });

  Future<List<String>> getImgUrlFromSupaBase({
    required List<String> filePaths,
    required String folderPath,
  });

  Future<ProductModel> likeProduct(String id);

  Future<List<String>> pickProductImage();

  Future<ProductModel> rateProduct(String id);

  Future<List<ProductModel>> searchProduct({
    required String userId,
    required String query,
    required String searchBy,
  });

  Future<ProductModel> setSellerProduct({
    required SetProductType setProductType,
    List<DataMap>? productMap,
    List<ProductEntity>? productObject,
  });

  Future<void> setGeneralProducts({
    required SetProductType setProductType,
    List<DataMap>? productMap,
    List<ProductEntity>? productObject,
  });

  Future<ProductModel> updateProduct({
    required dynamic newData,
    required UpdateProductCulprit culprit,
  });

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
  });
}
