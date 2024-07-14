import 'package:equatable/equatable.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_pin_auth_response_entity.dart';
import 'package:husbandman/src/payment/domain/repo/payment_repo.dart';

class CardFundingPinAuth extends UseCaseWithParams<
    CardFundingPinAuthResponseEntity, CardFundingPinAuthParams> {
  CardFundingPinAuth({required PaymentRepo paymentRepo})
      : _paymentRepo = paymentRepo;

  final PaymentRepo _paymentRepo;

  @override
  ResultFuture<CardFundingPinAuthResponseEntity> call(
      CardFundingPinAuthParams params,) {
    return _paymentRepo.cardFundingPinAuth(
      pin: params.pin,
      payload: params.payload,
    );
  }
}

class CardFundingPinAuthParams extends Equatable {
  const CardFundingPinAuthParams({
    required this.pin,
    required this.payload,
  });

  const CardFundingPinAuthParams.empty()
      : this(
          payload: const {},
          pin: '',
        );

  final String pin;
  final DataMap payload;

  @override
  List<dynamic> get props => [pin, payload];
}
