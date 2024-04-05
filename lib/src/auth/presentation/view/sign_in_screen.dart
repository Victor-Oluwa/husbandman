import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:husbandman/core/common/common_variables.dart';
import 'package:husbandman/core/common/strings/hbm_strings.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/res/media_res.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _FarmerSignUpScreenState();
}

class _FarmerSignUpScreenState extends State<SignInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final sidePadding = context.width * 0.03;
    return Scaffold(
      backgroundColor: HBMColors.almond,
      body: Center(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  width: context.width * 1.0,
                  alignment: Alignment.topCenter,
                  MediaRes.happyFarmer,
                ),
                Padding(
                  padding: EdgeInsets.only(left: sidePadding),
                  child: HBMTextWidget(
                    data: HBMStrings.signIn,
                    fontFamily: HBMFonts.exoBold,
                    fontSize: context.width * 0.12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: sidePadding),
                  child: Row(
                    children: [
                      HBMTextWidget(
                        data: HBMStrings.doNotHaveAnAccount,
                        fontFamily: HBMFonts.quicksandNormal,
                        fontSize: context.width * 0.05,
                      ),
                      SizedBox(width: context.width * 0.02),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.accountTypeScreen,);
                        },
                        child: HBMTextWidget(
                          data: HBMStrings.signUp,
                          fontFamily: HBMFonts.quicksandBold,
                          fontSize: context.width * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.height * 0.01),
                SizedBox(
                  height: context.height * 0.34,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sidePadding),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(height: context.height * 0.03),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: HBMStrings.email,
                              hintStyle: TextStyle(
                                fontFamily: HBMFonts.quicksandNormal,
                              ),
                              enabledBorder: const UnderlineInputBorder(),
                              disabledBorder: const UnderlineInputBorder(),
                              focusedBorder: const UnderlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return HBMStrings.pleaseEnterAnEmailAddress;
                              } else if (!emailValidatorJargon
                                  .hasMatch(value)) {
                                return HBMStrings
                                    .pleaseEnterAValidEmailAddress;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: context.height * 0.03),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: HBMStrings.password,
                              hintStyle: TextStyle(
                                  fontFamily: HBMFonts.quicksandNormal),
                              enabledBorder: const UnderlineInputBorder(),
                              disabledBorder: const UnderlineInputBorder(),
                              focusedBorder: const UnderlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return HBMStrings.thisFieldIsRequired;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: context.height * 0.10),
                Padding(
                  padding: EdgeInsets.only(
                    left: sidePadding,
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(context.width * 0.35, context.height * 0.06),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                      MaterialStateProperty.all(HBMColors.slateGray),
                    ),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: HBMTextWidget(
                              data: HBMStrings
                                  .youNeedToAttendToAllFieldCorrectly,
                            ),
                          ),
                        );

                      } else {
                        context.read<AuthBloc>().add(
                          SignInEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      }
                    },
                    child: HBMTextWidget(
                      data: HBMStrings.signIn,
                      fontFamily: HBMFonts.exo2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
