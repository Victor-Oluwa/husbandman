import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class FetchProductByCategory extends UseCaseWithParams<List<ProductEntity>,
    FetchProductByCategoryParams> {
  FetchProductByCategory(this._repo);

  final ProductManagerRepo _repo;

  @override
  ResultFuture<List<ProductEntity>> call(FetchProductByCategoryParams params) {
    return _repo.fetchProductsByCategory(
      category: params.category,
      limit: params.limit,
      skip: params.skip,
    );
  }
}

class FetchProductByCategoryParams extends Equatable {
  const FetchProductByCategoryParams({
    required this.category,
    required this.limit,
    required this.skip,
  });

  final String category;
  final int limit;
  final int skip;

  @override
  List<Object> get props => [];
}
