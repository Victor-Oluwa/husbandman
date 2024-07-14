import 'package:husbandman/src/payment/domain/entity/card_funding_pin_auth_response_entity.dart';

class CardFundingPinAuthResponse extends CardFundingPinAuthResponseEntity {
  const CardFundingPinAuthResponse({
    required super.message,
    super.transactionId,
    super.ref,
    super.status,
    super.url,
    super.info,
  });

  const CardFundingPinAuthResponse.empty()
      : this(
          message: '',
          url: '',
          status: '',
          transactionId: '',
          ref: '',
          info: '',
        );

  @override
  List<dynamic> get props => [message, url, status, transactionId, ref, info];
}
