import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ToponymyTheme {
  //Color System
  static Color inkLight = const Color.fromRGBO(108, 112, 114, 1);
  static Color inkDarkest = const Color.fromRGBO(9, 10, 10, 1);
  static Color skyWhite = const Color.fromRGBO(255, 255, 255, 1);
  static Color skyLight = const Color.fromRGBO(227, 229, 229, 1);
  static Color skyDark = const Color.fromRGBO(151, 156, 158, 1);
  static Color brandBase = const Color.fromRGBO(107, 78, 255, 1);

  static String fontFamily = "inter";
  static const double iconSize = 18;

  static TextStyle title1(String? level) {
    return GoogleFonts.inter(
        fontSize: 48,
        fontWeight: (level == 'bold')
            ? FontWeight.w700
            : (level == 'normal')
                ? FontWeight.w500
                : FontWeight.w400);
  }

  static TextStyle title2(String? level) {
    return GoogleFonts.inter(
        fontSize: 36,
        fontWeight: (level == 'bold')
            ? FontWeight.w700
            : (level == 'normal')
                ? FontWeight.w500
                : FontWeight.w400);
  }

  static TextStyle title3(String? level) {
    return GoogleFonts.inter(
        fontSize: 24,
        fontWeight: (level == 'bold')
            ? FontWeight.w700
            : (level == 'normal')
                ? FontWeight.w500
                : FontWeight.w400);
  }

  static TextStyle large(String? level) {
    return GoogleFonts.inter(
        fontSize: 18,
        fontWeight: (level == 'bold')
            ? FontWeight.w700
            : (level == 'normal')
                ? FontWeight.w500
                : FontWeight.w400);
  }

  static TextStyle regular(String? level) {
    return GoogleFonts.inter(
        fontSize: 16,
        fontWeight: (level == 'bold')
            ? FontWeight.w700
            : (level == 'normal')
                ? FontWeight.w500
                : FontWeight.w400);
  }

  static TextStyle small(String? level) {
    return GoogleFonts.inter(
        fontSize: 14,
        fontWeight: (level == 'bold')
            ? FontWeight.w700
            : (level == 'normal')
                ? FontWeight.w500
                : FontWeight.w400);
  }

  static TextStyle tiny(String? level) {
    return GoogleFonts.inter(
        fontSize: 12,
        fontWeight: (level == 'bold')
            ? FontWeight.w700
            : (level == 'normal')
                ? FontWeight.w500
                : FontWeight.w400);
  }

  static TextTheme darkTextTheme() {
    return TextTheme(
      bodyText1: regular('normal').copyWith(color: skyWhite),
      bodyText2: regular('normal').copyWith(color: inkLight),
      headline1: title1('bold').copyWith(color: skyWhite),
      headline2: title2('bold').copyWith(color: skyWhite),
      headline3: title3('bold').copyWith(color: skyWhite),
      headline4: small("bold").copyWith(color: skyWhite),
    );
  }

  static TextTheme lightTextTheme() {
    return TextTheme(
      bodyText1: regular('normal').copyWith(color: inkDarkest),
      bodyText2: regular('normal').copyWith(color: skyDark),
      subtitle2: tiny('normal').copyWith(color: inkDarkest),
      headline1: title1('bold').copyWith(color: inkDarkest),
      headline2: title2('bold').copyWith(color: inkDarkest),
      headline3: title3('bold').copyWith(color: inkDarkest),
      headline4: small("bold").copyWith(color: inkDarkest),
    );
  }

  static ThemeData light() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        color: Colors.transparent,
        elevation: 0,
        foregroundColor: inkDarkest,
      ),
      scaffoldBackgroundColor: skyWhite,
      textTheme: lightTextTheme(),
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: brandBase,
            secondary: brandBase,
            brightness: Brightness.light,
            outline: skyDark,
          ),
      //navigationBarTheme: ,
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: skyWhite),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: ToponymyTheme.skyLight,
            )),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: ToponymyTheme.skyLight,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ToponymyTheme.skyWhite,
          ),
      iconTheme: IconThemeData(color: inkDarkest, size: iconSize),
    );
  }
}
