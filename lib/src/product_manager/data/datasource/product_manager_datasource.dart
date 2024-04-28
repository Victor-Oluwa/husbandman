import 'dart:io';
import 'dart:typed_data';

import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/enums/update_product.dart';
import 'package:husbandman/core/utils/typedef.dart';

abstract class ProductManagerDatasource {
  const ProductManagerDatasource();

  Future<List<ProductEntity>> deleteProduct(String id);

  Future<List<ProductEntity>> fetchProducts({
    required int limit,
    required int skip,
  });

  Future<List<ProductEntity>> fetchProductsByCategory({
    required String category,
    required int limit,
    required int skip,
  });

  Future<List<ProductEntity>> fetchFarmerProducts(String farmerEmail);

  Future<List<String>> getProductImageUrl({
    required List<Uint8List> compressedFile,
  });

  Future<ProductEntity> likeProduct(String id);

  Future<List<File>> pickProductImage();

  Future<ProductEntity> rateProduct(String id);

  Future<List<ProductEntity>> searchProduct({
    required String userId,
    required String query,
    required String searchBy,
  });

  Future<ProductEntity> setSellerProduct({
    required SetProductType setProductType,
    List<DataMap>? productMap,
    List<ProductModel>? productObject,
  });

  Future<void> setGeneralProducts({
    required SetProductType setProductType,
    List<DataMap>? productMap,
    List<ProductModel>? productObject,
  });

  Future<ProductEntity> updateProduct({
    required dynamic newData,
    required UpdateProductCulprit culprit,
  });

  Future<ProductEntity> uploadProduct({
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
