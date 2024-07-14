import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/domain/repo/payment_repo.dart';

class CardFundingVerification extends UseCaseWithParams<String, String> {
  CardFundingVerification({required PaymentRepo paymentRepo})
      : _paymentRepo = paymentRepo;

  final PaymentRepo _paymentRepo;

  @override
  ResultFuture<String> call(String params) {
    return _paymentRepo.cardFundingVerification(transactionId: params);
  }
}
