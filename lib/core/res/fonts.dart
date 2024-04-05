import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HBMFonts {
  static String quicksandNormal =
      GoogleFonts.quicksand().fontFamily ?? 'Exo2.ttf';

  static String quicksandBold =
      GoogleFonts.quicksand(fontWeight: FontWeight.bold).fontFamily ?? 'Exo2.ttf';

  static String quicksandItalics =
      GoogleFonts.quicksand(fontStyle: FontStyle.italic).fontFamily ??
          'Exo2.ttf';

  static String exo2 = GoogleFonts.exo2(
               fontWeight: FontWeight.normal,)
          .fontFamily ??
      '';

  static String exoBold =
      GoogleFonts.exo2(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold)
              .fontFamily ??
          'Exo2.ttf';

  static String exoLight =
      GoogleFonts.exo2(fontStyle: FontStyle.normal, fontWeight: FontWeight.w300)
              .fontFamily ??
          'Exo2.ttf';
}

// How can I access quicksandNormal with Fonts.quicksandNormal?
