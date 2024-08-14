import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/entities/payment_card_entity.dart';

final paymentCardProvider =
    StateNotifierProvider.autoDispose<PaymentCardNotifier, List<PaymentCardEntity>>(
  (ref) => PaymentCardNotifier(),
);

class PaymentCardNotifier extends StateNotifier<List<PaymentCardEntity>> {
  PaymentCardNotifier() : super([]);

  void addNewCard(List<PaymentCardEntity> newCard) {
    if (newCard.isNotEmpty) {
      state.add(newCard.first);
    }
    return;
  }

  void updateCardList(List<PaymentCardEntity> cards) {
    if (cards.isNotEmpty) {
      state = cards;
      return;
    }
    state = [];
  }
}
