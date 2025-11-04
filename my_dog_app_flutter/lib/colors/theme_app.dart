import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_dog_app_flutter/colors/colors.dart';
import 'package:my_dog_app_flutter/const/strings.dart';

class ThemeAplication {
  final Size size;
  final BuildContext context;

  ThemeAplication(this.size, this.context);

  ThemeData get lightTheme => ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kPrimaryColor,

    iconTheme: IconThemeData(size: size.shortestSide / 20, color: Colors.black),
    textTheme: GoogleFonts.openSansTextTheme(
      TextTheme(
        displaySmall: TextStyle(
          fontFamily: tipeOpenSans,

          fontSize: size.shortestSide / 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontFamily: tipeOpenSans,
          color: kPrimaryColor,
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
          color: Colors.black,
        ),
        labelMedium: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: calcularTamanoDiagonal(
            size.width * 0.012,
            size.height * 0.014,
          ),
          fontWeight: FontWeight.w500,
        ),
        labelSmall: GoogleFonts.poppins(
          color: kPrimaryColor,
          fontSize: calcularTamanoDiagonal(
            size.width * 0.025,
            size.height * 0.01,
          ),
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          fontFamily: tipeOpenSans,
          fontSize: size.shortestSide / 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          fontFamily: tipeOpenSans,
          color: Colors.black,
          fontSize: size.shortestSide / 20,
        ),
        titleMedium: TextStyle(
          fontFamily: tipeOpenSans,
          color: Colors.black,
          fontSize: size.shortestSide / 20,
        ),
        bodyLarge: TextStyle(
          fontFamily: tipeOpenSans,
          color: Colors.black,
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
      hintStyle: GoogleFonts.poppins(
        fontSize: size.shortestSide / 20,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.normal,
        color: const Color.fromRGBO(0, 0, 0, 0.612),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: kSecondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 10.0,
        minimumSize: const Size(300, 45),
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: size.shortestSide / 20,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
      ),
    ),
  );

  ThemeData get darkTheme => ThemeData.dark().copyWith(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: const Color(0xFF181A20),
    iconTheme: IconThemeData(size: size.shortestSide / 20, color: Colors.white),
    textTheme: GoogleFonts.openSansTextTheme(
      TextTheme(
        displaySmall: TextStyle(
          fontFamily: tipeOpenSans,
          fontSize: size.shortestSide / 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontFamily: tipeOpenSans,
          color: kPrimaryColor,
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
          color: Colors.white,
        ),
        labelMedium: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: calcularTamanoDiagonal(
            size.width * 0.012,
            size.height * 0.014,
          ),
          fontWeight: FontWeight.w500,
        ),
        labelSmall: GoogleFonts.poppins(
          color: kPrimaryColor,
          fontSize: calcularTamanoDiagonal(
            size.width * 0.025,
            size.height * 0.01,
          ),
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          fontFamily: tipeOpenSans,
          fontSize: size.shortestSide / 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          fontFamily: tipeOpenSans,
          color: Colors.white,
          fontSize: size.shortestSide / 20,
        ),
        titleMedium: TextStyle(
          fontFamily: tipeOpenSans,
          color: Colors.white,
          fontSize: size.shortestSide / 20,
        ),
        bodyLarge: TextStyle(
          fontFamily: tipeOpenSans,
          color: Colors.white,
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
        borderSide: const BorderSide(color: kPrimaryColor),
      ),
      prefixIconColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(
        vertical: size.height * 0.018,
        horizontal: 10,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintStyle: GoogleFonts.poppins(
        fontSize: size.shortestSide / 20,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.normal,
        color: Colors.white70,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: kSecondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 10.0,
        minimumSize: const Size(300, 45),
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: size.shortestSide / 20,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
    ),
  );

  double calcularTamanoDiagonal(double ladoA, double ladoB) {
    return sqrt(pow(ladoA, 2) + pow(ladoB, 2));
  }
}
