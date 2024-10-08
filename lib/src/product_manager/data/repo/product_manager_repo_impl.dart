import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:husbandman/src/product_manager/data/model/product_model.dart';
import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/enums/update_product.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/entity/cart_entity.dart';
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
  ResultFuture<List<ProductModel>> deleteProduct(String id) async {
    try {
      final result = await _productManagerDatasource.deleteProduct(id);
      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductModel>> fetchProducts({
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
  ResultFuture<List<ProductModel>> fetchProductsByCategory({
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
  ResultFuture<List<ProductModel>> fetchFarmerProducts(
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
  ResultFuture<ProductModel> likeProduct(String id) async {
    try {
      final result = await _productManagerDatasource.likeProduct(id);
      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<String>> pickProductImage() async {
    try {
      final result = await _productManagerDatasource.pickProductImage();
      return Right(result);
    } on FilePickerException catch (e) {
      return Left(FilePickerFailure.fromException(e));
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<ProductModel> rateProduct(String id) async {
    try {
      final result = await _productManagerDatasource.rateProduct(id);
      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductModel>> searchProduct({
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
  ResultFuture<ProductModel> setSellerProduct({
    required SetProductType setProductType,
    List<DataMap>? productMap,
    List<ProductEntity>? productObject,
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
    List<ProductEntity>? productObject,
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
  ResultFuture<ProductModel> updateProduct({
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
  ResultFuture<ProductModel> uploadProduct({
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
    try {
      final result = await _productManagerDatasource.uploadProduct(
        name: name,
        sellerName: sellerName,
        sellerEmail: sellerEmail,
        sellerId: sellerId,
        video: video,
        image: image,
        isLive: isLive,
        quantityAvailable: quantityAvailable,
        price: price,
        deliveryDate: deliveryDate,
        description: description,
        measurement: measurement,
        isAlwaysAvailable: isAlwaysAvailable,
        deliveryLocations: deliveryLocations,
        category: category,
      );

      return Right(result);
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<String>> getImgUrlFromSupaBase({
    required List<String> filePaths,
    required String folderPath,
  }) async {
    try {
      final result = await _productManagerDatasource.getImgUrlFromSupaBase(
        filePaths: filePaths,
        folderPath: folderPath,
      );
      return Right(result);
    } on SuperBaseException catch (e) {
      return Left(SuperBaseFailure.fromException(e));
    } on ProductManagerException catch (e) {
      return Left(ProductManagerFailure.fromException(e));
    }
  }
}
