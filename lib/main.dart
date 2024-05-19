// import 'package:cloudinary_url_gen/cloudinary.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/res/media_res.dart';
import 'package:husbandman/core/services/injection/admin/admin_injection.dart';
import 'package:husbandman/core/services/injection/auth/auth_injection.dart';
import 'package:husbandman/core/services/injection/onboarding/onboarding_injection.dart';
import 'package:husbandman/core/services/injection/product_manager/product_manager_injection.dart';
import 'package:husbandman/core/services/routes.dart';
import 'package:husbandman/core/services/shared_preference.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:lottie/lottie.dart';

import 'core/common/app/public_methods/loading/loading_controller.dart';

// import 'package:cloudinary_flutter/cloudinary_context.dart';
// import 'package:cloudinary_flutter/cloudinary_object.dart';
// import 'package:cloudinary_flutter/image/cld_image.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.init();
  runApp(ProviderScope(child: MyApp(LoadingIndicatorController.instance)));
}

class MyApp extends ConsumerWidget {
  const MyApp(this.loadingIndicatorController, {super.key});
  final LoadingIndicatorController loadingIndicatorController;
  static const String title = 'Husbandman';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ref.read(onboardingCubitProvider)),
        BlocProvider(create: (context) => ref.read(authBlocProvider)),
        BlocProvider(create: (context) => ref.read(adminBlocProvider)),
        BlocProvider(create: (context) => ref.read(productManagerBlocProvider)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: HBMColors.coolGrey,
          textTheme: TextTheme(
            displayLarge: TextStyle(
              fontSize: context.width * 0.10,
              fontFamily: HBMFonts.quicksandBold,
              fontWeight: FontWeight.bold,
            ),
            titleLarge: GoogleFonts.exo2(
              fontSize: context.width * 0.07,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: GoogleFonts.quicksand(
              fontSize: context.width * 0.04,
            ),
            bodySmall: GoogleFonts.quicksand(
              fontSize: context.width * 0.04,
            ),
            displayMedium: GoogleFonts.exo2(
              fontSize: context.width * 0.08,
              fontWeight: FontWeight.bold,
            ),
          ),
          colorScheme: ThemeData.light().colorScheme.copyWith(
                secondary: HBMColors.charcoalGrey,
                primary: HBMColors.coolGrey,
              ),
        ),
        darkTheme: ThemeData(
          colorScheme: ThemeData.dark().colorScheme.copyWith(
                secondary: HBMColors.coolGrey,
                primary: HBMColors.charcoalGrey,
              ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        themeMode: ThemeMode.light,
        onGenerateRoute: generateRoute,
        builder: (context, child) {
          return Stack(
            children: [
              child!,
              ValueListenableBuilder<bool>(
                valueListenable: LoadingIndicatorController.instance.isLoading,
                builder: (context, isLoading, child) {
                  log(isLoading.toString());
                  if (isLoading) {
                    return SizedBox(
                      // color: Colors.transparent,
                      child: Center(
                        child: Lottie.asset(MediaRes.theBossHand),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
