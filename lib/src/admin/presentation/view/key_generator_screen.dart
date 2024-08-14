import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/injection/admin/admin_injection.dart';
import 'package:husbandman/core/services/injection/auth/auth_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/admin/presentation/bloc/admin_bloc.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';

class KeyGeneratorScreen extends ConsumerWidget {
  const KeyGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var generatedKey = '000000000000';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ref.read(authBlocProvider),
        ),
        BlocProvider(create: (context) => ref.read(adminBlocProvider)),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: HBMColors.coolGrey,
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
                BlocListener<AdminBloc, AdminState>(
                  listener: (context, state) {
                    if (state is FetchedInvitationToken) {
                      log('Invitation toke fetched');

                      final tokensFromDatabase = state.tokens
                          .map((key) => int.parse(key.value))
                          .toList();

                      context.read<AdminBloc>().add(
                            GenerateUniqueInvitationTokenEvent(
                              generatedToken: tokensFromDatabase,
                            ),
                          );
                    }

                    if (state is InvitationTokenGenerated) {
                      context.read<AdminBloc>().add(
                            SaveInvitationTokenEvent(key: state.token),
                          );
                      generatedKey = state.token;
                    }

                    if (state is InvitationTokenSaved) {
                      log('Token saved}');
                    }
                    if (state is AdminError) {
                      log('Invitation Key generator error: ${state.message}');
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
                        padding: EdgeInsets.only(top: context.height * 0.04),
                        child: GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(const SignOutEvent());
                          },
                          child: Column(
                            children: [
                              HBMTextWidget(
                                data: 'Generate Seller Key',
                                fontSize: context.width * 0.09,
                              ),
                             const Divider(),

                            ],
                          ),
                        ),
                      ),
                      HBMTextWidget(
                        letterSpacing: context.width * 0.02,
                        data: generatedKey,
                        fontFamily: HBMFonts.quicksandNormal,
                        fontSize: context.width * 0.08,
                        color: state is InvitationTokenSaved
                            ? HBMColors.mediumGrey
                            : Colors.deepOrange,
                      ),

                      GestureDetector(
                        onTap: () {
                          context.read<AdminBloc>().add(
                                const FetchAllInvitationTokenEvent(),
                              );
                        },
                        child: Container(
                          color: HBMColors.charcoalGrey,
                          alignment: Alignment.center,
                          height: context.height * 0.07,
                          child: HBMTextWidget(
                            data: 'Generate Token',
                            color: HBMColors.coolGrey,
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
      ),
    );
  }
}
