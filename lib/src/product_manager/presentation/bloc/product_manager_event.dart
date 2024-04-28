part of 'product_manager_bloc.dart';

abstract class ProductManagerEvent extends Equatable {
  const ProductManagerEvent();
}

class DeleteProductEvent extends ProductManagerEvent {
  const DeleteProductEvent(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class FetchProductsEvent extends ProductManagerEvent {
  const FetchProductsEvent({required this.limit, required this.skip});

  final int limit;
  final int skip;

  @override
  List<Object> get props => [limit, skip];
}

class FetchProductsByCategoryEvent extends ProductManagerEvent {
  const FetchProductsByCategoryEvent({
    required this.category,
    required this.limit,
    required this.skip,
  });

  final String category;
  final int limit;
  final int skip;

  @override
  List<Object> get props => [category, limit, skip];
}

class FetchFarmerProductsEvent extends ProductManagerEvent {
  const FetchFarmerProductsEvent(this.farmerEmail);

  final String farmerEmail;

  @override
  List<Object> get props => [farmerEmail];
}

class GetProductImageUrlEvent extends ProductManagerEvent {
  const GetProductImageUrlEvent(this.compressedFile);

  final List<Uint8List> compressedFile;

  @override
  List<Object> get props => [compressedFile];
}

class LikeProductEvent extends ProductManagerEvent {
  const LikeProductEvent(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class PickProductImageEvent extends ProductManagerEvent {
  @override
  List<Object> get props => [];
}

class RateProductEvent extends ProductManagerEvent {
  const RateProductEvent(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class SearchProductEvent extends ProductManagerEvent {
  const SearchProductEvent({
    required this.userId,
    required this.query,
    required this.searchBy,
  });

  final String userId;
  final String query;
  final String searchBy;

  @override
  List<Object> get props => [userId, query, searchBy];
}

class SetSellerProductEvent extends ProductManagerEvent {
  const SetSellerProductEvent({
    required this.setProductType,
    this.productMap,
    this.productObject,
  });

  final SetProductType setProductType;
  final List<DataMap>? productMap;
  final List<ProductModel>? productObject;

  @override
  List<Object> get props => [setProductType, productMap!, productObject!];
}

class SetGeneralProductEvent extends ProductManagerEvent {
  const SetGeneralProductEvent({
    required this.setProductType,
    this.productMap,
    this.productObject,
  });

  final SetProductType setProductType;
  final List<DataMap>? productMap;
  final List<ProductModel>? productObject;

  @override
  List<Object> get props => [setProductType, productMap!, productObject!];
}

class UpdateProductEvent extends ProductManagerEvent {
  const UpdateProductEvent({
    required this.newData,
    required this.culprit,
  });

  final dynamic newData;
  final UpdateProductCulprit culprit;

  @override
  List<dynamic> get props => [newData, culprit];
}

class UploadProductEvent extends ProductManagerEvent {
  const UploadProductEvent({
    required this.name,
    required this.video,
    required this.image,
    required this.sellerName,
    required this.sellerEmail,
    required this.available,
    required this.sold,
    required this.quantity,
    required this.price,
    required this.deliveryTime,
    required this.description,
    required this.measurement,
    required this.alwaysAvailable,
    required this.deliveryLocation,
    required this.rating,
    required this.likes,
  });

  final String name;
  final String video;
  final List<String> image;
  final String sellerName;
  final String sellerEmail;
  final bool available;
  final int sold;
  final int quantity;
  final double price;
  final String deliveryTime;
  final String description;
  final String measurement;
  final bool alwaysAvailable;
  final List<String> deliveryLocation;
  final List<int> rating;
  final int likes;

  @override
  List<Object> get props => [
        name,
        video,
        image,
        sellerName,
        sellerEmail,
        available,
        sold,
        quantity,
        price,
        deliveryTime,
        description,
        measurement,
        alwaysAvailable,
        deliveryLocation,
        rating,
        likes,
      ];
}
