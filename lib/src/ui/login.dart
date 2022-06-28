import 'dart:developer';
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
              'assets/images/Logo.svg',
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
                width: width(context) * 0.6,
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
                          height: 25,
                          width: 25,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primary(context),
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/facebook.svg',
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
                          height: 25,
                          width: 25,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primary(context),
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/google.svg',
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
                          height: 25,
                          width: 25,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primary(context),
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/twitter.svg',
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
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
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
                autofillHints: const [AutofillHints.password],
                controller: _password,
                decoration: InputDecoration(hintText: AppLocalizations.of(context)!.password),
                obscureText: true,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => {
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
                    ]),
                  },
                  child: Text(
                    AppLocalizations.of(context)!.forgot,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: width(context),
                child: OutlinedButton(
                  onPressed: () {
                    if (_form.currentState!.validate()) {
                      log('Proceeded');
                      setState(() {
                        _email.clear();
                        _password.clear();
                      });
                      Navigator.pushNamedAndRemoveUntil(context, 'Dashboard', (route) => false);
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.loginButton),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'Sign Up'),
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
}
