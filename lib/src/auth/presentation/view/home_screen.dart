import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/user_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignedOut) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.signInScreen,
              (route) => false,
            );
          }else{
            log(state.toString());
          }
        },
        child: Center(
          child: GestureDetector(
            onTap: () {
              context.read<AuthBloc>().add(const SignOutEvent());
            },
            child: HBMTextWidget(data: ref.read(userProvider).type),
          ),
        ),
      ),
    );
  }
}
