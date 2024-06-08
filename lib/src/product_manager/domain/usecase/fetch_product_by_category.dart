import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class FetchProductsByCategory extends UseCaseWithParams<List<ProductEntity>,
    FetchProductsByCategoryParams> {
  FetchProductsByCategory(this._repo);

  final ProductManagerRepo _repo;

  @override
  ResultFuture<List<ProductEntity>> call(FetchProductsByCategoryParams params) {
    return _repo.fetchProductsByCategory(
      category: params.category,
      limit: params.limit,
      fetched: params.fetched,
    );
  }
}

class FetchProductsByCategoryParams extends Equatable {
  const FetchProductsByCategoryParams({
    required this.category,
    required this.limit,
    required this.fetched,
  });

  final String category;
  final int limit;
  final List<String> fetched;

  @override
  List<Object> get props => [];
}
