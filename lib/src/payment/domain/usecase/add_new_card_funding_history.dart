import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_history_entity.dart';
import 'package:husbandman/src/payment/domain/repo/payment_repo.dart';

class AddNewCardFundingHistory extends UseCaseWithParams<
    String, CardFundingHistoryEntity> {
  AddNewCardFundingHistory({required PaymentRepo paymentRepo})
      : _paymentRepo = paymentRepo;

  final PaymentRepo _paymentRepo;

  @override
  ResultFuture<String> call(CardFundingHistoryEntity params) {
    return _paymentRepo.addNewCardFundingHistory(history: params);
  }
}
