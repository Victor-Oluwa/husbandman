import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/strings/hbm_strings.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/services/injection/auth/auth_injection.dart';
import 'package:husbandman/core/services/injection/onboarding/onboarding_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:husbandman/src/onboarding/presentation/cubit/onboarding_cubit.dart';

class UserVerificationPage extends ConsumerStatefulWidget {
  const UserVerificationPage({super.key});

  static const routeName = 'user-verification';

  @override
  ConsumerState<UserVerificationPage> createState() =>
      _UserVerificationPageState();
}

class _UserVerificationPageState extends ConsumerState<UserVerificationPage> {
  late OnboardingCubit onboardingCubit;

  @override
  void initState() {
    onboardingCubit = ref.read(onboardingCubitProvider);
    log('User Verification init state.');
    //Checks if the user is using the app for the first time
    onboardingCubit.checkIfUserIsFirstTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ref.read(onboardingCubitProvider)),
        BlocProvider(create: (context) => ref.read(authBlocProvider)),
      ],
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<OnboardingCubit, OnboardingState>(
              listener: (context, state) {
                if (state is FirstTimerStatus) {
                  if (state.isFirstTimer) {
                    //If user is first timer. They are navigated to Onboarding
                    log('User is first timer');
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteNames.onboardingScreen,
                      (route) => false,
                    );
                    return;
                  }

                  if (!state.isFirstTimer) {
                    // If user is not a first timer. User's token is retrieved for verification
                    log('User is not first timer');
                    return context
                        .read<AuthBloc>()
                        .add(RetrieveUserTokenEvent());
                  }
                }
              },
            ),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is UserTokenRetrieved) {
                  //User token is validated after being retrieved
                  log('User token retrieved: ${state.token}');
                  context
                      .read<AuthBloc>()
                      .add(ValidateUserEvent(token: state.token));
                }

                if (state is UserValidated) {
                  log('User validated successfully');
                  //If the user token is valid. The user object is saved in the state
                  context.read<AuthBloc>().add(
                        SetUserEvent(
                          user: state.user,
                        ),
                      );
                }

                if (state is UserSet) {
                  log('User Set');
                  // If the user object is saved successfully.User is navigated to the home screen
                  final user = ref.read(userProvider);
                  user.userType == HBMStrings.admin
                      ? Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteNames.adminHome,
                          (route) => false,
                        )
                      : Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteNames.homePage,
                          (route) => false,
                        );
                  return;
                }

                if (state is AuthError) {
                  log('Auth Error received: ${state.message}');
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
          child: Center(
            child: HBMTextWidget(
              data: 'HBM Logo',
              color: HBMColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
