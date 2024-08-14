import 'package:husbandman/src/payment/domain/entity/card_funding_address_auth_response_entity.dart';

class CardFundingAddressAuthResponse
    extends CardFundingAddressAuthResponseEntity {
  const CardFundingAddressAuthResponse({
    required super.message,
    super.transactionId,
    super.ref,
    super.status,
    super.url,
    super.info,
  });

  const CardFundingAddressAuthResponse.empty()
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
