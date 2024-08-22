import 'dart:io';
import 'dart:typed_data';

import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/enums/update_product.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/entity/cart_entity.dart';

abstract class ProductManagerRepo {
  const ProductManagerRepo();

  ResultFuture<CartEntity> addProductToCart({
    required String productId,
    required int quantity,
    required String cartOwnerId,
  });

  ResultFuture<List<Uint8List?>> compressProductImage(List<File> images);

  ResultFuture<List<ProductEntity>> deleteProduct(String id);

  ResultFuture<List<ProductEntity>> fetchProducts({
    required int limit,
    required List<String> fetched,
  });

  ResultFuture<List<ProductEntity>> fetchProductsByCategory({
    required String category,
    required int limit,
    required List<String> fetched,
  });

  ResultFuture<List<ProductEntity>> fetchFarmerProducts(String farmerEmail);

  ResultFuture<List<String>> getProductImageUrl({
    required String sellerName,
    required bool isByte,
    List<Uint8List?>? compressedFile,
    List<File>? file,
  });

  ResultFuture<ProductEntity> likeProduct(String id);

  ResultFuture<List<String>> pickProductImage();

  ResultFuture<ProductEntity> rateProduct(String id);

  ResultFuture<List<ProductEntity>> searchProduct({
    required String userId,
    required String query,
    required String searchBy,
  });

  ResultFuture<ProductEntity> setSellerProduct({
    required SetProductType setProductType,
    List<DataMap>? productMap,
    List<ProductEntity>? productObject,
  });

  ResultFuture<void> setGeneralProducts({
    required SetProductType setProductType,
    List<DataMap>? productMap,
    List<ProductEntity>? productObject,
  });

  ResultFuture<ProductEntity> updateProduct({
    required dynamic newData,
    required UpdateProductCulprit culprit,
  });

  ResultFuture<List<String>> getImgUrlFromSupaBase({
    required List<String> filePaths,
    required String folderPath,
  });

  ResultFuture<ProductEntity> uploadProduct({
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
