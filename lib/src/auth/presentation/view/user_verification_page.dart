import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:husbandman/src/onboarding/presentation/cubit/onboarding_cubit.dart';

class UserVerificationPage extends StatefulWidget {
  const UserVerificationPage({super.key});

  static const routeName = 'user-verification';

  @override
  State<UserVerificationPage> createState() => _UserVerificationPageState();
}

class _UserVerificationPageState extends State<UserVerificationPage> {
  @override
  void initState() {
    //Checks if the user is using the app for the first time
    context.read<OnboardingCubit>().checkIfUserIsFirstTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<OnboardingCubit, OnboardingState>(
            listener: (context, state) {
              if (state is FirstTimerStatus && state.isFirstTimer) {
                //If user is firs timer. They are navigated to Onboarding
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.onboardingScreen, 
                  (route) => false,
                );
              } else if (state is FirstTimerStatus && !state.isFirstTimer) {
                // If user is not a first timer. User's token is retrieved for verification
                context.read<AuthBloc>().add(RetrieveUserTokenEvent());
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UserTokenRetrieved) {
                //User token is validated after being retrieved
                context
                    .read<AuthBloc>()
                    .add(ValidateUserEvent(token: state.token));
              } else if (state is AuthError) {
                ///If validation fails user is navigated to the Sign In screen
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.signInScreen,
                  (route) => false,
                );
                return;
              }

              if (state is UserValidated) {
                //If the user token is valid. The user object is saved in the Riverpod state
                final user = state.user as UserModel;
                context.read<AuthBloc>().add(SetUserEvent(user: user.toMap()));

                if (state is UserSet) {
                  // If the user object is saved successfully.User is navigated to the home screen
                  user.type == 'Admin'
                      ? log('Navigating to Admin HomeScreen')
                      : log('Navigating to User HomeScreen');
                }
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.signInScreen,
                  (route) => false,
                );
                return;
              }
            },
          ),
        ],
        child: const Center(
          child: HBMTextWidget(data: 'HBM Logo'),
        ),
      ),
    );
  }
}
