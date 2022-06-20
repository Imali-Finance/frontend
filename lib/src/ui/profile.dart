import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imali/src/methods.dart';
import 'package:imali/src/res/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isVerified = false;
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
            Text(
              'Display Name',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: primary(context).withOpacity(0.5),
                  ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Text(AppLocalizations.of(context)!.changeUsername),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Text(
              'Username',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: primary(context).withOpacity(0.5),
                  ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Text(AppLocalizations.of(context)!.changePhone),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Text(
              '+254712345678',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: primary(context).withOpacity(0.5),
                  ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Text(AppLocalizations.of(context)!.changeEmail),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Text(
              'someone@example.com',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: primary(context).withOpacity(0.5),
                  ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {},
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
                      color: _isVerified ? Colors.green[700]! : Colors.red[900]!,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/facebook.svg',
                      color: _isVerified ? Colors.green[700]! : Colors.red[900]!,
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
                      color: _isVerified ? Colors.green[700]! : Colors.red[900]!,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/google.svg',
                      color: _isVerified ? Colors.green[700]! : Colors.red[900]!,
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
                      color: _isVerified ? Colors.green[700]! : Colors.red[900]!,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/twitter.svg',
                      color: _isVerified ? Colors.green[700]! : Colors.red[900]!,
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
                onPressed: () {},
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
                onPressed: () {},
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
}
