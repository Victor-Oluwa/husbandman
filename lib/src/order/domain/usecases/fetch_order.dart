import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/order/domain/entity/order_entity.dart';
import 'package:husbandman/src/order/domain/repo/order_repo.dart';

class FetchOrder extends UseCaseWithParams<OrderEntity, String>{
  FetchOrder({required OrderRepo orderRepo}) : _orderRepo = orderRepo;


  final OrderRepo _orderRepo;

  @override
  ResultFuture<OrderEntity> call(String params) {
   return _orderRepo.fetchOrder(userId: params);
  }
}