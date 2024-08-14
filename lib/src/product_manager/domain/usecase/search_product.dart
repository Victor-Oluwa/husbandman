import 'package:equatable/equatable.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class SearchProduct
    extends UseCaseWithParams<List<ProductEntity>, SearchProductParams> {
  const SearchProduct(this._productManagerRepo);

  final ProductManagerRepo _productManagerRepo;

  @override
  ResultFuture<List<ProductEntity>> call(SearchProductParams params) =>
      _productManagerRepo.searchProduct(
        userId: params.userId,
        query: params.query,
        searchBy: params.searchBy,
      );
}

class SearchProductParams extends Equatable {
  const SearchProductParams({
    required this.userId,
    required this.query,
    required this.searchBy,
  });

  const SearchProductParams.empty()
      : this(
            query: 'empty.query',
            userId: 'empty.id',
            searchBy: 'empty.searchBy',);

  final String userId;
  final String query;
  final String searchBy;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
