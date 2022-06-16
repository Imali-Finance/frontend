import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:imali/src/methods.dart';
import '../res/styles.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _name = TextEditingController(),
      _username = TextEditingController(),
      _phone = TextEditingController(),
      _email = TextEditingController(),
      _password = TextEditingController(),
      _confirmPass = TextEditingController(),
      _dob = TextEditingController(),
      _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                AppLocalizations.of(context)!.register,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              Text(
                AppLocalizations.of(context)!.registerSubtitle,
              ),
              const Spacer(),
              Expanded(
                flex: 20,
                child: SizedBox(
                  width: width(context),
                  height: height(context) * 0.5,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      TextFormField(
                        controller: _name,
                        validator: (val) {
                          if (val!.isEmpty) return 'Please enter your name';
                          if (val.length <= 3) return 'Please enter a valid name';
                          return null;
                        },
                        autofillHints: const [AutofillHints.name],
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(hintText: AppLocalizations.of(context)!.name),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      TextFormField(
                        controller: _username,
                        validator: (val) {
                          if (val!.isEmpty) return 'Please enter a username';
                          if (val.length <= 3) return 'Please enter a valid username';
                          return null;
                        },
                        autofillHints: const [AutofillHints.newUsername],
                        decoration: InputDecoration(hintText: AppLocalizations.of(context)!.username),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      TextFormField(
                        controller: _email,
                        validator: (val) {
                          if (val!.isEmpty) return 'Please enter your email address';
                          return null;
                        },
                        autofillHints: const [AutofillHints.email],
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(hintText: AppLocalizations.of(context)!.email),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      TextFormField(
                        controller: _phone,
                        validator: (val) {
                          if (val!.isEmpty) return 'Please enter your phone number';
                          if (val.length < 9) return 'Please enter a valid phone number';
                          return null;
                        },
                        maxLength: 9,
                        autofillHints: const [AutofillHints.telephoneNumber],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: AppLocalizations.of(context)!.phone),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      TextFormField(
                        controller: _dob,
                        readOnly: true,
                        validator: (val) {
                          if (val!.isEmpty) return 'Please enter your date of birth';
                          return null;
                        },
                        onTap: () => showDatePicker(
                            context: context,
                            initialDate: DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day),
                            lastDate: DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day),
                            firstDate: DateTime(1950),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: background(context),
                                    background: background(context), // <-- SEE HERE
                                    onPrimary: primary(context), // <-- SEE HERE
                                    onSurface: background(context), // <-- SEE HERE
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      primary: background(context), // button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            }).then((value) => {
                              if (value != null)
                                {
                                  setState(() {
                                    _dob.text = '${value.day}/${value.month}/${value.year}';
                                  })
                                }
                            }),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.birthday,
                          suffixIcon: const Icon(
                            Icons.date_range_outlined,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) return 'Please enter a password';
                          if (val.length < 8) return 'Please choose a stronger password';
                          return null;
                        },
                        controller: _password,
                        autofillHints: const [AutofillHints.newPassword],
                        decoration: InputDecoration(hintText: AppLocalizations.of(context)!.password),
                        obscureText: true,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) return 'Please confirm your password';
                          if (val != _password.text) return 'The passwords do not match';
                          return null;
                        },
                        controller: _confirmPass,
                        decoration: InputDecoration(hintText: AppLocalizations.of(context)!.confirm),
                        obscureText: true,
                      ),
                    ],
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
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.registerButton),
                    ),
                  ),
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'Log In'),
                child: Text(
                  AppLocalizations.of(context)!.haveAccount,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
