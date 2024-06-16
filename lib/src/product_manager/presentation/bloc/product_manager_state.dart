part of 'product_manager_bloc.dart';

abstract class ProductManagerState extends Equatable {
  const ProductManagerState();

  @override
  List<Object> get props => [];
}

class ProductManagerInitial extends ProductManagerState {}

class ProductManagerLoading extends ProductManagerState {
  const ProductManagerLoading();
}

class ProductManagerError extends ProductManagerState {
  const ProductManagerError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

class ProductAddedToCart extends ProductManagerState {
 const ProductAddedToCart({required this.cart});

  final CartEntity cart;

  @override
  List<CartEntity> get props => [cart];
}

class ProductDeleted extends ProductManagerState {
  const ProductDeleted(this.products);

  final List<ProductEntity> products;

  @override
  List<List<ProductEntity>> get props => [products];
}

class CompressedImages extends ProductManagerState{
  const CompressedImages(this.files);

  final List<Uint8List?> files;

  @override
  List<List<Uint8List?>> get props => [files];
}
class FetchedFarmerProduct extends ProductManagerState {
  const FetchedFarmerProduct(this.products);

  final List<ProductEntity> products;

  @override
  List<List<ProductEntity>> get props => [products];
}

class FetchedProductByCategory extends ProductManagerState {
  const FetchedProductByCategory(this.products);

  final List<ProductEntity> products;

  @override
  List<List<ProductEntity>> get props => [products];
}

class FetchedProduct extends ProductManagerState {
  const FetchedProduct(this.products);

  final List<ProductEntity> products;

  @override
  List<List<ProductEntity>> get props => [products];
}

class GottenProductImageUrl extends ProductManagerState {
  const GottenProductImageUrl(this.urls);

  final List<String> urls;

  @override
  List<List<String>> get props => [urls];
}

class LikedProduct extends ProductManagerState {
  const LikedProduct(this.product);

  final ProductEntity product;

  @override
  List<ProductEntity> get props => [product];
}

class PickedProductImage extends ProductManagerState {
  const PickedProductImage(this.files);

  final List<File> files;

  @override
  List<List<File>> get props => [files];
}

class ProductRated extends ProductManagerState {
  const ProductRated(this.product);

  final ProductEntity product;

  @override
  List<ProductEntity> get props => [product];
}

class SearchComplete extends ProductManagerState {
  const SearchComplete(this.products);

  final List<ProductEntity> products;

  @override
  List<List<ProductEntity>> get props => [products];
}

class SellerProductSet extends ProductManagerState {
  const SellerProductSet(this.product);

  final ProductEntity product;

  @override
  List<ProductEntity> get props => [product];
}

class GeneralProductSet extends ProductManagerState {
  const GeneralProductSet();

  @override
  List<ProductEntity> get props => [];
}

class ProductUpdated extends ProductManagerState {
  const ProductUpdated(this.product);

  final ProductEntity product;

  @override
  List<ProductEntity> get props => [product];
}

class ProductUploaded extends ProductManagerState {
  const ProductUploaded(this.product);

  final ProductEntity product;

  @override
  List<ProductEntity> get props => [product];
}
