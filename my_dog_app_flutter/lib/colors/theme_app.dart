// theme_aplication.dart

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/const/strings.dart';

class ThemeAplication {
  final Size size;
  final BuildContext context;

  ThemeAplication(this.size, this.context);

  Color get textColor {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? kPrimaryColor : kSecondaryColor;
  }

  ThemeData get lightTheme {
    final Color invertedPrimary = kPrimaryColor;

    final Color alternatingText = textColor; // in light -> kSecondaryColor

    return ThemeData.light().copyWith(
      primaryColor: invertedPrimary,
      scaffoldBackgroundColor: invertedPrimary,
      appBarTheme: const AppBarTheme(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      iconTheme: IconThemeData(
        size: size.shortestSide / 20,
        color: Colors.black,
      ),
      textTheme: GoogleFonts.openSansTextTheme(
        TextTheme(
          displaySmall: TextStyle(
            fontFamily: tipeOpenSans,
            fontSize: size.shortestSide / 20,
            color: alternatingText,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            fontFamily: tipeOpenSans,
            color: invertedPrimary,
            fontSize: size.shortestSide / 20,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontFamily: tipeOpenSans,
            fontSize: calcularTamanoDiagonal(
              size.width * 0.05,
              size.height * 0.022,
            ),
            fontWeight: FontWeight.bold,
            color: alternatingText,
          ),
          labelMedium: GoogleFonts.openSans(
            color: alternatingText,
            fontSize: calcularTamanoDiagonal(
              size.width * 0.012,
              size.height * 0.014,
            ),
            fontWeight: FontWeight.w500,
          ),
          // Accent choice: keep labelSmall using primary for emphasis
          labelSmall: GoogleFonts.openSans(
            color: invertedPrimary,
            fontSize: calcularTamanoDiagonal(
              size.width * 0.025,
              size.height * 0.01,
            ),
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            fontFamily: tipeOpenSans,
            fontSize: size.shortestSide / 20,
            color: alternatingText,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontFamily: tipeOpenSans,
            color: colorsWhite,
            fontWeight: FontWeight.w600,
            fontSize: size.shortestSide / 20,
          ),
          titleMedium: TextStyle(
            fontFamily: tipeOpenSans,
            color: alternatingText,
            fontSize: size.shortestSide / 20,
          ),
          bodyLarge: TextStyle(
            fontFamily: tipeOpenSans,
            color: alternatingText,
            fontSize: calcularTamanoDiagonal(
              size.width * 0.019,
              size.height * 0.018,
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color(0xffe8edf0),
        filled: true,
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        prefixIconColor: const Color.fromARGB(255, 0, 0, 0),
        contentPadding: EdgeInsets.symmetric(
          vertical: size.height * 0.018,
          horizontal: 10,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: GoogleFonts.openSans(
          fontSize: size.shortestSide / 20,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.normal,
          color: alternatingText.withOpacity(0.7),
        ),
      ),

      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(kSecondaryColor),
      ),
    );
  }

  ThemeData get darkTheme {
    // Intercambiamos los colores primario y secundario
    final Color invertedPrimary = kSecondaryColor;
    final Color invertedSecondary = kPrimaryColor;
    final Color alternatingText = textColor; // in dark -> kPrimaryColor

    return ThemeData.dark().copyWith(
      primaryColor: invertedPrimary,
      scaffoldBackgroundColor: invertedPrimary,

      iconTheme: IconThemeData(
        size: size.shortestSide / 20,
        color: invertedSecondary,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: kSecondaryColor,
        centerTitle: true,
      ),

      textTheme: GoogleFonts.openSansTextTheme(
        TextTheme(
          displaySmall: TextStyle(
            fontFamily: tipeOpenSans,
            fontSize: size.shortestSide / 20,
            color: alternatingText,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            fontFamily: tipeOpenSans,
            color: invertedPrimary,
            fontSize: size.shortestSide / 20,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontFamily: tipeOpenSans,
            fontSize: calcularTamanoDiagonal(
              size.width * 0.05,
              size.height * 0.022,
            ),
            fontWeight: FontWeight.bold,
            color: alternatingText,
          ),
          labelMedium: GoogleFonts.openSans(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: calcularTamanoDiagonal(
              size.width * 0.012,
              size.height * 0.014,
            ),
          ),
          // Accent choice: keep labelSmall using invertedPrimary for emphasis
          labelSmall: GoogleFonts.openSans(
            color: invertedPrimary,
            fontSize: calcularTamanoDiagonal(
              size.width * 0.025,
              size.height * 0.01,
            ),
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            fontFamily: tipeOpenSans,
            fontSize: size.shortestSide / 20,
            color: alternatingText,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontFamily: tipeOpenSans,

            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: size.shortestSide / 20,
          ),
          titleMedium: TextStyle(
            fontFamily: tipeOpenSans,
            color: alternatingText,
            fontSize: size.shortestSide / 20,
          ),
          bodyLarge: TextStyle(
            fontFamily: tipeOpenSans,
            color: alternatingText,
            fontSize: calcularTamanoDiagonal(
              size.width * 0.019,
              size.height * 0.018,
            ),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color(0xFF23242B),
        filled: true,
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: invertedPrimary),
        ),
        prefixIconColor: invertedSecondary,
        contentPadding: EdgeInsets.symmetric(
          vertical: size.height * 0.018,
          horizontal: 10,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: GoogleFonts.openSans(
          fontSize: size.shortestSide / 20,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.normal,
          color: alternatingText.withOpacity(0.7),
        ),
      ),

      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(kPrimaryColor),
      ),
    );
  }

  double calcularTamanoDiagonal(double ladoA, double ladoB) {
    return sqrt(pow(ladoA, 2) + pow(ladoB, 2));
  }
}
