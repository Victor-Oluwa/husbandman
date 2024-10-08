
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/strings/hbm_strings.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/res/media_res.dart';
import 'package:husbandman/core/services/injection/auth/auth_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/src/auth/domain/entity/user/user_entity.dart';
import 'package:husbandman/src/auth/presentation/bloc/auth_bloc.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _FarmerSignUpScreenState();
}

class _FarmerSignUpScreenState extends ConsumerState<SignInScreen> {
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
    return BlocProvider(
      create: (context) => ref.read(authBlocProvider),
      child: Scaffold(
        backgroundColor: HBMColors.coolGrey,
        body: Center(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is SignedIn) {
                    context
                        .read<AuthBloc>()
                        .add(SetUserEvent(user: state.user));
                  }

                  if (state is UserSet) {
                    final user = UserEntity.fromJson(state.user);
                    context.read<AuthBloc>().add(
                      CacheUserTokenEvent(token: user.token),
                    );
                  }

                  if (state is UserTokenCached) {
                    final user = ref
                        .read(userProvider).userType;
                    user == HBMStrings.admin
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
                  }

                  if (state is AuthError) {
                    HBMSnackBar.show(context: context, content: state.message);
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _emailController.text = 'fidel1@gmail.com';
                            _passwordController.text = '123456789';
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
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.accountTypeScreen,
                                );
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
                          padding: EdgeInsets.symmetric(
                              horizontal: sidePadding,),
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
                                        fontFamily: HBMFonts.quicksandNormal,),
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
                          style: TextButton.styleFrom(
                            fixedSize: Size(context.width * 0.35, context.height * 0.06),
                            foregroundColor: Colors.white,
                            backgroundColor: HBMColors.charcoalGrey,
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
                              return;
                            }
                            context.read<AuthBloc>().add(
                              SignInEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          },
                          child: HBMTextWidget(
                              data: HBMStrings.signIn,
                              fontFamily: HBMFonts.exo2,
                              fontSize: context.width * 0.04,
                              color: HBMColors.grey,),
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
