import 'package:husbandman/core/common/app/entities/payment_card_entity.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/domain/repo/payment_repo.dart';

class SetCard extends UseCaseWithParams<void, SetCardParams> {
  SetCard(this._paymentRepo);

  final PaymentRepo _paymentRepo;

  @override
  ResultFuture<void> call(SetCardParams params) {
    return _paymentRepo.setCard(
      replaceList: params.replaceList,
      cards: params.cards,
    );
  }
}

class SetCardParams {
  SetCardParams({
    required this.cards,
    required this.replaceList,
  });

  SetCardParams.empty()
      : this(
          cards: [],
          replaceList: false,
        );

  final List<PaymentCardEntity> cards;
  final bool replaceList;
}
