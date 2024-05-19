import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class FetchProducts
    extends UseCaseWithParams<List<ProductEntity>, FetchProductsParams> {
  const FetchProducts(this._repo);

  final ProductManagerRepo _repo;

  @override
  ResultFuture<List<ProductEntity>> call(FetchProductsParams params) {
    return _repo.fetchProducts(limit: params.limit, fetched: params.fetched);
  }
}

class FetchProductsParams extends Equatable {
  const FetchProductsParams({
    required this.limit,
    required this.fetched,
  });

   FetchProductsParams.demo()
      : this(
          limit: 20,
          fetched: [],
        );

  final int limit;
  final List<String> fetched;

  @override
  List<Object> get props => [];
}
