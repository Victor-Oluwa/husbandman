import 'package:flutter/material.dart';
import 'package:husbandman/core/common/views/page_under_construction.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/admin/presentation/view/key_generator_screen.dart';
import 'package:husbandman/src/auth/presentation/view/account_type_screen.dart';
import 'package:husbandman/src/auth/presentation/view/buyer_sign_up_screen.dart';
import 'package:husbandman/src/auth/presentation/view/farmer_signUp_screen.dart';
import 'package:husbandman/src/auth/presentation/view/sign_in_screen.dart';
import 'package:husbandman/src/auth/presentation/view/user_verification_page.dart';
import 'package:husbandman/src/onboarding/presentation/view/onboarding_screen.dart';

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
