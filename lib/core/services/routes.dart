import 'package:flutter/material.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/common/views/page_under_construction.dart';
import 'package:husbandman/core/common/widgets/bread_browser.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/admin/presentation/view/key_generator_screen.dart';
import 'package:husbandman/src/auth/presentation/view/account_type_screen.dart';
import 'package:husbandman/src/auth/presentation/view/buyer_sign_up_screen.dart';
import 'package:husbandman/src/auth/presentation/view/farmer_signUp_screen.dart';
import 'package:husbandman/src/auth/presentation/view/home_screen.dart';
import 'package:husbandman/src/auth/presentation/view/sign_in_screen.dart';
import 'package:husbandman/src/auth/presentation/view/user_verification_page.dart';
import 'package:husbandman/src/auth/presentation/view/verify_invitation_key_screen.dart';
import 'package:husbandman/src/cart/presentation/views/cart_view.dart';
import 'package:husbandman/src/onboarding/presentation/view/onboarding_screen.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_address_auth_response_entity.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_pin_auth_response_entity.dart';
import 'package:husbandman/src/payment/domain/entity/initialize_card_funding_response_entity.dart';
import 'package:husbandman/src/payment/presentation/view/all_cards_view.dart';
import 'package:husbandman/src/payment/presentation/view/add_card_view.dart';
import 'package:husbandman/src/payment/presentation/view/enter_amount_view.dart';
import 'package:husbandman/src/payment/presentation/view/enter_card_address_view.dart';
import 'package:husbandman/src/payment/presentation/view/enter_card_pin_view.dart';
import 'package:husbandman/src/payment/presentation/view/enter_otp_view.dart';
import 'package:husbandman/src/payment/presentation/view/payment_successful_view.dart';
import 'package:husbandman/src/product_manager/presentation/view/product_details.dart';
import 'package:husbandman/src/product_manager/presentation/view/product_view_by_category.dart';
import 'package:husbandman/src/product_manager/presentation/view/upload_product/upload_product_main_widget.dart';
import 'package:husbandman/src/product_manager/presentation/view/seller_products_view.dart';
import 'package:husbandman/src/product_manager/presentation/view/seller_product_view_by_category.dart';
import 'package:husbandman/src/profile/presentation/buyer_profile_view.dart';
import 'package:husbandman/src/profile/presentation/dashboard.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.onboardingScreen:
      return _pageBuilder(
        (context) => const OnboardingScreen(),
        settings: settings,
      );

    case RouteNames.userVerificationScreen:
      return _pageBuilder(
        (context) => const UserVerificationPage(),
        settings: settings,
      );

    case RouteNames.accountTypeScreen:
      return _pageBuilder(
        (context) => const AccountTypeScreen(),
        settings: settings,
      );

    case RouteNames.signInScreen:
      return _pageBuilder(
        (context) => const SignInScreen(),
        settings: settings,
      );
    case RouteNames.farmerSignUpScreen:
      return _pageBuilder(
        (context) => const FarmerSignUpScreen(),
        settings: settings,
      );

    case RouteNames.buyerSignUpScreen:
      return _pageBuilder(
        (p0) => const BuyerSignUpScreen(),
        settings: settings,
      );

    case RouteNames.generateToken:
      return _pageBuilder(
        (p0) => const KeyGeneratorScreen(),
        settings: settings,
      );

    case RouteNames.verifyInvitationKey:
      return _pageBuilder(
        (p0) => const VerifyInvitationKeyScreen(),
        settings: settings,
      );

    case RouteNames.homePage:
      return _pageBuilder(
        (p0) => const HomeScreen(),
        settings: settings,
      );

    case RouteNames.adminHome:
      return _pageBuilder(
        (p0) => const KeyGeneratorScreen(),
        settings: settings,
      );

    case RouteNames.sellerProducts:
      return _pageBuilder(
        (p0) => const SellerProductView(),
        settings: settings,
      );

    case RouteNames.sellerProductViewByCategory:
      return _pageBuilder(
        (p0) => const SellerProductViewByCategory(),
        settings: settings,
      );

    case RouteNames.addProduct:
      return _pageBuilder(
        (p0) => const UploadProductView(),
        settings: settings,
      );

    case RouteNames.dashboard:
      return _pageBuilder(
        (p0) => Dashboard(),
        settings: settings,
      );
    case RouteNames.productDetails:
      final arg = settings.arguments! as ProductModel;
      return _pageBuilder(
        (p0) => ProductDetailsView(
          product: arg,
        ),
        settings: settings,
      );
    case RouteNames.buyerProfile:
      return _pageBuilder(
        (p0) => const BuyerProfileView(),
        settings: settings,
      );
    case RouteNames.cartView:
      return _pageBuilder(
        (p0) => const CartView(),
        settings: settings,
      );
    case RouteNames.allCardView:
      return _pageBuilder(
        (p0) => const AllCardsView(),
        settings: settings,
      );
    case RouteNames.addCardView:
      return _pageBuilder(
        (p0) => const AddCardView(),
        settings: settings,
      );
    case RouteNames.enterAmountView:
      return _pageBuilder(
        (p0) => const EnterAmountView(),
        settings: settings,
      );
    case RouteNames.enterCardPinViewWIthArgs:
      if (settings.arguments == null) {
        return _pageBuilder(
          (p0) => const PageUnderConstruction(),
          settings: settings,
        );
      }
      final payload = settings.arguments! as DataMap;
      return _pageBuilder(
        (p0) => EnterCardPinView(
          payload: payload,
        ),
        settings: settings,
      );
    case RouteNames.productViewByCategory:
      final category = settings.arguments! as String;
      return _pageBuilder(
        (p0) => ProductViewByCategory(category: category),
        settings: settings,
      );
    case RouteNames.enterOTPViewWithArgs:
      if (settings.arguments == null) {
        return _pageBuilder(
          (p0) => const PageUnderConstruction(),
          settings: settings,
        );
      }
      final argument = settings.arguments;
      if (argument is CardFundingPinAuthResponseEntity) {
        return _pageBuilder(
          (p0) => EnterOTPView(
            otpMessage: argument.info,
            ref: argument.ref,
            transactionId: argument.transactionId,
          ),
          settings: settings,
        );
      } else {
        return _pageBuilder(
          (p0) => const PageUnderConstruction(),
          settings: settings,
        );
      }

    case RouteNames.enterCardAddressView:
      if (settings.arguments == null || settings.arguments is! DataMap) {
        return _pageBuilder(
          (_) => const PageUnderConstruction(),
          settings: settings,
        );
      }
      final payload = settings.arguments! as DataMap;
      return _pageBuilder(
        (_) => EnterCardAddressView(
          payload: payload,
        ),
        settings: settings,
      );
    case RouteNames.breadBrowserViewWithArgs:
      if (settings.arguments == null) {
        return _pageBuilder(
          (p0) => const PageUnderConstruction(),
          settings: settings,
        );
      }

      final argument = settings.arguments;

      if (argument is CardFundingPinAuthResponseEntity) {
        return _pageBuilder(
          (p0) => BreadBrowser(
            cardFundingPinAuthResponseEntity: argument,
          ),
          settings: settings,
        );
      } else if (argument is InitializeCardFundingResponseEntity) {
        return _pageBuilder(
          (p0) => BreadBrowser(
            initializeCardFundingResponseEntity: argument,
          ),
          settings: settings,
        );
      } else if (argument is CardFundingAddressAuthResponseEntity) {
        return _pageBuilder(
          (p0) => BreadBrowser(
            cardFundingAddressAuthResponseEntity: argument,
          ),
          settings: settings,
        );
      } else {
        return _pageBuilder(
          (p0) => const PageUnderConstruction(),
          settings: settings,
        );
      }
    case RouteNames.paymentSuccessfulViewWithArg:
      final status = settings.arguments;
      return _pageBuilder(
        (_) => PaymentSuccessfulView(status: status?.toString()),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, __, _) => page(context),
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
