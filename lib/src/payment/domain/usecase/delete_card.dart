import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/domain/repo/payment_repo.dart';

class DeleteCard extends UseCaseWithParams<void, String>{
  DeleteCard({required PaymentRepo paymentRepo}) : _paymentRepo = paymentRepo;

  final PaymentRepo _paymentRepo;

  @override
  ResultFuture<void> call(String params) {
   return _paymentRepo.deleteCard(params);
  }
}
