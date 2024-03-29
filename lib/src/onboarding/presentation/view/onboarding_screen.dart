import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/src/onboarding/domain/entities/page__content.dart';
import 'package:husbandman/src/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:husbandman/src/onboarding/presentation/view/loading_view.dart';
import 'package:husbandman/src/onboarding/presentation/widgets/onboarding_body.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const routeName = '/';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
    context.read<OnboardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HBMColors.almond,
      body: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingStatus && !state.isFirstTimer) {
            Navigator.pushReplacementNamed(context, '/auth');
          } else if (state is UserCached) {
            // TODO(Navigate): Push to AccountType screen
          }
        },
        builder: (context, state) {
          if (state is CheckingIfUserIsFirstTimer ||
              state is CachingFirstTimer) {
            log('Loading view');
            return const LoadingView();
          }
          log(state.toString());
          return Stack(
            children: [
              PageView(
                controller: _controller,
                children: const [
                  OnboardingBody(
                    pageContent: PageContent.first(),
                  ),
                  OnboardingBody(
                    pageContent: PageContent.second(),
                  ),
                  OnboardingBody(
                    pageContent: PageContent.third(),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: context.height * .07),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    onDotClicked: (index) => _controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    ),
                    effect: WormEffect(
                      activeDotColor: HBMColors.slateGray,
                      dotHeight: context.height * 0.02,
                    ),
                  ),
                ),
              ),
            ],
          );

        },
      ),
    );
  }









// TODO(Remember): Don't forget to come back to this
//   ResultFuture<String> updateUser({
//     required dynamic data,
//     required UpdateUserAction whatToUpdate,
//   }) async {
//     return dartz.Left(ServerFailure(message: '', statusCode: 500));
//   }

  //groupIds:List<String>.from((map['groupIds'] as List<dynamic>));
  //groupIds:(map['groupIds'] as List<dynamic>).cast<String>();

  // final map = jsonDecode(fixtures('user.json'))as DataMap;
}

// TODO(Remember): Don't forget to come back to this
//Location: Core / enums / updateUser
//enum UpdateUserAction { name, email, bio, profilePic }
