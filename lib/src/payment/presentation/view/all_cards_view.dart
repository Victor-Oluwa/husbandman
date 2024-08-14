import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/entities/payment_card_entity.dart';
import 'package:husbandman/core/common/app/provider/argument_providers/selected_payment_card_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/payment_card_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/injection/payment/payment_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/payment/presentation/bloc/payment_bloc.dart';

class AllCardsView extends ConsumerStatefulWidget {
  const AllCardsView({super.key});

  @override
  ConsumerState<AllCardsView> createState() => _AllCardsViewState();
}

class _AllCardsViewState extends ConsumerState<AllCardsView> {
  late PaymentBloc paymentBloc;
  String _selectedCard = 'default';

  @override
  void initState() {
    paymentBloc = ref.read(paymentBlocProvider);
    paymentBloc.add(
      FetchCardsEvent(
        userId: ref.read(userProvider).id,
      ),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ref.invalidate(selectedPaymentCardProvider);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final selectedPaymentCard = ref.watch(selectedPaymentCardProvider);
    return BlocProvider(
      create: (context) => ref.read(paymentBlocProvider),
      child: Scaffold(
        backgroundColor: HBMColors.coolGrey,
        appBar: AppBar(
          backgroundColor: HBMColors.coolGrey,
          title: const HBMTextWidget(data: 'Select Card'),
        ),
        body: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is CardDeleted) {
              log('Card deleted');
              context.read<PaymentBloc>().add(
                    FetchCardsEvent(
                      userId: ref.read(userProvider).id,
                    ),
                  );
            }

            if (state is FetchedCards) {
              log('Cards fetched: ${state.cards}');
              final cards = state.cards;
              context.read<PaymentBloc>().add(
                    SetCardEvent(cards: cards, replaceList: true),
                  );
            }

            if (state is CardSet) {
              log('cart set');
            }

            if (state is PaymentError) {
              log('All Card View Error: ${state.message}');
            }
          },
          builder: (context, state) {
            return ref.watch(paymentCardProvider).isNotEmpty
                ? Padding(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: context.width * 0.06),
                          child: HBMTextWidget(
                            data: 'Select card or add new card',
                            fontSize: context.width * 0.04,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: ref.watch(paymentCardProvider).length,
                            itemBuilder: (context, index) {
                              final card =
                                  ref.watch(paymentCardProvider)[index];
                              final cardNumber = card.number;
                              final lastThreeDigits =
                                  cardNumber.substring(cardNumber.length - 3);
                              return CardOption(
                                  card: card,
                                  cardHolder: card.holderName,
                                  lastDigits: lastThreeDigits,
                                  cardLabel:
                                      index == 0 ? 'Default' : 'Secondary',
                                  selectedCard: _selectedCard,
                                  value: 'card$index',
                                  onChanged: (value) {
                                    setState(() {
                                      ref
                                          .read(selectedPaymentCardProvider
                                              .notifier,)
                                          .state = card;

                                      _selectedCard = value!;
                                    });
                                  },);
                            },
                          ),
                        ),
                        // Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.width * 0.03,),
                          child: ElevatedButton(
                            onPressed: () {
                              if (selectedPaymentCard == null) {
                                HBMSnackBar.show(
                                  context: context,
                                  content: 'Select a card before proceeding',
                                );
                                return;
                              } else {
                                log('Selected Payment Card: $selectedPaymentCard.holderName}');
                              }
                              Navigator.pushNamed(
                                context,
                                RouteNames.enterAmountView,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: HBMColors.charcoalGrey,
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: HBMTextWidget(
                              data: 'Proceed',
                              color: HBMColors.coolGrey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.width * 0.03,
                            vertical: context.height * 0.02,
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.addCardView,
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const HBMTextWidget(data: 'Add New Card'),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.addCardView,
                        );
                      },
                      icon: SizedBox(
                        height: context.height * 0.10,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            HBMTextWidget(
                              data: 'Add a card',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class CardOption extends StatelessWidget {

  const CardOption({required this.card, required this.cardHolder, required this.lastDigits, required this.cardLabel, required this.selectedCard, required this.value, required this.onChanged, super.key,
  });
  final String cardHolder;
  final String lastDigits;
  final String cardLabel;
  final String selectedCard;
  final String value;
  final ValueChanged<String?>? onChanged;
  final PaymentCardEntity card;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      activeColor: HBMColors.charcoalGrey,
      value: value,
      groupValue: selectedCard,
      onChanged: onChanged,
      title: SizedBox(
        height: context.height * 0.11,
        width: context.width * 0.25,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                context.width * 0.03,
              ),
              side: BorderSide(
                color: HBMColors.charcoalGrey,
              ),),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SizedBox(
                      height: context.height * 0.09,
                      width: context.width * 0.15,
                      child: Card(
                        color: HBMColors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            context.width * 0.02,
                          ),
                        ),
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        child: Center(
                          child: HBMTextWidget(
                            data: card.type.substring(0, 1),
                            fontFamily: HBMFonts.exoBold,
                            color: HBMColors.mediumGrey,
                            fontSize: context.width * 0.09,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: context.width * 0.03),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HBMTextWidget(
                          data: cardHolder,
                          color: HBMColors.charcoalGrey,
                          fontFamily: HBMFonts.exoBold,
                        ),
                        HBMTextWidget(
                          data: '**** $lastDigits',
                          color: HBMColors.grey,
                          fontFamily: HBMFonts.exo2,
                          fontSize: context.width * 0.04,
                        ),
                        HBMTextWidget(
                          data: cardLabel,
                          color: Colors.green,
                          fontFamily: HBMFonts.exo2,
                          fontSize: context.width * 0.03,
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    context.read<PaymentBloc>().add(
                          DeleteCardEvent(cartId: card.id),
                        );
                  },
                  icon: const Icon(Icons.delete_outline_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
      // toggleable: true,
      // subtitle: Text(cardLabel),
    );
  }
}
