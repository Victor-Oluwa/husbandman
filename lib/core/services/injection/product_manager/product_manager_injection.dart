import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/services/injection/injection_container.dart';
import 'package:husbandman/src/product_manager/data/datasource/product_manager_datasource_impl.dart';
import 'package:husbandman/src/product_manager/data/repo/product_manager_repo_impl.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';
import 'package:husbandman/src/product_manager/domain/usecase/add_product_to_cart.dart';
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
import 'package:husbandman/src/product_manager/presentation/bloc/product_manager_bloc.dart';

final productManagerBlocProvider = Provider<ProductManagerBloc>(
  (ref) {
    return ProductManagerBloc(
      compressProductImage: ref.read(compressProductImageProvider),
      deleteProduct: ref.read(deleteProductProvider),
      fetchFarmerProduct: ref.read(fetchFarmerProductProvider),
      fetchProductsByCategory: ref.read(fetchProductsByCategoryProvider),
      fetchProducts: ref.read(fetchProductsProvider),
      getProductImageUrl: ref.read(getProductImageUrlProvider),
      likeProduct: ref.read(likeProductProvider),
      pickProductImage: ref.read(pickProductImageProvider),
      rateProduct: ref.read(rateProductProvider),
      searchProduct: ref.read(searchProductProvider),
      setSellerProduct: ref.read(setSellerProductProvider),
      setGeneralProducts: ref.read(setGeneralProductsProvider),
      updateProduct: ref.read(updateProductProvider),
      uploadProduct: ref.read(uploadProductProvider),
      addProductToCart: ref.read(addProductToCartProvider),
    );
  },
);

final productManagerDatasourceProvider = Provider<ProductManagerDatasourceImpl>(
  (ref) {
    return ProductManagerDatasourceImpl(
      ref.read(httpClientProvider),
      ref,
      ref.read(cloudinaryUploadProvider),
      ref.read(pickFileProvider),
      ref.read(compressorProvider),
    );
  },
);

final productManagerRepoProvider = Provider<ProductManagerRepo>(
  (ref) {
    return ProductManagerRepoImpl(ref.read(productManagerDatasourceProvider));
  },
);

final compressProductImageProvider = Provider<CompressProductImage>(
  (ref) => CompressProductImage(
    ref.read(productManagerRepoProvider),
  ),
);

final deleteProductProvider = Provider<DeleteProduct>(
  (ref) {
    return DeleteProduct(ref.read(productManagerRepoProvider));
  },
);

final fetchFarmerProductProvider = Provider<FetchFarmerProduct>(
  (ref) => FetchFarmerProduct(
    ref.read(productManagerRepoProvider),
  ),
);

final fetchProductsByCategoryProvider = Provider<FetchProductsByCategory>(
  (ref) {
    return FetchProductsByCategory(ref.read(productManagerRepoProvider));
  },
);

final fetchProductsProvider = Provider<FetchProducts>(
  (ref) {
    return FetchProducts(ref.read(productManagerRepoProvider));
  },
);

final getProductImageUrlProvider = Provider<GetProductImageUrl>(
  (ref) {
    return GetProductImageUrl(ref.read(productManagerRepoProvider));
  },
);

final likeProductProvider = Provider<LikeProduct>(
  (ref) {
    return LikeProduct(ref.read(productManagerRepoProvider));
  },
);

final pickProductImageProvider = Provider<PickProductImage>(
  (ref) {
    return PickProductImage(ref.read(productManagerRepoProvider));
  },
);

final rateProductProvider = Provider<RateProduct>(
  (ref) {
    return RateProduct(ref.read(productManagerRepoProvider));
  },
);

final searchProductProvider = Provider<SearchProduct>(
  (ref) {
    return SearchProduct(ref.read(productManagerRepoProvider));
  },
);

final setSellerProductProvider = Provider<SetSellerProduct>(
  (ref) {
    return SetSellerProduct(ref.read(productManagerRepoProvider));
  },
);

final setGeneralProductsProvider = Provider<SetGeneralProducts>(
  (ref) {
    return SetGeneralProducts(ref.read(productManagerRepoProvider));
  },
);

final updateProductProvider = Provider<UpdateProduct>(
  (ref) {
    return UpdateProduct(ref.read(productManagerRepoProvider));
  },
);

final uploadProductProvider = Provider<UploadProduct>(
  (ref) {
    return UploadProduct(ref.read(productManagerRepoProvider));
  },
);

final addProductToCartProvider = Provider<AddProductToCart>((ref){
  return AddProductToCart(repo: ref.read(productManagerRepoProvider));
},);
