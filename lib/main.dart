import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/injection_container.dart';
import 'package:husbandman/core/services/routes.dart';

Future<void> main() async {
  //This WidgetsFlutterBinding is here because '
  // ' there is an async operation in the block
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String title = 'Husbandman';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: HBMColors.almond,
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
                secondary: HBMColors.slateGray,
                primary: HBMColors.almond,
              ),
        ),
        darkTheme: ThemeData(
          colorScheme: ThemeData.dark().colorScheme.copyWith(
                secondary: HBMColors.almond,
                primary: HBMColors.slateGray,
              ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        themeMode: ThemeMode.light,
        onGenerateRoute: generateRoute,
      );
}
