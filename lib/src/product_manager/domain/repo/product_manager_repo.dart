import 'dart:io';
import 'dart:typed_data';

import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/enums/update_product.dart';
import 'package:husbandman/core/utils/typedef.dart';

abstract class ProductManagerRepo {
  const ProductManagerRepo();

  ResultFuture<List<Uint8List?>> compressProductImage(List<File> images);

  ResultFuture<List<ProductEntity>> deleteProduct(String id);

  ResultFuture<List<ProductEntity>> fetchProducts({
    required int limit,
    required List<String> fetched,
  });

  ResultFuture<List<ProductEntity>> fetchProductsByCategory({
    required String category,
    required int limit,
    required int skip,
  });

  ResultFuture<List<ProductEntity>> fetchFarmerProducts(String farmerEmail);

  ResultFuture<List<String>> getProductImageUrl({
    required String sellerName,
    required bool isByte,
    List<Uint8List?>? compressedFile,
    List<File>? file,
  });

  ResultFuture<ProductEntity> likeProduct(String id);

  ResultFuture<List<File>> pickProductImage();

  ResultFuture<ProductEntity> rateProduct(String id);

  ResultFuture<List<ProductEntity>> searchProduct({
    required String userId,
    required String query,
    required String searchBy,
  });

  ResultFuture<ProductEntity> setSellerProduct({
    required SetProductType setProductType,
    List<DataMap>? productMap,
    List<ProductModel>? productObject,
  });

  ResultFuture<void> setGeneralProducts({
    required SetProductType setProductType,
    List<DataMap>? productMap,
    List<ProductModel>? productObject,
});

  ResultFuture<ProductEntity> updateProduct({
    required dynamic newData,
    required UpdateProductCulprit culprit,
  });

  ResultFuture<ProductEntity> uploadProduct({
    required String name,
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
    required int likes,
  });
}
