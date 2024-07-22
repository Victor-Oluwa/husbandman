import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_history_entity.dart';
import 'package:husbandman/src/payment/domain/repo/payment_repo.dart';

class FetchCardFundingHistory
    extends UseCaseWithoutParams<List<CardFundingHistoryEntity>> {
  FetchCardFundingHistory({required PaymentRepo paymentRepo}) : _paymentRepo = paymentRepo;

  final PaymentRepo _paymentRepo;
  @override
  ResultFuture<List<CardFundingHistoryEntity>> call() {
    return _paymentRepo.fetchCardFundingHistory();
  }
}
