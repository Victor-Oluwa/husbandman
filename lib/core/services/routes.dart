import 'package:flutter/material.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/common/views/page_under_construction.dart';
import 'package:husbandman/core/services/route_names.dart';
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
import 'package:husbandman/src/product_manager/presentation/view/product_details.dart';
import 'package:husbandman/src/product_manager/presentation/view/product_view_by_category.dart';
import 'package:husbandman/src/product_manager/presentation/view/upload_product_view.dart';
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
        (p0) => const Dashboard(),
        settings: settings,
      );
    case RouteNames.productDetails:
      final arg = settings.arguments! as ProductModel;
      return _pageBuilder(
        (p0) => ProductDetailsView(product: arg,),
        settings: settings,
      );
    case RouteNames.buyerProfile:
      return _pageBuilder(
            (p0) => const BuyerProfileView(),
        settings: settings,
      );
    case RouteNames.cartView:
      return _pageBuilder(
            (p0) => const  CartView(),
        settings: settings,
      );
    case RouteNames.productViewByCategory:
      final category = settings.arguments! as String;
      return _pageBuilder(
            (p0) => ProductViewByCategory(category: category),
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
