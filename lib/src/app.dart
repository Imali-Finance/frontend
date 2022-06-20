import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:imali/src/ui/deposit.dart';
import 'package:imali/src/ui/detailed_portfolio.dart';
import 'package:imali/src/ui/home.dart';
import 'package:imali/src/ui/login.dart';
import 'package:imali/src/ui/withdraw.dart';
import 'res/styles.dart';
import 'settings/settings_controller.dart';
import 'ui/dashboard.dart';
import 'ui/help.dart';
import 'ui/profile.dart';
import 'ui/signup.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          theme: themeData,
          debugShowCheckedModeBanner: false,
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
          initialRoute: 'Dashboard',
          home: const Home(),
          routes: {
            'Home': (context) => const Home(),
            'Log In': (context) => const LogIn(),
            'Sign Up': (context) => const SignUp(),
            'Dashboard': (context) => const Dashboard(),
            'Deposit': (context) => const Deposit(),
            'Withdraw': (context) => const Withdraw(),
            'Profile': (context) => const Profile(),
            'Help': (context) =>  const Help(),
            'Detailed Portfolio': (context) => const DetailedPortfolio(),
          },
        );
      },
    );
  }
}
