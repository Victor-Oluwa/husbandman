import 'package:equatable/equatable.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class GetImgUrlFromSupaBase
    extends UseCaseWithParams<List<String>, GetImgUrlFromSupaBaseParams> {
  GetImgUrlFromSupaBase({required ProductManagerRepo repo}) : _repo = repo;

  final ProductManagerRepo _repo;

  @override
  ResultFuture<List<String>> call(GetImgUrlFromSupaBaseParams params) {
    return _repo.getImgUrlFromSupaBase(
      filePaths: params.filePaths,
      folderPath: params.folderPath,
    );
  }
}

class GetImgUrlFromSupaBaseParams extends Equatable {
  const GetImgUrlFromSupaBaseParams({
    required this.folderPath,
    required this.filePaths,
  });

  GetImgUrlFromSupaBaseParams.empty() : this(folderPath: '', filePaths: []);

  final String folderPath;
  final List<String> filePaths;

  @override
  List<dynamic> get props => [folderPath, filePaths];
}
