import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HBMFonts {
  static String quicksandNormal =
      GoogleFonts.quicksand().fontFamily ?? '';

  static String quicksandBold =
      GoogleFonts.quicksand().fontFamily ?? '';

  static String quicksandItalics =
      GoogleFonts.quicksand(fontStyle: FontStyle.italic).fontFamily ?? '';
}

// How can I access quicksandNormal with Fonts.quicksandNormal?
