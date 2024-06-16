import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:husbandman/core/common/app/entities/cart_entity.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/enums/update_product.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/data/datasource/product_manager_datasource.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class ProductManagerRepoImpl implements ProductManagerRepo {
  ProductManagerRepoImpl(this._productManagerDatasource);

  final ProductManagerDatasource _productManagerDatasource;

  @override
  ResultFuture<CartEntity> addProductToCart({
    required String productId,
    required int quantity,
    required String cartOwnerId,
  }) async {
    try {
      final result = await _productManagerDatasource.addProductToCart(
        productId: productId,
        quantity: quantity,
        cartOwnerId: cartOwnerId,
      );
      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Uint8List?>> compressProductImage(List<File> images) async {
    try {
      final result =
          await _productManagerDatasource.compressProductImage(images);
      return Right(result);
    } on CompressorException catch (e) {
      return Left(CompressorFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductEntity>> deleteProduct(String id) async {
    try {
      final result = await _productManagerDatasource.deleteProduct(id);
      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductEntity>> fetchProducts({
    required int limit,
    required List<String> fetched,
  }) async {
    try {
      final result = await _productManagerDatasource.fetchProducts(
        limit: limit,
        fetched: fetched,
      );
      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(
        ProductManagerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<List<ProductEntity>> fetchProductsByCategory({
    required String category,
    required int limit,
    required List<String> fetched,
  }) async {
    try {
      final result = await _productManagerDatasource.fetchProductsByCategory(
        category: category,
        limit: limit,
        fetched: fetched,
      );
      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductEntity>> fetchFarmerProducts(
    String farmerEmail,
  ) async {
    try {
      final result =
          await _productManagerDatasource.fetchFarmerProducts(farmerEmail);
      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<String>> getProductImageUrl({
    required String sellerName,
    required bool isByte,
    List<Uint8List?>? compressedFile,
    List<File>? file,
  }) async {
    try {
      final result = await _productManagerDatasource.getProductImageUrl(
        sellerName: sellerName,
        isByte: isByte,
        compressedFile: compressedFile,
        file: file,
      );

      return Right(result);
    } on CloudinaryException catch (e) {
      return Left(CloudinaryFailure.fromException(e));
    }
  }

  @override
  ResultFuture<ProductEntity> likeProduct(String id) async {
    try {
      final result = await _productManagerDatasource.likeProduct(id);
      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<File>> pickProductImage() async {
    try {
      final result = await _productManagerDatasource.pickProductImage();
      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<ProductEntity> rateProduct(String id) async {
    try {
      final result = await _productManagerDatasource.rateProduct(id);
      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductEntity>> searchProduct({
    required String userId,
    required String query,
    required String searchBy,
  }) async {
    try {
      final result = await _productManagerDatasource.searchProduct(
        userId: userId,
        query: query,
        searchBy: searchBy,
      );
      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<ProductEntity> setSellerProduct({
    required SetProductType setProductType,
    List<DataMap>? productMap,
    List<ProductModel>? productObject,
  }) async {
    try {
      final result = await _productManagerDatasource.setSellerProduct(
        productMap: productMap,
        productObject: productObject,
        setProductType: setProductType,
      );
      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> setGeneralProducts({
    required SetProductType setProductType,
    List<DataMap>? productMap,
    List<ProductModel>? productObject,
  }) async {
    try {
      await _productManagerDatasource.setGeneralProducts(
        productMap: productMap,
        productObject: productObject,
        setProductType: setProductType,
      );
      return const Right(null);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<ProductEntity> updateProduct({
    required dynamic newData,
    required UpdateProductCulprit culprit,
  }) async {
    try {
      final result = await _productManagerDatasource.updateProduct(
        newData: newData,
        culprit: culprit,
      );
      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
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
  }) async {
    try {
      final result = await _productManagerDatasource.uploadProduct(
        name: name,
        video: video,
        image: image,
        sellerName: sellerName,
        sellerEmail: sellerEmail,
        available: available,
        sold: sold,
        quantity: quantity,
        price: price,
        deliveryTime: deliveryTime,
        description: description,
        measurement: measurement,
        alwaysAvailable: alwaysAvailable,
        deliveryLocation: deliveryLocation,
        rating: rating,
        likes: likes,
      );

      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }
}
