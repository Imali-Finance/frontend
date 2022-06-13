import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:imali/src/methods.dart';
import '../res/styles.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _email = TextEditingController(), _password = TextEditingController(), _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Align(
          alignment: Alignment.centerRight,
          child: Hero(
            tag: 'logo',
            child: SvgPicture.asset(
              'images/Logo.svg',
              height: 30,
            ),
          ),
        ),
      ),
      body: Form(
        key: _form,
        child: Container(
          width: width(context),
          height: height(context),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.login,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              Text(
                AppLocalizations.of(context)!.loginSubtitle,
              ),
              const Spacer(),
              SizedBox(
                width: width(context) * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => {
                          showSnackbar(context, 'This feature is not currently available.'),
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primary(context),
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'images/facebook.svg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => {
                          showSnackbar(context, 'This feature is not currently available.'),
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primary(context),
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'images/google.svg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => {
                          showSnackbar(context, 'This feature is not currently available.'),
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primary(context),
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'images/twitter.svg',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              TextFormField(
                controller: _email,
                validator: (val) {
                  if (val!.isEmpty) return 'Please enter your email address';
                  return null;
                },
                decoration: InputDecoration(hintText: AppLocalizations.of(context)!.email),
              ),
              const Spacer(),
              TextFormField(
                validator: (val) {
                  if (val!.isEmpty) return 'Please enter your password';
                  return null;
                },
                controller: _password,
                decoration: InputDecoration(hintText: AppLocalizations.of(context)!.password),
                obscureText: true,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => {},
                  child: Text(
                    AppLocalizations.of(context)!.forgot,
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 4,
                child: Center(
                  child: SizedBox(
                    width: width(context),
                    child: OutlinedButton(
                      onPressed: () {
                        if (_form.currentState!.validate()) {
                          log('Proceeded');
                          log(_email.text);
                          log(_password.text);
                          setState(() {
                            _email.clear();
                            _password.clear();
                          });
                          showCustomDialog(context, AppLocalizations.of(context)!.unverifiedEmailTitle,
                              AppLocalizations.of(context)!.unverifiedEmailBody, [
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.resendVerification),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.ok),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ]);
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.loginButton),
                    ),
                  ),
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)!.noAccount,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showCustomDialog(BuildContext context, String title, String content, List<Widget>? actions) {
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
          content: Text(
            content,
            textAlign: TextAlign.justify,
          ),
          actions: actions,
        ),
      ),
    );
  }
}
