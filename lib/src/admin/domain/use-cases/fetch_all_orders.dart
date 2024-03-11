import 'package:husbandman/core/common/app/models/order_model.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';

class FetchAllOrders extends UseCaseWithoutParams<List<OrderModel>> {
  const FetchAllOrders(this._adminRepo);

  final AdminRepo _adminRepo;

  @override
  ResultFuture<List<OrderModel>> call() =>_adminRepo.fetchAllOrders();
}
