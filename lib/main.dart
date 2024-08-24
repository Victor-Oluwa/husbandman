import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:husbandman/core/common/app/public_methods/loading/loading_controller.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/res/media_res.dart';
import 'package:husbandman/core/services/shared_preference.dart';
import 'package:husbandman/src/order/presentation/view/seller_order_view.dart';
import 'package:lottie/lottie.dart';

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
    return MaterialApp(
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
      // onGenerateRoute: generateRoute,
      home: const SellerOrderView(),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            ValueListenableBuilder<bool>(
              valueListenable: LoadingIndicatorController.instance.isLoading,
              builder: (context, isLoading, child) {
                log(isLoading.toString());
                if (isLoading) {
                  return Stack(
                    children: [
                      Align(
                        child: SizedBox(
                          // height: context.height*0.15,
                          width: context.width*0.30,
                          child: Center(
                            child: Lottie.asset(MediaRes.orbit),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
