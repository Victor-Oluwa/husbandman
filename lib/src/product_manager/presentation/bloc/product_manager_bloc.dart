import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/enums/update_product.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/usecase/compress_product_image.dart';
import 'package:husbandman/src/product_manager/domain/usecase/delete_product.dart';
import 'package:husbandman/src/product_manager/domain/usecase/fetch_farmer_products.dart';
import 'package:husbandman/src/product_manager/domain/usecase/fetch_product_by_category.dart';
import 'package:husbandman/src/product_manager/domain/usecase/fetch_products.dart';
import 'package:husbandman/src/product_manager/domain/usecase/get_product_image_url.dart';
import 'package:husbandman/src/product_manager/domain/usecase/like_product.dart';
import 'package:husbandman/src/product_manager/domain/usecase/pick_product_image.dart';
import 'package:husbandman/src/product_manager/domain/usecase/rate_product.dart';
import 'package:husbandman/src/product_manager/domain/usecase/search_product.dart';
import 'package:husbandman/src/product_manager/domain/usecase/set_general_products.dart';
import 'package:husbandman/src/product_manager/domain/usecase/set_seller_product.dart';
import 'package:husbandman/src/product_manager/domain/usecase/update_product.dart';
import 'package:husbandman/src/product_manager/domain/usecase/upload_product.dart';

part 'product_manager_event.dart';

part 'product_manager_state.dart';

class ProductManagerBloc
    extends Bloc<ProductManagerEvent, ProductManagerState> {
  ProductManagerBloc({
    required CompressProductImage compressProductImage,
    required DeleteProduct deleteProduct,
    required FetchFarmerProduct fetchFarmerProduct,
    required FetchProductsByCategory fetchProductsByCategory,
    required FetchProducts fetchProducts,
    required GetProductImageUrl getProductImageUrl,
    required LikeProduct likeProduct,
    required PickProductImage pickProductImage,
    required RateProduct rateProduct,
    required SearchProduct searchProduct,
    required SetSellerProduct setSellerProduct,
    required SetGeneralProducts setGeneralProducts,
    required UpdateProduct updateProduct,
    required UploadProduct uploadProduct,
  })  : _compressProductImage = compressProductImage,
        _deleteProduct = deleteProduct,
        _fetchFarmerProduct = fetchFarmerProduct,
        _fetchProductsByCategory = fetchProductsByCategory,
        _fetchProducts = fetchProducts,
        _getProductImageUrl = getProductImageUrl,
        _likeProduct = likeProduct,
        _pickProductImage = pickProductImage,
        _rateProduct = rateProduct,
        _searchProduct = searchProduct,
        _setSellerProduct = setSellerProduct,
        _setGeneralProducts = setGeneralProducts,
        _updateProduct = updateProduct,
        _uploadProduct = uploadProduct,
        super(ProductManagerInitial()) {
    on<ProductManagerEvent>((event, emit) {
      emit(const ProductManagerLoading());
    });

    on<CompressProductImagesEvent>(_compressProductImageHandler);
    on<DeleteProductEvent>(_deleteProductHandler);
    on<FetchFarmerProductsEvent>(_fetchFarmerProductHandler);
    on<FetchProductsByCategoryEvent>(_fetchProductsByCategoryHandler);
    on<FetchProductsEvent>(_fetchProductsHandler);
    on<GetProductImageUrlEvent>(_getProductImageUrlHandler);
    on<LikeProductEvent>(_likeProductHandler);
    on<PickProductImageEvent>(_pickProductImageHandler);
    on<RateProductEvent>(_rateProductHandler);
    on<SearchProductEvent>(_searchProductHandler);
    on<SetSellerProductEvent>(_setSellerProductHandler);
    on<SetGeneralProductEvent>(_setGeneralProductHandler);
    on<UpdateProductEvent>(_updateProductHandler);
    on<UploadProductEvent>(_uploadProductHandler);
  }

  final CompressProductImage _compressProductImage;
  final DeleteProduct _deleteProduct;
  final FetchFarmerProduct _fetchFarmerProduct;
  final FetchProductsByCategory _fetchProductsByCategory;
  final FetchProducts _fetchProducts;
  final GetProductImageUrl _getProductImageUrl;
  final LikeProduct _likeProduct;
  final PickProductImage _pickProductImage;
  final RateProduct _rateProduct;
  final SearchProduct _searchProduct;
  final SetSellerProduct _setSellerProduct;
  final SetGeneralProducts _setGeneralProducts;
  final UpdateProduct _updateProduct;
  final UploadProduct _uploadProduct;

  Future<void> _compressProductImageHandler(
    CompressProductImagesEvent event,
    Emitter<ProductManagerState> emit,
  ) async {
    final result = await _compressProductImage(event.files);

    result.fold(
      (l) => emit(ProductManagerFailure(l.errorMessage)),
      (r) => emit(
        CompressedImages(r),
      ),
    );
  }

  Future<void> _deleteProductHandler(
    DeleteProductEvent event,
    Emitter<ProductManagerState> emit,
  ) async {
    final result = await _deleteProduct(event.id);

    result.fold(
      (l) => emit(ProductManagerFailure(l.errorMessage)),
      (r) => emit(
        ProductDeleted(r),
      ),
    );
  }

  Future<void> _fetchFarmerProductHandler(
    FetchFarmerProductsEvent event,
    Emitter<ProductManagerState> emit,
  ) async {
    final result = await _fetchFarmerProduct(event.farmerEmail);

    result.fold(
      (l) => emit(ProductManagerFailure(l.errorMessage)),
      (r) => emit(
        FetchedFarmerProduct(r),
      ),
    );
  }

  Future<void> _fetchProductsByCategoryHandler(
    FetchProductsByCategoryEvent event,
    Emitter<ProductManagerState> emit,
  ) async {
    final result = await _fetchProductsByCategory(
      FetchProductsByCategoryParams(
        category: event.category,
        limit: event.limit,
        fetched: event.fetched,
      ),
    );

    result.fold(
      (l) => emit(ProductManagerFailure(l.errorMessage)),
      (r) => emit(
        FetchedProductByCategory(r),
      ),
    );
  }

  Future<void> _fetchProductsHandler(
    FetchProductsEvent event,
    Emitter<ProductManagerState> emit,
  ) async {
    final result = await _fetchProducts(
      FetchProductsParams(
        limit: event.limit,
        fetched: event.fetched,
      ),
    );

    result.fold(
      (l) => emit(ProductManagerFailure(l.errorMessage)),
      (r) => emit(
        FetchedProduct(r),
      ),
    );
  }

  Future<void> _getProductImageUrlHandler(
    GetProductImageUrlEvent event,
    Emitter<ProductManagerState> emit,
  ) async {
    final result = await _getProductImageUrl(
      GetProductImageUrlParams(
        isByte:event.isByte,
        sellerName: event.sellerName,
        compressedFile: event.compressedFile,
        file: event.file,
      ),
    );

    result.fold(
      (l) => emit(ProductManagerFailure(l.errorMessage)),
      (r) => emit(
        GottenProductImageUrl(r),
      ),
    );
  }

  Future<void> _likeProductHandler(
    LikeProductEvent event,
    Emitter<ProductManagerState> emit,
  ) async {
    final result = await _likeProduct(event.id);

    result.fold(
      (l) => emit(ProductManagerFailure(l.errorMessage)),
      (r) => emit(
        LikedProduct(r),
      ),
    );
  }

  Future<void> _pickProductImageHandler(
    PickProductImageEvent event,
    Emitter<ProductManagerState> emit,
  ) async {
    final result = await _pickProductImage();

    result.fold(
      (l) => emit(ProductManagerFailure(l.errorMessage)),
      (r) => emit(PickedProductImage(r)),
    );
  }

  Future<void> _rateProductHandler(
    RateProductEvent event,
    Emitter<ProductManagerState> emit,
  ) async {
    final result = await _rateProduct(event.id);

    result.fold(
      (l) => emit(ProductManagerFailure(l.errorMessage)),
      (r) => emit(
        ProductRated(r),
      ),
    );
  }

  Future<void> _searchProductHandler(
    SearchProductEvent event,
    Emitter<ProductManagerState> emit,
  ) async {
    final result = await _searchProduct(
      SearchProductParams(
        userId: event.userId,
        query: event.query,
        searchBy: event.searchBy,
      ),
    );

    result.fold(
      (l) => emit(ProductManagerFailure(l.errorMessage)),
      (r) => emit(
        SearchComplete(r),
      ),
    );
  }

  Future<void> _setSellerProductHandler(
    SetSellerProductEvent event,
    Emitter<ProductManagerState> emit,
  ) async {
    final result = await _setSellerProduct(
      SetSellerProductParams(
        setProductType: event.setProductType,
        productObject: event.productObject,
        productMap: event.productMap,
      ),
    );

    result.fold(
      (l) => emit(ProductManagerFailure(l.errorMessage)),
      (r) => emit(
        SellerProductSet(r),
      ),
    );
  }

  Future<void> _setGeneralProductHandler(
    SetGeneralProductEvent event,
    Emitter<ProductManagerState> emit,
  ) async {
    final result = await _setGeneralProducts(
      SetGeneralProductsParams(
        setProductType: event.setProductType,
        productObject: event.productObject,
        productMap: event.productMap,
      ),
    );

    result.fold(
      (l) => emit(ProductManagerFailure(l.errorMessage)),
      (_) => emit(
        const GeneralProductSet(),
      ),
    );
  }

  Future<void> _updateProductHandler(
    UpdateProductEvent event,
    Emitter<ProductManagerState> emit,
  ) async {
    final result = await _updateProduct(
      UpdateProductParams(
        newData: event.newData,
        culprit: event.culprit,
      ),
    );

    result.fold(
      (l) => emit(ProductManagerFailure(l.errorMessage)),
      (r) => emit(
        ProductUpdated(r),
      ),
    );
  }

  Future<void> _uploadProductHandler(
    UploadProductEvent event,
    Emitter<ProductManagerState> emit,
  ) async {
    final result = await _uploadProduct(
      UploadProductParams(
        name: event.name,
        video: event.video,
        image: event.image,
        sellerName: event.sellerName,
        sellerEmail: event.sellerEmail,
        available: event.available,
        sold: event.sold,
        quantity: event.quantity,
        price: event.price,
        deliveryTime: event.deliveryTime,
        description: event.description,
        measurement: event.measurement,
        alwaysAvailable: event.alwaysAvailable,
        deliveryLocation: event.deliveryLocation,
        rating: event.rating,
        likes: event.likes,
      ),
    );

    result.fold(
      (l) => emit(ProductManagerFailure(l.errorMessage)),
      (r) => emit(
        ProductUploaded(r),
      ),
    );
  }
}
