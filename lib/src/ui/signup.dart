import 'dart:developer';
import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:imali/src/methods.dart';
import 'package:imali/src/user.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../res/styles.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _name = TextEditingController(),
      _username = TextEditingController(),
      _phone = TextEditingController(),
      _email = TextEditingController(),
      _password = TextEditingController(),
      _confirmPass = TextEditingController(),
      _dob = TextEditingController();
  late GlobalKey<FormState> _form1, _form2, _form3;
  final PageController _controller = PageController();
  String? _cc = '+254', _smsCode;
  int? _idRadio = 0;
  File? _id;
  @override
  void initState() {
    super.initState();
    _form1 = GlobalKey<FormState>();
    _form2 = GlobalKey<FormState>();
    _form3 = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    _id = Provider.of<User>(context).identificationPhoto;
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
      body: Container(
        width: width(context),
        height: height(context),
        padding: const EdgeInsets.all(20),
        child: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            registerPage(context),
            verifyPhonePage(context),
            verifyIdentityPage(context),
          ],
        ),
      ),
    );
  }

  Form verifyIdentityPage(BuildContext context) {
    return Form(
      key: _form3,
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.verifyIdentity,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Spacer(),
          Text(
            AppLocalizations.of(context)!.verifyIdentityBody,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          RadioListTile(
            activeColor: MaterialStateColor.resolveWith((states) => Colors.white),
            value: 1,
            groupValue: _idRadio,
            onChanged: (int? val) {
              setState(() {
                _idRadio = val;
              });
            },
            title: Text(
              AppLocalizations.of(context)!.nationalID,
            ),
            dense: true,
          ),
          RadioListTile(
            activeColor: MaterialStateColor.resolveWith((states) => Colors.white),
            value: 2,
            groupValue: _idRadio,
            onChanged: (int? val) {
              setState(() {
                _idRadio = val;
              });
            },
            title: Text(AppLocalizations.of(context)!.passport),
            dense: true,
          ),
          RadioListTile(
            activeColor: MaterialStateColor.resolveWith((states) => Colors.white),
            value: 3,
            groupValue: _idRadio,
            onChanged: (int? val) {
              setState(() {
                _idRadio = val;
              });
            },
            title: Text(
              AppLocalizations.of(context)!.birthCertificate,
            ),
            dense: true,
          ),
          const Spacer(flex: 2),
          GestureDetector(
            onTap: () => _id == null
                ? Provider.of<User>(context, listen: false).uploadIdentificationImageFromCamera()
                : showCustomDialog(
                    context,
                    'Remove selected image',
                    'Are you sure you want to delete this image. You will have to select another',
                    [
                      TextButton(
                        child: const Text('Remove'),
                        onPressed: () => {
                          setState(() {
                            _id = null;
                          }),
                          Navigator.of(context).pop(),
                        },
                      ),
                      TextButton(
                        child: const Text('Keep'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _id == null ? Colors.red[900]! : Colors.green[700]!,
                ),
              ),
              child: Center(
                child: Text(
                  _id == null ? AppLocalizations.of(context)!.uploadHere : AppLocalizations.of(context)!.uploaded,
                  style: TextStyle(
                    color: _id == null ? Colors.red[900]! : Colors.green[700]!,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(flex: 2),
          SizedBox(
            width: width(context),
            child: OutlinedButton(
              onPressed: () {
                if (_id != null && _idRadio != 0) {
                  Provider.of<User>(context, listen: false)
                      .storeUserInformation(_name.text, _username.text, _email.text, _cc! + _phone.text, _dob.text)
                      .then((_) => Navigator.of(context).pushNamedAndRemoveUntil('Home', (route) => false));
                } else {
                  showSnackbar(context, 'Please select an option and upload an image');
                }
              },
              child: Text(AppLocalizations.of(context)!.verifyButton),
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Form verifyPhonePage(BuildContext context) {
    return Form(
      key: _form2,
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.verifyPhone,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Spacer(),
          Text(
            AppLocalizations.of(context)!.verifyPhoneBody(_cc! + _phone.text),
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 2),
          PinCodeTextField(
            appContext: context,
            length: 6,
            onChanged: (val) {
              setState(() {
                _smsCode = val;
              });
            },
            validator: (val) {
              if (val!.isEmpty) return 'Please enter your verification code';
              if (val.length < 6) return 'Please enter a valid verification code';
              return null;
            },
            // controller: _verification,
            enablePinAutofill: false,
            keyboardType: TextInputType.number,
            pinTheme: PinTheme.defaults(
              shape: PinCodeFieldShape.circle,
              activeColor: primary(context),
              inactiveColor: primary(context),
              selectedColor: primary(context),
              borderWidth: 1,
            ),
          ),
          const Spacer(flex: 3),
          TextButton(
            onPressed: () {
              showCustomDialog(context, 'Change phone number', 's', [
                TextButton(
                  child: const Text('Change Number'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Dismiss'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ], otherActions: [
                Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CountryCodePicker(
                          countryFilter: const ['KE', 'TZ', 'UG'],
                          initialSelection: 'KE',
                          onChanged: (code) {
                            setState(() {
                              _cc = code.code;
                            });
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextFormField(
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
                      ),
                    ),
                  ],
                ),
              ]);
            },
            child: Text(AppLocalizations.of(context)!.wrongNumber),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: Text(AppLocalizations.of(context)!.resendCode),
          ),
          const Spacer(flex: 3),
          SizedBox(
            width: width(context),
            child: OutlinedButton(
              onPressed: () {
                if (_form2.currentState!.validate()) {
                  log('Proceeded');
                  log(_smsCode!);
                  FocusManager.instance.primaryFocus?.unfocus();
                  _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                }
              },
              child: Text(AppLocalizations.of(context)!.verifyButton),
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Form registerPage(BuildContext context) {
    return Form(
      key: _form1,
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
                      if (!RegExp(r'^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$').hasMatch(val)) {
                        return 'Please enter a valid username';
                      }
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
                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    autofillHints: const [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: AppLocalizations.of(context)!.email),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CountryCodePicker(
                            countryFilter: const ['KE', 'TZ', 'UG'],
                            initialSelection: 'KE',
                            onChanged: (code) {
                              setState(() {
                                _cc = code.code;
                              });
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextFormField(
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
                        ),
                      ),
                    ],
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
          const Spacer(flex: 3),
          SizedBox(
            width: width(context),
            child: OutlinedButton(
              onPressed: () {
                if (_form1.currentState!.validate()) {
                  log('Proceeded');
                  FocusManager.instance.primaryFocus?.unfocus();
                  _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                }
              },
              child: Text(AppLocalizations.of(context)!.registerButton),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, 'Log In'),
            child: Text(
              AppLocalizations.of(context)!.haveAccount,
            ),
          ),
        ],
      ),
    );
  }
}
