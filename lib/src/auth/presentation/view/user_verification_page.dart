import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/common/app/provider/user_provider.dart';
import 'package:husbandman/core/common/strings/hbm_strings.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:husbandman/src/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:husbandman/src/product_manager/presentation/bloc/product_manager_bloc.dart';

class UserVerificationPage extends ConsumerStatefulWidget {
  const UserVerificationPage({super.key});

  static const routeName = 'user-verification';

  @override
  ConsumerState<UserVerificationPage> createState() =>
      _UserVerificationPageState();
}

class _UserVerificationPageState extends ConsumerState<UserVerificationPage> {
  @override
  void initState() {
    log('User Verification init state here.');
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
                //If user is first timer. They are navigated to Onboarding
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
          // BlocListener<ProductManagerBloc, ProductManagerState>(
          //   listener: (context, state) {
          //     if (state is FetchedProduct) {
          //       final products = <ProductModel>[];
          //
          //       for (final element in state.products) {
          //         products.add(element as ProductModel);
          //       }
          //
          //       context.read<ProductManagerBloc>().add(SetGeneralProductEvent(
          //             setProductType: SetProductType.renew,
          //             productObject: products,
          //           ));
          //
          //       log('Random products: $products');
          //     }
          //     if (state is GeneralProductSet) {
          //
          //     }
          //   },
          // ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UserTokenRetrieved) {
                //User token is validated after being retrieved
                log('Token retrieved: ${state.token}');
                context
                    .read<AuthBloc>()
                    .add(ValidateUserEvent(token: state.token));
              }

              if (state is UserValidated) {
                log('User validated');
                //If the user token is valid. The user object is saved in the Riverpod state
                final user = state.user as UserModel;
                context.read<AuthBloc>().add(SetUserEvent(user: user.toMap()));
              }

              if (state is UserSet) {
                log('User Set');
                // If the user object is saved successfully.User is navigated to the home screen
                final user = ref.read(userProvider);
                user.type == HBMStrings.admin
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
          child: HBMTextWidget(data: 'HBM Logo', color: HBMColors.black,),
        ),
      ),
    );
  }
}
