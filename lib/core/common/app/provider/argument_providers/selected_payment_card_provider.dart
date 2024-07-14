import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/entities/payment_card_entity.dart';

final selectedPaymentCardProvider = StateProvider.autoDispose<PaymentCardEntity?>(
  (ref) => null,
);
