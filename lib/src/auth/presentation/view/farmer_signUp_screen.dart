import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:husbandman/core/common/strings/hbm_strings.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/res/media_res.dart';
import 'package:husbandman/core/services/injection/auth/auth_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/core/utils/core_utils.dart';
import 'package:husbandman/src/auth/domain/entity/user/seller/seller_entity.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';

class FarmerSignUpScreen extends ConsumerStatefulWidget {
  const FarmerSignUpScreen({super.key});

  @override
  ConsumerState<FarmerSignUpScreen> createState() => _FarmerSignUpScreenState();
}

class _FarmerSignUpScreenState extends ConsumerState<FarmerSignUpScreen> {
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
    return BlocProvider(
      create: (context) => ref.read(authBlocProvider),
      child: Scaffold(
        backgroundColor: HBMColors.coolGrey,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is FarmerSignedUp) {
              final user = state.user;
              context
                  .read<AuthBloc>()
                  .add(SetUserEvent(user: user.toJson()));
            }

            if (state is UserSet) {
              final user = SellerEntity.fromJson(state.user);
              context.read<AuthBloc>().add(
                CacheUserTokenEvent(
                  token: user.token,
                ),
              );
            }

            if (state is UserTokenCached) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.homePage,
                    (route) => false,
              );
            }

            if (state is AuthError) {
              CoreUtils.showSnackBar(
                message: state.message,
                context: context,
              );
              log('Farmer signUp error: ${state.message}');
            }
          },
          builder: (context, state) {
            return Center(
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _nameController.text = 'Gabriel';
                            _emailController.text = 'gabriel@gmail.com';
                            _passwordController.text = '1234567';
                            _addressController.text = 'address not set';
                            _invitationKeyController.text = 'inv-key';
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
                            padding: EdgeInsets.symmetric(
                                horizontal: sidePadding),
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
                                        return HBMStrings
                                            .pleaseEnterAnEmailAddress;
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
                                        return HBMStrings
                                            .passwordIsLessThanSeven;
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
                                  TextFormField(
                                    controller: _invitationKeyController,
                                    decoration: InputDecoration(
                                      hintText: HBMStrings.key,
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
                            activeColor: HBMColors.charcoalGrey,
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
                            minimumSize: WidgetStateProperty.all(
                              Size(context.width * 0.35,
                                  context.height * 0.06),
                            ),
                            foregroundColor: WidgetStateProperty.all(
                                Colors.white),
                            backgroundColor:
                            WidgetStateProperty.all(HBMColors.charcoalGrey),
                          ),
                          onPressed: () {
                            if (!formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: HBMTextWidget(
                                    color: HBMColors.grey,
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
                              return;
                            }

                            if (!policyBoxChecked) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: HBMTextWidget(
                                    color: HBMColors.grey,
                                    data: HBMStrings
                                        .kindlyTickThePrivacyPolicyBoxBeforeProceeding,
                                  ),
                                ),
                              );
                              return;
                            }

                            final seller = SellerEntity(
                              userType: 'Seller',
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              dateJoined: DateTime.now().toIso8601String(),
                            );
log('passed key: $_invitationKeyController');
                            context.read<AuthBloc>().add(
                              FarmerSignUpEvent(
                                seller: seller,
                                invitationKey: _invitationKeyController.text,
                              ),
                            );
                          },
                          child: HBMTextWidget(
                            color: HBMColors.grey,
                            fontSize: context.width * 0.04,
                            data: HBMStrings.signUp,
                            fontFamily: HBMFonts.exo2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
