import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/entities/payment_card_entity.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/usecase/fetch_cart.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_address_auth_response_entity.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_pin_auth_response_entity.dart';
import 'package:husbandman/src/payment/domain/entity/initialize_card_funding_response_entity.dart';
import 'package:husbandman/src/payment/domain/usecase/add_new_card.dart';
import 'package:husbandman/src/payment/domain/usecase/card_funding_address_auth.dart';
import 'package:husbandman/src/payment/domain/usecase/card_funding_pin_auth.dart';
import 'package:husbandman/src/payment/domain/usecase/card_funding_verification.dart';
import 'package:husbandman/src/payment/domain/usecase/delete_card.dart';
import 'package:husbandman/src/payment/domain/usecase/fetch_cards.dart';
import 'package:husbandman/src/payment/domain/usecase/initialize_card_funding.dart';
import 'package:husbandman/src/payment/domain/usecase/set_card.dart';
import 'package:husbandman/src/payment/domain/usecase/card_funding_otp_validation.dart';

part 'payment_event.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc(
    AddNewCard addNewCard,
    DeleteCard deleteCard,
    FetchCards fetchCards,
    SetCard setCard,
    InitializeCardFunding initializeCardFunding,
    CardFundingPinAuth cardFundingPinAuth,
    CardFundingOtpValidation validateCardFunding,
    CardFundingAddressAuth cardFundingAddressAuth,
    CardFundingVerification cardFundingVerification,
  )   : _addNewCard = addNewCard,
        _deleteCard = deleteCard,
        _fetchCards = fetchCards,
        _setCard = setCard,
        _initializeCardFunding = initializeCardFunding,
        _cardFundingPinAuth = cardFundingPinAuth,
        _cardFundingOtpValidation = validateCardFunding,
        _cardFundingAddressAuth = cardFundingAddressAuth,
        _cardFundingVerification = cardFundingVerification,
        super(PaymentInitial()) {
    on<PaymentEvent>((event, emit) {
      emit(PaymentLoading());
    });

    on<AddNewCardEvent>(_addNewCardHandler);
    on<DeleteCardEvent>(_deleteCardHandler);
    on<FetchCardsEvent>(_fetchCardsHandler);
    on<SetCardEvent>(_setCardHandler);
    on<InitializeCardFundingEvent>(_initializeCardFundingHandler);
    on<CardFundingPinAuthEvent>(_cardFundingPinAuthHandler);
    on<CardFundingOtpValidationEvent>(_cardFundingOtpValidationHandler);
    on<CardFundingAddressAuthEvent>(_cardFundingAddressAuthHandler);
    on<CardFundingVerificationEvent>(_cardFundingVerificationHandler);
  }

  final AddNewCard _addNewCard;
  final DeleteCard _deleteCard;
  final FetchCards _fetchCards;
  final SetCard _setCard;
  final InitializeCardFunding _initializeCardFunding;
  final CardFundingPinAuth _cardFundingPinAuth;
  final CardFundingOtpValidation _cardFundingOtpValidation;
  final CardFundingAddressAuth _cardFundingAddressAuth;
  final CardFundingVerification _cardFundingVerification;

  Future<void> _addNewCardHandler(
    AddNewCardEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final result = await _addNewCard(
      AddNewCardParams(
        type: event.type,
        ccv: event.ccv,
        expiryDate: event.expiryDate,
        cardNumber: event.cardNumber,
        holderName: event.holderName,
        ownerId: event.ownerId,
      ),
    );

    result.fold(
      (l) => emit(PaymentError(l.errorMessage)),
      (r) => emit(
        NewCardAdded(r),
      ),
    );
  }

  Future<void> _deleteCardHandler(
    DeleteCardEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final result = await _deleteCard(event.cartId);

    result.fold(
      (l) => emit(PaymentError(l.errorMessage)),
      (_) => emit(
        const CardDeleted(),
      ),
    );
  }

  Future<void> _fetchCardsHandler(
    FetchCardsEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final result = await _fetchCards(event.userId);

    result.fold(
      (l) => emit(PaymentError(l.errorMessage)),
      (r) => emit(FetchedCards(r)),
    );
  }

  Future<void> _setCardHandler(
    SetCardEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final result = await _setCard(
      SetCardParams(
        cards: event.cards,
        replaceList: event.replaceList,
      ),
    );

    result.fold(
      (l) => emit(PaymentError(l.errorMessage)),
      (_) => emit(
        const CardSet(),
      ),
    );
  }

  Future<void> _cardFundingPinAuthHandler(
    CardFundingPinAuthEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final result = await _cardFundingPinAuth(
      CardFundingPinAuthParams(
        pin: event.pin,
        payload: event.payload,
      ),
    );

    result.fold(
      (l) => emit(PaymentError(l.errorMessage)),
      (r) => emit(AuthorizedCardFundingWithPin(r)),
    );
  }

  Future<void> _cardFundingAddressAuthHandler(
    CardFundingAddressAuthEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final result = await _cardFundingAddressAuth(
      CardFundingAddressAuthParams(
        payload: event.payload,
        address: event.address,
        city: event.city,
        state: event.state,
        country: event.country,
        zipCode: event.zipCode,
      ),
    );

    result.fold(
      (l) => emit(PaymentError(l.errorMessage)),
      (r) => emit(
        AuthorizedCardFundingWithAddress(r),
      ),
    );
  }

  Future<void> _cardFundingOtpValidationHandler(
    CardFundingOtpValidationEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final result = await _cardFundingOtpValidation(
      CardFundingOtpValidationParams(
        otp: event.otp,
        ref: event.ref,
      ),
    );

    result.fold(
      (l) => emit(PaymentError(l.errorMessage)),
      (r) => emit(ValidatedCardFundingWithOtp(r)),
    );
  }

  Future<void> _initializeCardFundingHandler(
    InitializeCardFundingEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final result = await _initializeCardFunding(
      InitializeCardFundingParams(
        cardNumber: event.cardNumber,
        cvv: event.cvv,
        expiryYear: event.expiryYear,
        expiryMonth: event.expiryMonth,
        currency: event.currency,
        amount: event.amount,
        redirectUrl: event.redirectUrl,
        fullName: event.fullName,
        email: event.email,
        phone: event.phone,
        ref: event.ref,
      ),
    );

    result.fold(
      (l) => emit(PaymentError(l.errorMessage)),
      (r) => emit(
        InitializedCardFunding(r),
      ),
    );
  }

  Future<void> _cardFundingVerificationHandler(
    CardFundingVerificationEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final result = await _cardFundingVerification(event.transactionId);

    result.fold(
      (l) => emit(PaymentError(l.errorMessage)),
      (r) => emit(
        VerifiedCardFunding(r),
      ),
    );
  }
}
