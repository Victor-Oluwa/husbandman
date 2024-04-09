import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/common/strings/hbm_strings.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/res/media_res.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/core/utils/core_utils.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';

class BuyerSignUpScreen extends StatefulWidget {
  const BuyerSignUpScreen({super.key});

  @override
  State<BuyerSignUpScreen> createState() => _FarmerSignUpScreenState();
}

class _FarmerSignUpScreenState extends State<BuyerSignUpScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _addressController;
  late ScrollController _formScrollContainer;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _addressController = TextEditingController();
    _formScrollContainer = ScrollController();
    super.initState();
  }

   int num = 0;

  bool policyBoxChecked = false;
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
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is BuyerSignedUp) {
                  final user = state.user as UserModel;

                  context.read<AuthBloc>().add(
                        SetUserEvent(
                          user: user.toMap(),
                        ),
                      );
                  return;
                } else if (state is AuthError) {
                  CoreUtils.showSnackBar(
                    message: state.message,
                    context: context,
                  );
                  log('Sign Up Error: ${state.message}');
                  return;
                }

                if (state is UserSet) {
                  context.read<AuthBloc>().add(
                        CacheUserTokenEvent(token: state.user.token),
                      );
                  return;
                } else if (state is AuthError) {
                  CoreUtils.showSnackBar(
                    message: state.message,
                    context: context,
                  );
                  log('Set User Error: ${state.message}');
                  return;
                }

                if(state is UserTokenCached){
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteNames.homePage,
                        (route) => false,
                  );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // context.read<AuthBloc>().add(const ValidateUserEvent(token: 'asdfghjk'));
                      // Navigator.pushNamed(context, RouteNames.generateToken);
                      setState(() {
                        num++;
                        _nameController.text = 'Fidel';
                        _emailController.text = 'fidel$num@gmail.com';
                        _passwordController.text = '123456789';
                        _addressController.text = 'qwertyuiop';
                      });
                    },
                    child: SvgPicture.asset(
                      width: context.width * 1.0,
                      alignment: Alignment.topCenter,
                      MediaRes.happyFarmer,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: sidePadding),
                    child: HBMTextWidget(
                      data: HBMStrings.signUp,
                      fontFamily: HBMFonts.exoBold,
                      fontSize: context.width * 0.12,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: sidePadding),
                    child: Row(
                      children: [
                        HBMTextWidget(
                          data: HBMStrings.alreadyHaveAnAccount,
                          fontFamily: HBMFonts.quicksandNormal,
                          fontSize: context.width * 0.05,
                        ),
                        SizedBox(width: context.width * 0.02),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.signInScreen,
                            );
                          },
                          child: HBMTextWidget(
                            data: HBMStrings.signIn,
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
                    child: SingleChildScrollView(
                      controller: _formScrollContainer,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: sidePadding),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: HBMStrings.name,
                                  hintStyle: TextStyle(
                                    fontFamily: HBMFonts.quicksandNormal,
                                  ),
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
                                    fontFamily: HBMFonts.quicksandNormal,
                                  ),
                                  enabledBorder: const UnderlineInputBorder(),
                                  disabledBorder: const UnderlineInputBorder(),
                                  focusedBorder: const UnderlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return HBMStrings.thisFieldIsRequired;
                                  }

                                  if (value.length < 7) {
                                    return HBMStrings.passwordIsLessThanSeven;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: context.height * 0.03),
                              TextFormField(
                                controller: _addressController,
                                decoration: InputDecoration(
                                  hintText: HBMStrings.address,
                                  hintStyle: TextStyle(
                                    fontFamily: HBMFonts.quicksandNormal,
                                  ),
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
                              SizedBox(height: context.height * 0.03),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.height * 0.03),
                  Row(
                    children: [
                      Checkbox(
                        value: policyBoxChecked,
                        activeColor: HBMColors.slateGray,
                        checkColor: HBMColors.white,
                        onChanged: (value) {
                          setState(() {
                            policyBoxChecked = !policyBoxChecked;
                          });
                          log(policyBoxChecked.toString());
                        },
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: HBMStrings.iAgreeWith,
                                style: TextStyle(
                                  fontFamily: HBMFonts.quicksandNormal,
                                  color: HBMColors.black,
                                ),
                              ),
                              TextSpan(
                                text: HBMStrings.privacyPolicy,
                                style: TextStyle(
                                  fontFamily: HBMFonts.quicksandBold,
                                  color: HBMColors.black,
                                ),
                              ),
                              TextSpan(
                                text: HBMStrings.and,
                                style: TextStyle(
                                  fontFamily: HBMFonts.quicksandNormal,
                                  color: HBMColors.black,
                                ),
                              ),
                              TextSpan(
                                text: HBMStrings.termsAndCondition,
                                style: TextStyle(
                                  fontFamily: HBMFonts.quicksandBold,
                                  color: HBMColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.height * 0.02),
                  Padding(
                    padding: EdgeInsets.only(
                      left: sidePadding,
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(context.width * 0.35, context.height * 0.06),
                        ),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
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

                          _formScrollContainer.animateTo(
                            500,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeIn,
                          );
                        }

                        if (!policyBoxChecked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: HBMTextWidget(
                                data: HBMStrings
                                    .kindlyTickThePrivacyPolicyBoxBeforeProceeding,
                              ),
                            ),
                          );
                        }

                        context.read<AuthBloc>().add(
                              BuyerSignUpEvent(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                address: _addressController.text,
                                type: HBMStrings.buyer,
                              ),
                            );
                      },
                      child: HBMTextWidget(
                        data: HBMStrings.signUp,
                        fontFamily: HBMFonts.exo2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
