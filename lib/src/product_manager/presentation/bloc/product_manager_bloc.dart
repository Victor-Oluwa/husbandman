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
import 'package:husbandman/src/product_manager/domain/usecase/delete_product.dart';
import 'package:husbandman/src/product_manager/domain/usecase/fetch_farmer_products.dart';
import 'package:husbandman/src/product_manager/domain/usecase/fetch_product_by_category.dart';
import 'package:husbandman/src/product_manager/domain/usecase/fetch_products.dart';
import 'package:husbandman/src/product_manager/domain/usecase/get_product_image_url.dart';
import 'package:husbandman/src/product_manager/domain/usecase/like_product.dart';
import 'package:husbandman/src/product_manager/domain/usecase/pick_product_image.dart';
import 'package:husbandman/src/product_manager/domain/usecase/rate_product.dart';
import 'package:husbandman/src/product_manager/domain/usecase/search_product.dart';
import 'package:husbandman/src/product_manager/domain/usecase/set_product.dart';
import 'package:husbandman/src/product_manager/domain/usecase/update_product.dart';
import 'package:husbandman/src/product_manager/domain/usecase/upload_product.dart';

part 'product_manager_event.dart';

part 'product_manager_state.dart';

class ProductManagerBloc
    extends Bloc<ProductManagerEvent, ProductManagerState> {
  ProductManagerBloc({
    required DeleteProduct deleteProduct,
    required FetchFarmerProduct fetchFarmerProduct,
    required FetchProductByCategoryParams fetchProductByCategoryParams,
    required FetchProducts fetchProducts,
    required GetProductImageUrl getProductImageUrl,
    required LikeProduct likeProduct,
    required PickProductImage pickProductImage,
    required RateProduct rateProduct,
    required SearchProduct  searchProduct,
    required SetProduct setProduct,
    required UpdateProduct updateProduct,
    required UploadProduct uploadProduct,
  }) : super(ProductManagerInitial()) {
    on<ProductManagerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  // final DeleteProduct _deleteProduct
}
