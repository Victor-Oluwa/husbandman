import 'package:equatable/equatable.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/domain/repo/payment_repo.dart';

class CardFundingOtpValidation
    extends UseCaseWithParams<String, CardFundingOtpValidationParams> {
  CardFundingOtpValidation({required PaymentRepo paymentRepo})
      : _paymentRepo = paymentRepo;

  final PaymentRepo _paymentRepo;

  @override
  ResultFuture<String> call(CardFundingOtpValidationParams params) {
    return _paymentRepo.cardFundingOtpValidation(otp: params.otp, ref: params.ref);
  }
}

class CardFundingOtpValidationParams extends Equatable {
  const CardFundingOtpValidationParams({
    required this.otp,
    required this.ref,
  });

  const CardFundingOtpValidationParams.empty()
      : this(
          ref: '',
          otp: '',
        );
  final String otp;
  final String ref;

  @override
  List<String> get props => [otp, ref];
}
