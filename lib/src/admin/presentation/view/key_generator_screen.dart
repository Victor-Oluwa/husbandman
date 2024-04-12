import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/admin/presentation/bloc/admin_bloc.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';

class KeyGeneratorScreen extends StatelessWidget {
  const KeyGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HBMColors.almond,
        body: Center(
          child: MultiBlocListener(
            listeners: [
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is SignedOut) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteNames.signInScreen,
                      (route) => false,
                    );
                  }
                },
              ),
            ],
            child: BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: context.height * 0.02),
                      child: GestureDetector(
                        onTap: () {
                          context.read<AuthBloc>().add(const SignOutEvent());
                        },
                        child: HBMTextWidget(
                          data: 'Generate Seller Key',
                          fontSize: context.width * 0.07,
                        ),
                      ),
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        HBMTextWidget(
                          data: state is InvitationTokenGenerated
                              ? state.token
                              : '- - - - - - - - - - -',
                          fontFamily: HBMFonts.exo2,
                          fontSize: context.width * 0.05,
                        ),
                        SizedBox(
                          height: context.height * 0.05,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(HBMColors.slateGray),
                          ),
                          onPressed: () {
                            context.read<AdminBloc>().add(
                                  const GenerateUniqueInvitationTokenEvent(),
                                );
                          },
                          child: HBMTextWidget(
                            data: 'Generate',
                            color: HBMColors.almond,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        if (state is InvitationTokenGenerated) {
                          context.read<AdminBloc>().add(
                                SaveInvitationTokenEvent(key: state.token),
                              );

                          log(state.toString());
                          log('Invitation token saved');
                        }else{
                          log(state.toString());
                        }
                      },
                      child: Container(
                        color: HBMColors.slateGray,
                        alignment: Alignment.center,
                        height: context.height * 0.07,
                        child: HBMTextWidget(
                          data:  'Save To Database'
                               ,
                          color: HBMColors.almond,
                        ),
                      ),
                    ),
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
