part of 'product_manager_bloc.dart';

abstract class ProductManagerEvent extends Equatable {
  const ProductManagerEvent();
}

class CompressProductImagesEvent extends ProductManagerEvent {
  const CompressProductImagesEvent(this.files);

  final List<File> files;

  @override
  List<Object> get props => [files];
}

class AddProductToCartEvent extends ProductManagerEvent {
  const AddProductToCartEvent({
    required this.productId,
    required this.quantity,
    required this.cartOwnerId,
  });

  final String productId;
  final int quantity;
  final String cartOwnerId;

  @override
  List<dynamic> get props => [productId, quantity];
}

class DeleteProductEvent extends ProductManagerEvent {
  const DeleteProductEvent(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class FetchProductsEvent extends ProductManagerEvent {
  const FetchProductsEvent({required this.limit, required this.fetched});

  final int limit;
  final List<String> fetched;

  @override
  List<Object> get props => [limit, fetched];
}

class FetchProductsByCategoryEvent extends ProductManagerEvent {
  const FetchProductsByCategoryEvent({
    required this.category,
    required this.limit,
    required this.fetched,
  });

  final String category;
  final int limit;
  final List<String> fetched;

  @override
  List<Object> get props => [category, limit, fetched];
}

class FetchFarmerProductsEvent extends ProductManagerEvent {
  const FetchFarmerProductsEvent(this.farmerEmail);

  final String farmerEmail;

  @override
  List<Object> get props => [farmerEmail];
}

class GetProductImageUrlEvent extends ProductManagerEvent {
  const GetProductImageUrlEvent({
    required this.sellerName,
    required this.isByte,
    this.compressedFile,
    this.file,
  });

  final List<Uint8List?>? compressedFile;
  final List<File>? file;
  final String sellerName;
  final bool isByte;

  @override
  List<Object?> get props => isByte == true ? [compressedFile] : [file];
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

class GetImgUrlFromSupaBaseEvent extends ProductManagerEvent {
  const GetImgUrlFromSupaBaseEvent({
    required this.filePaths,
    required this.folderPath,
  });

  final List<String> filePaths;
  final String folderPath;

  @override
  List<dynamic> get props => [folderPath, filePaths];
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
    required this.sellerName,
    required this.sellerEmail,
    required this.sellerId,
    required this.video,
    required this.image,
    required this.isLive,
    required this.quantityAvailable,
    required this.price,
    required this.deliveryDate,
    required this.description,
    required this.measurement,
    required this.isAlwaysAvailable,
    required this.deliveryLocations,
    required this.category,
  });

  const UploadProductEvent.empty()
      : name = '',
        sellerName = '',
        sellerEmail = '',
        sellerId = '',
        video = '',
        image = const [],
        isLive = false,
        quantityAvailable = 0,
        price = 0.0,
        deliveryDate = '',
        description = '',
        measurement = '',
        isAlwaysAvailable = false,
        deliveryLocations = const [],
        category = '';

  final String name;
  final String video;
  final List<String> image;
  final String sellerName;
  final String sellerId;
  final String sellerEmail;
  final bool isLive;
  final int quantityAvailable;
  final double price;
  final String deliveryDate;
  final String description;
  final String measurement;
  final bool isAlwaysAvailable;
  final List<String> deliveryLocations;
  final String category;

  @override
  List<Object> get props => [
        name,
        video,
        image,
        sellerName,
        sellerEmail,
        sellerId,
        isLive,
        quantityAvailable,
        price,
        deliveryDate,
        description,
        measurement,
        isAlwaysAvailable,
        deliveryLocations,
        category,
      ];
}
