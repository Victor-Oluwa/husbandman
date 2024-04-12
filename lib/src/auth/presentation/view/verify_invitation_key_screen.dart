import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';

class VerifyInvitationKeyScreen extends StatelessWidget {
  const VerifyInvitationKeyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: HBMColors.almond,
      body: SafeArea(
        child: Center(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is FarmerInvitationKeyValidated) {
                context.read<AuthBloc>().add(
                      CacheVerifiedInvitationTokenEvent(
                          token: state.invitationKey),
                    );
              } else if (state is AuthError) {
                HBMSnackBar.show(context: context, content: state.message);
              }

              if (state is InvitationTokenCached) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.farmerSignUpScreen,
                  (route) => false,
                );
              } else if (state is AuthError) {
                HBMSnackBar.show(context: context, content: state.message);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(
                    height: context.width * 0.05,
                  ),
                  HBMTextWidget(
                    data: 'Input Key',
                    fontSize: context.width * 0.09,
                  ),
                  SizedBox(
                    height: context.width * 0.65,
                  ),
                  OtpTextField(
                    numberOfFields: 7,
                    fieldWidth: context.width * 0.09,
                    cursorColor: HBMColors.white,
                    showFieldAsBox: true,
                    enabledBorderColor: HBMColors.white,
                    focusedBorderColor: HBMColors.slateGray,
                    onSubmit: (String key) {
                      context.read<AuthBloc>().add(
                            ValidateFarmerInvitationKeyEvent(
                              invitationKey: key,
                            ),
                          );
                    }, // end onSubmit
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
