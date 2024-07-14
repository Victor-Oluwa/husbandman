import 'package:husbandman/src/payment/domain/entity/initialize_card_funding_response_entity.dart';

class InitializeCardFundingResponse
    extends InitializeCardFundingResponseEntity {
  const InitializeCardFundingResponse({
    required super.message,
    super.payload,
    super.url,
    super.transactionId,
  });

  const InitializeCardFundingResponse.empty()
      : this(
          message: '',
          payload: const {},
          url: '',
          transactionId: '',
        );

  @override
  List<dynamic> get props => [message, payload, url, transactionId];
}
