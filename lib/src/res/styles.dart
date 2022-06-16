import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
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
      padding: const EdgeInsets.all(20),
      side: const BorderSide(color: Colors.white),
      shape: const RoundedRectangleBorder(),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    suffixIconColor: Colors.white,
    iconColor: Colors.white,
    hintStyle: TextStyle(
      color: Colors.white.withOpacity(0.25),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showUnselectedLabels: false,
    backgroundColor: Colors.grey[900]!,
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
    subtitle2: GoogleFonts.roboto(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    ),
  ),
  canvasColor: Colors.grey[900],
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

Future<void> showCustomDialog(BuildContext context, String title, String content, List<Widget>? actions,
    {List<Widget>? otherActions}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 4,
        sigmaY: 4,
      ),
      child: AlertDialog(
        actionsPadding: const EdgeInsets.all(20),
        contentTextStyle: Theme.of(context).textTheme.bodyText2,
        backgroundColor: background(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: primary(context),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: otherActions == null
            ? Text(
                content,
                textAlign: TextAlign.justify,
              )
            : Wrap(children: otherActions),
        actions: actions,
      ),
    ),
  );
}
