import 'package:equatable/equatable.dart';
import 'package:husbandman/core/enums/update_card_funding_history.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/domain/repo/payment_repo.dart';

class UpdateCardFundingHistory extends UseCaseWithParams<
    String, UpdateCardFundingHistoryParams> {
  UpdateCardFundingHistory({required PaymentRepo paymentRepo})
      : _paymentRepo = paymentRepo;

  final PaymentRepo _paymentRepo;

  @override
  ResultFuture<String> call(
    UpdateCardFundingHistoryParams params,
  ) {
    return _paymentRepo.updateCardFundingHistory(
      historyId: params.historyId,
      values: params.values,
      culprits: params.culprits,
    );
  }
}

class UpdateCardFundingHistoryParams extends Equatable {
  const UpdateCardFundingHistoryParams({
    required this.historyId,
    required this.values,
    required this.culprits,
  });

  const UpdateCardFundingHistoryParams.empty()
      : this(
          values: const[''],
          culprits:const [UpdateCardFundingHistoryCulprit.fundingStatus],
          historyId: '',
        );

  final String historyId;
  final List<dynamic> values;
  final List<UpdateCardFundingHistoryCulprit> culprits;

  @override
  List<Object?> get props => [historyId, values, culprits];
}
