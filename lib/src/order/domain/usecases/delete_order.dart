import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/order/domain/repo/order_repo.dart';

class DeleteOrder extends UseCaseWithParams<void, String>{
  DeleteOrder({required OrderRepo orderRepo}) : _orderRepo = orderRepo;

  final OrderRepo _orderRepo;

  @override
  ResultFuture<void> call(String params) {
    return _orderRepo.deleteOrder(orderId: params);
  }
}