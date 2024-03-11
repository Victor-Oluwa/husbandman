import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:husbandman/core/common/views/page_under_construction.dart';
import 'package:husbandman/core/services/injection_container.dart';
import 'package:husbandman/src/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:husbandman/src/onboarding/presentation/view/onboarding_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnboardingScreen.routeName:
      return _pageBuilder(
        (context) => BlocProvider(
          create: (context) => sl<OnboardingCubit>(),
          child: const OnboardingScreen(),
        ),
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
