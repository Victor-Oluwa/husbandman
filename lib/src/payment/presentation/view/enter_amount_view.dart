import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/entities/payment_card_entity.dart';
import 'package:husbandman/core/common/app/provider/argument_providers/card_funding_history_id_provider.dart';
import 'package:husbandman/core/common/app/provider/argument_providers/selected_payment_card_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/enums/failure_stage.dart';
import 'package:husbandman/core/enums/funding_status.dart';
import 'package:husbandman/core/enums/history_updated_by.dart';
import 'package:husbandman/core/enums/init_card_funding_message.dart';
import 'package:husbandman/core/enums/update_card_funding_history.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/injection/payment/payment_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/auth/domain/entity/user/user_entity.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_history_entity.dart';
import 'package:husbandman/src/payment/domain/entity/initialize_card_funding_response_entity.dart';
import 'package:husbandman/src/payment/presentation/bloc/payment_bloc.dart';

// class EnterAmountView extends ConsumerStatefulWidget {
//   const EnterAmountView({super.key});
//
//   @override
//   ConsumerState<EnterAmountView> createState() => _EnterAmountViewState();
// }
//
// class _EnterAmountViewState extends ConsumerState<EnterAmountView> {
//   InitializeCardFundingResponseEntity initFundingResponse =
//       const InitializeCardFundingResponseEntity.empty();
//   HistoryUpdatedBy whoUpdatedHistory = HistoryUpdatedBy.init;
//   String verificationStatus = '';
//   late TextEditingController _controller;
//   late FocusNode _focusNode;
//
//   @override
//   void initState() {
//     _controller = TextEditingController();
//     _focusNode = FocusNode();
//
//     // Ensure the focus node is always focused
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       FocusScope.of(context).requestFocus(_focusNode);
//     });
//     super.initState();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final card =
//         ref.watch(selectedPaymentCardProvider) ?? PaymentCardEntity.empty();
//     final user = ref.watch(userProvider);
//     final historyId = ref.watch(cardFundingHistoryIdProvider);
//     return BlocProvider(
//       create: (context) => ref.read(paymentBlocProvider),
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: HBMColors.coolGrey,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           centerTitle: true,
//           title: const HBMTextWidget(
//             data: 'Enter Amount',
//           ),
//         ),
//         body: BlocConsumer<PaymentBloc, PaymentState>(
//           listener: (context, state) {
//             if (state is InitializedCardFunding) {
//               _handleInitializedCardFunding(context, state, card, user);
//             } else if (state is AddedNewCardFundingHistory) {
//               _handleAddedNewCardFundingHistory(context, state);
//             } else if (state is VerifiedCardFunding) {
//               _handleVerifiedCardFunding(context, state, historyId);
//             } else if (state is PaymentHistoryError) {
//               _handlePaymentHistoryError(context, state);
//             } else if (state is PaymentError) {
//               _handlePaymentError(context, state, card, user);
//             }
//           },
//           builder: (context, state) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: context.height * 0.09),
//                   child: TextField(
//                     focusNode: _focusNode,
//                     controller: _controller,
//                     cursorColor: HBMColors.mediumGrey,
//                     style: TextStyle(
//                       fontSize: context.width * 0.15,
//                     ),
//                     onChanged: (text) {
//                       setState(() {});
//                     },
//                     textAlign: TextAlign.center,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       hintText: '0.00',
//                       alignLabelWithHint: true,
//                       hintStyle: TextStyle(
//                         fontFamily: HBMFonts.exo2,
//                         fontSize: context.width * 0.15,
//                         color: HBMColors.grey,
//                       ),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(bottom: context.height * 0.04),
//                   child: TextButton(
//                     onPressed: () {
//                       if (_controller.text.isEmpty ||
//                           double.parse(_controller.text) < 1) {
//                         HBMSnackBar.show(
//                             context: context,
//                             content: 'Please enter a valid amount');
//                         return;
//                       }
//                       if (card == null) {
//                         HBMSnackBar.show(
//                             context: context, content: 'No card was selected');
//                         return;
//                       }
//
//                       context.read<PaymentBloc>().add(
//                             InitializeCardFundingEvent(
//                               cardNumber: card.number.replaceAll(' ', ''),
//                               cvv: card.ccv,
//                               expiryYear: card.expiryDate.substring(3, 5),
//                               expiryMonth: card.expiryDate.substring(0, 2),
//                               currency: 'NGN',
//                               amount: _controller.text,
//                               redirectUrl: 'www.google.com',
//                               fullName: card.holderName,
//                               email: 'gm.oluwafemi@gmail.com',
//                               phone: '07058919193',
//                               ref: DateTime.now()
//                                   .microsecondsSinceEpoch
//                                   .toString(),
//                             ),
//                           );
//                     },
//                     style: TextButton.styleFrom(
//                         backgroundColor: _controller.text.isNotEmpty
//                             ? HBMColors.charcoalGrey
//                             : HBMColors.grey,
//                         fixedSize:
//                             Size(context.width * 0.80, context.height * 0.06)),
//                     child: HBMTextWidget(
//                       data: 'Continue',
//                       color: HBMColors.coolGrey,
//                     ),
//                   ),
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   void _handleInitializedCardFunding(BuildContext context,
//       InitializedCardFunding state, PaymentCardEntity card, UserEntity user) {
//     ref.invalidate(cardFundingHistoryIdProvider);
//     setState(() {
//       initFundingResponse = state.response;
//       whoUpdatedHistory = HistoryUpdatedBy.bloc1;
//     });
//
//     log('Payment Initialized: ${initFundingResponse.message}');
//
//     final history = _createCardFundingHistory(
//       status: FundingStatus.pending,
//       failureMessage: '',
//       failureStage: FailureStage.none,
//       card: card,
//       user: user,
//     );
//
//     context
//         .read<PaymentBloc>()
//         .add(AddNewCardFundingHistoryEvent(history: history));
//   }
//
//   void _handleAddedNewCardFundingHistory(
//       BuildContext context, AddedNewCardFundingHistory state) {
//     log('History written: ${state.historyId}');
//     ref.read(cardFundingHistoryIdProvider.notifier).state = state.historyId;
//
//     switch (whoUpdatedHistory) {
//       case HistoryUpdatedBy.bloc1:
//         return _handleBloc1UpdatedHistory(context);
//       case HistoryUpdatedBy.bloc2:
//         return _handleBloc2UpdatedHistory(context);
//       case HistoryUpdatedBy.bloc3:
//         return _handleBloc3UpdatedHistory(context);
//       default:
//         return;
//     }
//   }
//
//   void _handleBloc1UpdatedHistory(BuildContext context) {
//     final messageEnum = cardFundingAuthTypeEnumMap[initFundingResponse.message];
//     final payload = initFundingResponse.payload;
//
//     switch (messageEnum) {
//       case CardFundingAuthTypeEnum.pinRequired:
//         Navigator.pushNamed(
//           context,
//           RouteNames.enterCardPinViewWIthArgs,
//           arguments: payload,
//         );
//         return;
//       case CardFundingAuthTypeEnum.redirecting:
//         Navigator.pushNamed(
//           context,
//           RouteNames.breadBrowserViewWithArgs,
//           arguments: initFundingResponse,
//         );
//         return;
//       case CardFundingAuthTypeEnum.addressRequired:
//         Navigator.pushNamed(context, RouteNames.enterCardAddressView,
//             arguments: payload);
//         return;
//       case CardFundingAuthTypeEnum.verify:
//         context.read<PaymentBloc>().add(
//               CardFundingVerificationEvent(
//                 transactionId: initFundingResponse.transactionId ?? '',
//               ),
//             );
//         return;
//       case null:
//         _showErrorSnackBar(context,
//             'Failed to initialize transaction. Please try again later');
//         return;
//     }
//   }
//
//   void _handleBloc2UpdatedHistory(BuildContext context) {
//     Navigator.pushNamedAndRemoveUntil(
//         context,
//         RouteNames.paymentSuccessfulViewWithArg,
//         arguments: 'Declined',
//         (Route<dynamic> route) => false,);
//     return;
//   }
//
//   void _handleBloc3UpdatedHistory(BuildContext context) {
//     final fundingStatus = fundingStatusMap[verificationStatus];
//
//     switch (fundingStatus) {
//       case FundingStatus.successful:
//         Navigator.pushNamed(context, RouteNames.paymentSuccessfulViewWithArg);
//         return;
//       case FundingStatus.pending:
//         Navigator.pushNamed(
//           context,
//           RouteNames.paymentSuccessfulViewWithArg,
//           arguments: 'Pending',
//         );
//         return;
//       case FundingStatus.failed:
//         Navigator.pushNamed(
//           context,
//           RouteNames.paymentSuccessfulViewWithArg,
//           arguments: 'Failed',
//         );
//         return;
//       case null:
//         Navigator.pushNamed(context, RouteNames.paymentSuccessfulViewWithArg,
//             arguments: 'Failed');
//         return;
//       case FundingStatus.none:
//         Navigator.pushNamed(
//           context,
//           RouteNames.paymentSuccessfulViewWithArg,
//           arguments: 'Failed',
//         );
//     }
//   }
//
//   void _handleVerifiedCardFunding(
//     BuildContext context,
//     VerifiedCardFunding state,
//     String historyId,
//   ) {
//     setState(() {
//       whoUpdatedHistory = HistoryUpdatedBy.bloc3;
//       verificationStatus = state.status;
//     });
//
//     final fundingStatus = fundingStatusMap[verificationStatus];
//
//     context.read<PaymentBloc>().add(
//           UpdateCardFundingHistoryEvent(
//             historyId: historyId,
//             values: [
//               initFundingResponse.transactionId ?? 'none',
//               verificationStatus,
//               DateTime.now().toIso8601String(),
//               if (fundingStatus == FundingStatus.failed)
//                 FailureStage.verification.name,
//             ],
//             culprits: [
//               UpdateCardFundingHistoryCulprit.transactionId,
//               UpdateCardFundingHistoryCulprit.fundingStatus,
//               UpdateCardFundingHistoryCulprit.date,
//               if (fundingStatus == FundingStatus.failed)
//                 UpdateCardFundingHistoryCulprit.failureStage,
//             ],
//           ),
//         );
//   }
//
//   void _handlePaymentHistoryError(
//       BuildContext context, PaymentHistoryError state) {
//     log('EnterAmountScreen; PaymentHistory: ${state.message}');
//     _showErrorSnackBar(context, 'Funding initialisation failed');
//
//     Future<void>.delayed(const Duration(seconds: 3), () {
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         RouteNames.dashboard,
//         (Route<dynamic> route) => false,
//       );
//     });
//     return;
//   }
//
//   void _handlePaymentError(
//     BuildContext context,
//     PaymentError state,
//     PaymentCardEntity card,
//     UserEntity user,
//   ) {
//     setState(() {
//       whoUpdatedHistory = HistoryUpdatedBy.bloc2;
//     });
//     log('Init Payment Error: ${state.message}');
//
//     final history = _createCardFundingHistory(
//       status: FundingStatus.failed,
//       failureMessage: state.message,
//       failureStage: FailureStage.initialization,
//       card: card,
//       user: user,
//     );
//
//     context
//         .read<PaymentBloc>()
//         .add(AddNewCardFundingHistoryEvent(history: history));
//   }
//
//   CardFundingHistoryEntity _createCardFundingHistory({
//     required FundingStatus status,
//     required String failureMessage,
//     FailureStage? failureStage,
//     required PaymentCardEntity card,
//     required UserEntity user,
//   }) {
//     return CardFundingHistoryEntity(
//       id: '',
//       userId: user.id,
//       transactionId: initFundingResponse.transactionId ?? 'none',
//       cardHolderName: card.holderName ?? '',
//       userEmail: user.email,
//       cardNumber: card.number,
//       fundingStatus: status,
//       date: DateTime.now().toIso8601String(),
//       time: DateTime.now().toIso8601String(),
//       failureMessage: failureMessage,
//       failureStage: failureStage,
//     );
//   }
//
//   void _showErrorSnackBar(BuildContext context, String content) {
//     HBMSnackBar.show(
//       context: context,
//       content: content,
//     );
//   }
// }

class EnterAmountView extends ConsumerStatefulWidget {
  const EnterAmountView({super.key});

  @override
  ConsumerState<EnterAmountView> createState() => _EnterAmountViewState();
}

class _EnterAmountViewState extends ConsumerState<EnterAmountView> {
  InitializeCardFundingResponseEntity initFundingResponse =
      const InitializeCardFundingResponseEntity.empty();
  HistoryUpdatedBy whoUpdatedHistory = HistoryUpdatedBy.init;
  String verificationStatus = '';
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final card =
        ref.watch(selectedPaymentCardProvider) ?? PaymentCardEntity.empty();
    final user = ref.watch(userProvider);
    final historyId = ref.watch(cardFundingHistoryIdProvider);

    return BlocProvider(
      create: (context) => ref.read(paymentBlocProvider),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HBMColors.coolGrey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const HBMTextWidget(data: 'Enter Amount'),
        ),
        body: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is InitializedCardFunding) {
              _handleInitializedCardFunding(context, state, card, user);
            } else if (state is AddedNewCardFundingHistory) {
              _handleAddedNewCardFundingHistory(context, state);
            } else if (state is VerifiedCardFunding) {
              _handleVerifiedCardFunding(context, state, historyId);
            } else if (state is PaymentHistoryError) {
              _handlePaymentHistoryError(context, state);
            } else if (state is PaymentError) {
              _handlePaymentError(context, state, card, user);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: context.height * 0.09),
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _controller,
                    cursorColor: HBMColors.mediumGrey,
                    style: TextStyle(fontSize: context.width * 0.15),
                    onChanged: (text) => setState(() {}),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0.00',
                      alignLabelWithHint: true,
                      hintStyle: TextStyle(
                        fontFamily: HBMFonts.exo2,
                        fontSize: context.width * 0.15,
                        color: HBMColors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: context.height * 0.04),
                  child: TextButton(
                    onPressed: () {
                      _handleContinuePressed(context, card);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: _controller.text.isNotEmpty
                          ? HBMColors.charcoalGrey
                          : HBMColors.grey,
                      fixedSize:
                          Size(context.width * 0.80, context.height * 0.06),
                    ),
                    child: HBMTextWidget(
                      data: 'Continue',
                      color: HBMColors.coolGrey,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleContinuePressed(BuildContext context, PaymentCardEntity card) {
    if (_controller.text.isEmpty || double.parse(_controller.text) < 1) {
      HBMSnackBar.show(
          context: context, content: 'Please enter a valid amount',);
      return;
    }

    context.read<PaymentBloc>().add(
          InitializeCardFundingEvent(
            cardNumber: card.number.replaceAll(' ', ''),
            cvv: card.ccv,
            expiryYear: card.expiryDate.substring(3, 5),
            expiryMonth: card.expiryDate.substring(0, 2),
            currency: 'NGN',
            amount: _controller.text,
            redirectUrl: 'www.google.com',
            fullName: card.holderName,
            email: 'gm.oluwafemi@gmail.com',
            phone: '07058919193',
            ref: DateTime.now().microsecondsSinceEpoch.toString(),
          ),
        );
  }

  void _handleInitializedCardFunding(BuildContext context,
      InitializedCardFunding state, PaymentCardEntity card, UserEntity user,) {
    ref.invalidate(cardFundingHistoryIdProvider);
    setState(() {
      initFundingResponse = state.response;
      whoUpdatedHistory = HistoryUpdatedBy.bloc1;
    });

    log('Payment Initialized: ${initFundingResponse.message}');

    final history = _createCardFundingHistory(
      status: FundingStatus.pending,
      failureMessage: '',
      failureStage: FailureStage.none,
      card: card,
      user: user,
    );
    context.read<PaymentBloc>().add(
          AddNewCardFundingHistoryEvent(history: history),
        );
  }

  void _handleAddedNewCardFundingHistory(
      BuildContext context, AddedNewCardFundingHistory state,) {
    log('History written: ${state.historyId}');
    ref.read(cardFundingHistoryIdProvider.notifier).state = state.historyId;

    switch (whoUpdatedHistory) {
      case HistoryUpdatedBy.bloc1:
        _handleBloc1UpdatedHistory(context);
      case HistoryUpdatedBy.bloc2:
        _handleBloc2UpdatedHistory(context);
      case HistoryUpdatedBy.bloc3:
        _handleBloc3UpdatedHistory(context);
      default:
        break;
    }
  }

  void _handleBloc1UpdatedHistory(BuildContext context) {
    final messageEnum = cardFundingAuthTypeEnumMap[initFundingResponse.message];
    final payload = initFundingResponse.payload;

    switch (messageEnum) {
      case CardFundingAuthTypeEnum.pinRequired:
        Navigator.pushNamed(
          context,
          RouteNames.enterCardPinViewWIthArgs,
          arguments: payload,
        );
      case CardFundingAuthTypeEnum.redirecting:
        Navigator.pushNamed(
          context,
          RouteNames.breadBrowserViewWithArgs,
          arguments: initFundingResponse,
        );
      case CardFundingAuthTypeEnum.addressRequired:
        Navigator.pushNamed(context, RouteNames.enterCardAddressView,
            arguments: payload,);
      case CardFundingAuthTypeEnum.verify:
        context.read<PaymentBloc>().add(CardFundingVerificationEvent(
            transactionId: initFundingResponse.transactionId ?? '',),);
      case null:
        HBMSnackBar.show(
            context: context,
            content:
                'Failed to initialize transaction. Please try again later',);
    }
  }

  void _handleBloc2UpdatedHistory(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.paymentSuccessfulViewWithArg,
      arguments: 'Declined',
      (Route<dynamic> route) => false,
    );
  }

  void _handleBloc3UpdatedHistory(BuildContext context) {
    final fundingStatus = fundingStatusMap[verificationStatus];

    switch (fundingStatus) {
      case FundingStatus.successful:
        Navigator.pushNamed(context, RouteNames.paymentSuccessfulViewWithArg);
      case FundingStatus.pending:
        Navigator.pushNamed(context, RouteNames.paymentSuccessfulViewWithArg,
            arguments: 'Pending',);
      case FundingStatus.failed:
        Navigator.pushNamed(context, RouteNames.paymentSuccessfulViewWithArg,
            arguments: 'Failed',);
      case null:
      case FundingStatus.none:
        Navigator.pushNamed(context, RouteNames.paymentSuccessfulViewWithArg,
            arguments: 'Failed',);
    }
  }

  void _handleVerifiedCardFunding(
      BuildContext context, VerifiedCardFunding state, String historyId,) {
    setState(() {
      whoUpdatedHistory = HistoryUpdatedBy.bloc3;
      verificationStatus = state.status;
    });

    final fundingStatus = fundingStatusMap[verificationStatus];

    context.read<PaymentBloc>().add(
          UpdateCardFundingHistoryEvent(
            historyId: historyId,
            values: [
              initFundingResponse.transactionId ?? 'none',
              verificationStatus,
              DateTime.now().toIso8601String(),
              if (fundingStatus == FundingStatus.failed)
                FailureStage.verification.name,
            ],
            culprits: [
              UpdateCardFundingHistoryCulprit.transactionId,
              UpdateCardFundingHistoryCulprit.fundingStatus,
              UpdateCardFundingHistoryCulprit.date,
              if (fundingStatus == FundingStatus.failed)
                UpdateCardFundingHistoryCulprit.failureStage,
            ],
          ),
        );
  }

  void _handlePaymentHistoryError(
      BuildContext context, PaymentHistoryError state,) {
    log('EnterAmountScreen; PaymentHistory: ${state.message}');
    HBMSnackBar.show(
        context: context, content: 'Funding initialisation failed',);

    Future<void>.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.dashboard,
        (Route<dynamic> route) => false,
      );
    });
  }

  void _handlePaymentError(
    BuildContext context,
    PaymentError state,
    PaymentCardEntity card,
    UserEntity user,
  ) {
    setState(() {
      whoUpdatedHistory = HistoryUpdatedBy.bloc2;
    });
    log('Init Payment Error: ${state.message}');

    final history = _createCardFundingHistory(
      status: FundingStatus.failed,
      failureMessage: state.message,
      failureStage: FailureStage.initialization,
      card: card,
      user: user,
    );
    context.read<PaymentBloc>().add(
          AddNewCardFundingHistoryEvent(history: history),
        );
  }

  CardFundingHistoryEntity _createCardFundingHistory({
    required FundingStatus status,
    required String failureMessage,
    required PaymentCardEntity card,
    required UserEntity user,
    FailureStage? failureStage,
  }) {
    return CardFundingHistoryEntity(
      id: '',
      userId: user.id,
      transactionId: initFundingResponse.transactionId ?? 'none',
      cardHolderName: card.holderName ?? '',
      userEmail: user.email,
      cardNumber: card.number,
      fundingStatus: status,
      date: DateTime.now().toIso8601String(),
      time: DateTime.now().toIso8601String(),
      failureMessage: failureMessage,
      failureStage: failureStage,
    );
  }
}
