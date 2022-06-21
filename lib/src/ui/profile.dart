import 'dart:developer';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imali/src/methods.dart';
import 'package:imali/src/res/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:imali/src/user.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool? _isFacebookVerified, _isGmailVerified, _isTwitterVerified;
  String? _display, _username, _phone, _email;
  String? _cc = '+254';
  final TextEditingController _displaynameController = TextEditingController(),
      _usernameController = TextEditingController(),
      _phoneController = TextEditingController(),
      _emailController = TextEditingController();
  final GlobalKey<FormState> _change = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<User>(context, listen: false).getUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    var _data = Provider.of<User>(context);
    _isFacebookVerified = _data.isFacebookLinked ?? false;
    _isGmailVerified = _data.isGmailLinked ?? false;
    _isTwitterVerified = _data.isTwitterLinked ?? false;
    _display = _data.displayName ?? 'User';
    _username = _data.username ?? 'user';
    _phone = _data.phone ?? 'N/A';
    _email = _data.email ?? 'N/A';
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
      body: Container(
        height: height(context),
        width: width(context),
        padding: const EdgeInsets.all(20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Text(AppLocalizations.of(context)!.changeDisplay),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            GestureDetector(
              onTap: () =>
                  _changeUserInfo(context, 'Change display name', 'displayname', _displaynameController, (val) {
                if (val!.isEmpty) return 'Please enter your name';
                if (val.length <= 3) return 'Name cannot be less than 3 characters';
                if (val.length > 20) return 'Display name cannot be more than 20 characters';
                if (!RegExp(r'^(?=.{3,20}$)(?![ .])(?!.*[ .]{2})[a-zA-Z. ]+(?<![ .])$').hasMatch(val))
                  return 'Do not use characters or numbers on your display name';
                return null;
              }, AppLocalizations.of(context)!.name, hint: [AutofillHints.name], type: TextInputType.name),
              child: Text(
                _display!,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: primary(context).withOpacity(0.5),
                    ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Text(AppLocalizations.of(context)!.changeUsername),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            GestureDetector(
              onTap: () => _changeUserInfo(context, 'Change username', 'username', _usernameController, (val) {
                if (val!.isEmpty) return 'Please enter a username';
                if (!RegExp(r'^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$').hasMatch(val)) {
                  return 'Please enter a valid username';
                }
                if (val.length <= 3) return 'Please enter a valid username';
                return null;
              }, AppLocalizations.of(context)!.username, hint: [AutofillHints.newUsername]),
              child: Text(
                '@${_username!}',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: primary(context).withOpacity(0.5),
                    ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Text(AppLocalizations.of(context)!.changePhone),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            GestureDetector(
              onTap: () => _changeUserInfo(
                context,
                'Change phone number',
                'phone',
                _phoneController,
                (val) {
                  if (val!.isEmpty) return 'Please enter your phone number';
                  if (val.length != 9) return 'Please enter a valid phone number';
                  return null;
                },
                AppLocalizations.of(context)!.phone,
                hint: [AutofillHints.telephoneNumber],
                type: TextInputType.number,
                prefix: CountryCodePicker(
                  countryFilter: const ['KE', 'TZ', 'UG'],
                  initialSelection: 'KE',
                  onInit: (val) {
                    _cc = '+254';
                  },
                  onChanged: (code) {
                    setState(() {
                      _cc = code.dialCode;
                    });
                  },
                ),
              ),
              child: Text(
                _phone!,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: primary(context).withOpacity(0.5),
                    ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Text(AppLocalizations.of(context)!.changeEmail),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            GestureDetector(
              onTap: () => _changeUserInfo(context, 'Change email address', 'email', _emailController, (val) {
                if (val!.isEmpty) return 'Please enter your email address';
                if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)) {
                  return 'Please enter a valid email address';
                }
                return null;
              }, AppLocalizations.of(context)!.email, type: TextInputType.emailAddress, hint: [AutofillHints.email]),
              child: Text(
                _email!,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: primary(context).withOpacity(0.5),
                    ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {
                  showSnackbar(context, 'Sorry, this feature is not currently available');
                },
                child: Text(
                  AppLocalizations.of(context)!.changePass,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.linkSocials,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 30),
                ),
                Container(
                  height: 20,
                  width: 20,
                  padding: const EdgeInsets.all(3.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isFacebookVerified! ? Colors.green[700]! : Colors.red[900]!,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/facebook.svg',
                      color: _isFacebookVerified! ? Colors.green[700]! : Colors.red[900]!,
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: 20,
                  padding: const EdgeInsets.all(3.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isGmailVerified! ? Colors.green[700]! : Colors.red[900]!,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/google.svg',
                      color: _isGmailVerified! ? Colors.green[700]! : Colors.red[900]!,
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: 20,
                  padding: const EdgeInsets.all(3.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isTwitterVerified! ? Colors.green[700]! : Colors.red[900]!,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/twitter.svg',
                      color: _isTwitterVerified! ? Colors.green[700]! : Colors.red[900]!,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {
                  showSnackbar(context, 'Sorry, this feature is not currently available');
                },
                child: Text(
                  AppLocalizations.of(context)!.requestTransaction,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {
                  showSnackbar(context, 'Sorry, this feature is not currently available');
                },
                child: Text(
                  AppLocalizations.of(context)!.deleteAcc,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeUserInfo(BuildContext context, String title, String key, TextEditingController controller,
      String? Function(String?) validation, String hintText,
      {Iterable<String>? hint, TextInputType? type, Widget? prefix}) {
    return showCustomDialog(
      context,
      title,
      '',
      [
        TextButton(
          child: const Text('Change'),
          onPressed: () {
            if (_change.currentState!.validate()) {
              storeData(key, string: title != 'Change phone number' ? controller.text : _cc! + controller.text);
              Navigator.of(context).pop();
              controller.clear();
            }
          },
        ),
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            controller.clear();
            Navigator.of(context).pop();
          },
        ),
      ],
      otherActions: [
        Form(
          key: _change,
          child: TextFormField(
            controller: controller,
            autovalidateMode: AutovalidateMode.always,
            validator: validation,
            autofillHints: hint,
            keyboardType: type,
            decoration: InputDecoration(hintText: hintText, prefixIcon: prefix),
          ),
        ),
      ],
    );
  }
}
