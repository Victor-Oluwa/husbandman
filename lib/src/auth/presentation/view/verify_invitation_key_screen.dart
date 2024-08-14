import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/widgets/bread_text_field.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/injection/auth/auth_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';

class VerifyInvitationKeyScreen extends ConsumerStatefulWidget {
  const VerifyInvitationKeyScreen({super.key});

  @override
  ConsumerState<VerifyInvitationKeyScreen> createState() =>
      _VerifyInvitationKeyScreenState();
}

class _VerifyInvitationKeyScreenState
    extends ConsumerState<VerifyInvitationKeyScreen> {
  late TextEditingController _invitationKeyController;

  @override
  void initState() {
    _invitationKeyController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ref.read(authBlocProvider),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HBMColors.transparent,
          title: HBMTextWidget(
            data: 'Invitation Key',
            fontFamily: HBMFonts.exoLight,
            fontSize: context.width * 0.09,
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: HBMColors.coolGrey,
        body: SafeArea(
          child: Center(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is FarmerInvitationKeyValidated) {
                  log('Verified key: ${state.invitationKey}');
                  context.read<AuthBloc>().add(
                        CacheVerifiedInvitationTokenEvent(
                          token: state.invitationKey,
                        ),
                      );
                }

                if (state is InvitationTokenCached) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteNames.farmerSignUpScreen,
                    (route) => false,
                  );
                }

                  if (state is AuthError) {
                    log('Invitation key verification error: ${state.message}');
                  HBMSnackBar.show(context: context, content: state.message);
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Divider(
                      color: HBMColors.grey,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.05,
                      ),
                      child: BreadTextField(
                        cursorColor: HBMColors.lightGrey,
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                          height: 4,
                          letterSpacing: context.width * 0.03,
                          color: HBMColors.mediumGrey,
                          fontFamily: HBMFonts.quicksandNormal,
                        ),
                        keyboardType: TextInputType.number,
                        hintText: 'Input invitation key..',
                        hintStyle: TextStyle(
                          color: HBMColors.grey,
                          letterSpacing: context.width * 0.00,
                        ),
                        fieldController: _invitationKeyController,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HBMColors.grey),
                          borderRadius:
                              BorderRadius.circular(context.width * 0.03),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HBMColors.mediumGrey),
                          borderRadius:
                              BorderRadius.circular(context.width * 0.03),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(
                              ValidateFarmerInvitationKeyEvent(
                                invitationKey:
                                    _invitationKeyController.text.trim(),
                              ),
                            );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: context.height * 0.07,
                        width: context.width,
                        decoration: BoxDecoration(
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: HBMColors.charcoalGrey,
                            ),
                          ),
                        ),
                        child: HBMTextWidget(
                          fontSize: context.width * 0.05,
                          data: 'Next',
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
