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

class FarmerSignUpScreen extends StatefulWidget {
  const FarmerSignUpScreen({super.key});

  @override
  State<FarmerSignUpScreen> createState() => _FarmerSignUpScreenState();
}

class _FarmerSignUpScreenState extends State<FarmerSignUpScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _invitationKeyController;
  late TextEditingController _addressController;
  late ScrollController _formScrollContainer;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _invitationKeyController = TextEditingController();
    _addressController = TextEditingController();
    _formScrollContainer = ScrollController();
    super.initState();
  }

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
                          Navigator.pushNamed(context, RouteNames.signInScreen);
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
                                    fontFamily: HBMFonts.quicksandNormal),
                                enabledBorder: const UnderlineInputBorder(),
                                disabledBorder: const UnderlineInputBorder(),
                                focusedBorder: const UnderlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return HBMStrings.thisFieldIsRequired;
                                }

                                if(value.length <7){
                                  log('message');
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
                            SizedBox(height: context.height * 0.03),
                            TextFormField(
                              controller: _invitationKeyController,
                              decoration: InputDecoration(
                                hintText: HBMStrings.key,
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

                        _formScrollContainer.animateTo(
                          500,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn,
                        );
                      } else if (!policyBoxChecked) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: HBMTextWidget(
                              data: HBMStrings
                                  .kindlyTickThePrivacyPolicyBoxBeforeProceeding,
                            ),
                          ),
                        );
                      } else {
                        context.read<AuthBloc>().add(
                              FarmerSignUpEvent(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                address: '',
                                type: HBMStrings.admin,
                                invitationKey: _invitationKeyController.text,
                              ),
                            );
                      }
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
    );
  }
}
