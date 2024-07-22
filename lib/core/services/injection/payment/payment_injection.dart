import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/services/injection/injection_container.dart';
import 'package:husbandman/src/payment/data/datasource/payment_datasource_impl.dart';
import 'package:husbandman/src/payment/data/repo/payment_repo_impl.dart';
import 'package:husbandman/src/payment/domain/usecase/add_new_card.dart';
import 'package:husbandman/src/payment/domain/usecase/add_new_card_funding_history.dart';
import 'package:husbandman/src/payment/domain/usecase/card_funding_address_auth.dart';
import 'package:husbandman/src/payment/domain/usecase/card_funding_pin_auth.dart';
import 'package:husbandman/src/payment/domain/usecase/card_funding_verification.dart';
import 'package:husbandman/src/payment/domain/usecase/delete_card.dart';
import 'package:husbandman/src/payment/domain/usecase/fetch_card_funding_history.dart';
import 'package:husbandman/src/payment/domain/usecase/fetch_cards.dart';
import 'package:husbandman/src/payment/domain/usecase/initialize_card_funding.dart';
import 'package:husbandman/src/payment/domain/usecase/set_card.dart';
import 'package:husbandman/src/payment/domain/usecase/card_funding_otp_validation.dart';
import 'package:husbandman/src/payment/domain/usecase/update_card_funding_history.dart';
import 'package:husbandman/src/payment/presentation/bloc/payment_bloc.dart';

final paymentBlocProvider = Provider.autoDispose((ref) {
  return PaymentBloc(
    ref.read(addNewCardProvider),
    ref.read(deleteCardProvider),
    ref.read(fetchAllCardsProvider),
    ref.read(setCardProvider),
    ref.read(initializeCardFundingProvider),
    ref.read(cardFundingPinAuthProvider),
    ref.read(validateCardFundingProvider),
    ref.read(cardFundingAddressAuthProvider),
    ref.read(cardFundingVerificationProvider),
    ref.read(addNewCardFundingHistoryProvider),
    ref.read(updateCardFundingHistoryProvider),
    ref.read(fetchCardFundingHistoryProvider),
  );
});

final paymentDatasourceProvider = Provider((ref) {
  return PaymentDatasourceImpl(dio: ref.read(dioProvider), ref: ref);
});

final paymentRepoProvider = Provider((ref) {
  return PaymentRepoImpl(
      paymentDatasource: ref.read(paymentDatasourceProvider));
});

final addNewCardProvider = Provider((ref) {
  return AddNewCard(paymentRepo: ref.read(paymentRepoProvider));
});

final deleteCardProvider = Provider((ref) {
  return DeleteCard(paymentRepo: ref.read(paymentRepoProvider));
});

final fetchAllCardsProvider = Provider((ref) {
  return FetchCards(paymentRepo: ref.read(paymentRepoProvider));
});

final setCardProvider =
    Provider((ref) => SetCard(ref.read(paymentRepoProvider)));

final initializeCardFundingProvider = Provider.autoDispose(
  (ref) => InitializeCardFunding(
    paymentRepo: ref.read(paymentRepoProvider),
  ),
);

final cardFundingPinAuthProvider = Provider.autoDispose(
  (ref) => CardFundingPinAuth(
    paymentRepo: ref.read(paymentRepoProvider),
  ),
);

final cardFundingAddressAuthProvider = Provider.autoDispose(
  (ref) => CardFundingAddressAuth(
    paymentRepo: ref.read(paymentRepoProvider),
  ),
);

final validateCardFundingProvider = Provider.autoDispose(
  (ref) => CardFundingOtpValidation(
    paymentRepo: ref.read(paymentRepoProvider),
  ),
);

final cardFundingVerificationProvider = Provider.autoDispose(
  (ref) => CardFundingVerification(
    paymentRepo: ref.read(paymentRepoProvider),
  ),
);

final addNewCardFundingHistoryProvider = Provider.autoDispose(
      (ref) => AddNewCardFundingHistory(
    paymentRepo: ref.read(paymentRepoProvider),
  ),
);

final updateCardFundingHistoryProvider = Provider.autoDispose(
      (ref) => UpdateCardFundingHistory(
    paymentRepo: ref.read(paymentRepoProvider),
  ),
);

final fetchCardFundingHistoryProvider = Provider.autoDispose(
      (ref) => FetchCardFundingHistory(
    paymentRepo: ref.read(paymentRepoProvider),
  ),
);
