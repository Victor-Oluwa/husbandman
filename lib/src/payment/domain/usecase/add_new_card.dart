import 'package:husbandman/core/common/app/entities/payment_card_entity.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/domain/repo/payment_repo.dart';

class AddNewCard
    extends UseCaseWithParams<PaymentCardEntity, AddNewCardParams> {
  AddNewCard({required PaymentRepo paymentRepo}) : _paymentRepo = paymentRepo;

  final PaymentRepo _paymentRepo;

  @override
  ResultFuture<PaymentCardEntity> call(AddNewCardParams params) {
    return _paymentRepo.addNewCard(
      holderName: params.holderName,
      cardNumber: params.cardNumber,
      expiryDate: params.expiryDate,
      ccv: params.ccv,
      type: params.type,
      ownerId: params.ownerId,
    );
  }
}

class AddNewCardParams {
  AddNewCardParams({
    required this.type,
    required this.ccv,
    required this.expiryDate,
    required this.cardNumber,
    required this.holderName,
    required this.ownerId,
  });

  final String type;
  final String ccv;
  final String expiryDate;
  final String cardNumber;
  final String holderName;
  final String ownerId;
}
