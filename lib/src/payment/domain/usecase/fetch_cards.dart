import 'package:husbandman/core/common/app/entities/payment_card_entity.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/domain/repo/payment_repo.dart';

class FetchCards extends UseCaseWithParams<List<PaymentCardEntity>, String>{
  FetchCards({required PaymentRepo paymentRepo}) : _paymentRepo = paymentRepo;

  final PaymentRepo _paymentRepo;
  @override
  ResultFuture<List<PaymentCardEntity>> call(String params) {
  return _paymentRepo.fetchCards(params);
  }
}