import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Color primary(BuildContext context) {
  return Theme.of(context).colorScheme.primary;
}

Color background(BuildContext context) {
  return Theme.of(context).colorScheme.background;
}

Color onPrimary(BuildContext context) {
  return Theme.of(context).colorScheme.onPrimary;
}

var themeData = ThemeData(
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.all(25),
      side: const BorderSide(color: Colors.white),
      shape: const RoundedRectangleBorder(),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.white.withOpacity(0.25),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  ),
  textTheme: TextTheme(
    headline4: GoogleFonts.roboto(
      textStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
    button: GoogleFonts.roboto(
      textStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
    bodyText1: GoogleFonts.roboto(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
    bodyText2: GoogleFonts.roboto(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
    headline5: GoogleFonts.roboto(
      textStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
    headline6: GoogleFonts.roboto(
      textStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
    subtitle1: GoogleFonts.roboto(
      textStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    toolbarHeight: 70,
    color: Colors.transparent,
  ),
  scaffoldBackgroundColor: Colors.grey[900]!,
  colorScheme: ColorScheme.light(
    primary: Colors.white,
    secondary: Colors.grey,
    background: Colors.grey[900]!,
    onPrimary: Colors.white,
  ),
);
