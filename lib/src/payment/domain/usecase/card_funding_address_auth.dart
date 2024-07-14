import 'package:equatable/equatable.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_address_auth_response_entity.dart';
import 'package:husbandman/src/payment/domain/repo/payment_repo.dart';

class CardFundingAddressAuth extends UseCaseWithParams<
    CardFundingAddressAuthResponseEntity, CardFundingAddressAuthParams> {
  CardFundingAddressAuth({required PaymentRepo paymentRepo})
      : _paymentRepo = paymentRepo;

  final PaymentRepo _paymentRepo;

  @override
  ResultFuture<CardFundingAddressAuthResponseEntity> call(
    CardFundingAddressAuthParams params,
  ) {
    return _paymentRepo.cardFundingAddressAuth(
      payload: params.payload,
      address: params.address,
      city: params.city,
      state: params.state,
      country: params.country,
      zipCode: params.zipCode,
    );
  }
}

class CardFundingAddressAuthParams extends Equatable {
  const CardFundingAddressAuthParams({
    required this.payload,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  const CardFundingAddressAuthParams.empty()
      : this(
          payload: const {},
          address: '',
          city: '',
          state: '',
          country: '',
          zipCode: '',
        );

  final DataMap payload;
  final String address;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  @override
  List<Object?> get props => [
        payload,
        address,
        city,
        state,
        country,
        zipCode,
      ];
}
