import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:husbandman/core/common/strings/hbm_strings.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/src/onboarding/presentation/cubit/onboarding_cubit.dart';

import '../../../src/onboarding/presentation/view/onboarding_screen.dart';

class InitialAuth extends StatefulWidget {
  const InitialAuth({super.key});

  static const String routeName = '/';

  @override
  State<InitialAuth> createState() => _InitialAuthState();
}

class _InitialAuthState extends State<InitialAuth> {
  @override
  void didChangeDependencies() {
    context.read<OnboardingCubit>().checkIfUserIsFirstTimer();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          if (state is CheckingIfUserIsFirstTimer) {
            return const Center(
              child: HBMTextWidget(data: HBMStrings.initialAuthText),
            );
          }

          if (state is OnboardingStatus && state.isFirstTimer) {
            Navigator.pushNamedAndRemoveUntil(
                context, OnboardingScreen.routeName, (route) => false,);
          }else if(state is OnboardingStatus && !state.isFirstTimer){

            // TODO(Auth): Authenticate with server
          }

          return const Center(
            child: HBMTextWidget(data: HBMStrings.initialAuthText),
          );
        },
        listener: (context, state) {
          if (state is UserCached) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              'SignUpScreen',
              (route) => false,
            );
          }
        },
      ),
    );
  }
}
