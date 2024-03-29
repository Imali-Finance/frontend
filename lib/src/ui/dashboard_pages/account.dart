import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:imali/src/user.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../methods.dart';
import '../../res/styles.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String? user;
  String? username;
  String? email;
  String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    Provider.of<User>(context).getUserInformation();
    user = Provider.of<User>(context).displayName ?? 'User';
    username = Provider.of<User>(context).username ?? 'user';
    email = Provider.of<User>(context).email ?? 'N/A';
    phoneNumber = Provider.of<User>(context).phone ?? 'N/A';
    return Container(
      height: height(context),
      width: width(context),
      padding: const EdgeInsets.all(20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Icon(Icons.account_circle_outlined, size: 100, color: primary(context)),
          const Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          Center(
            child: Text(
              user!,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Center(child: Text('@$username')),
          const Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          Center(child: Text(email!)),
          const Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Center(child: Text(phoneNumber!)),
          const Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.editProfile),
                onPressed: () {
                  Navigator.of(context).pushNamed('Profile');
                },
              ),
              Container(
                height: 25,
                width: 25,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: primary(context)),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 10,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context).pushNamed('Profile');
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: primary(context),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.notifications),
                onPressed: () {
                  showSnackbar(context, 'Sorry, this feature is not currently available');
                },
              ),
              Container(
                height: 25,
                width: 25,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: primary(context)),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 10,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: primary(context),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(AppLocalizations.of(context)!.lang, textAlign: TextAlign.left),
                  onPressed: () {
                    showCustomDialog(
                        context,
                        'Change your language',
                        'Currently the only available language is English. More languages will be added in a later update.',
                        [
                          TextButton(
                              child: Text(AppLocalizations.of(context)!.ok), onPressed: () => Navigator.of(context).pop())
                        ]);
                  },
                ),
              ),
              Container(
                height: 25,
                width: 25,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: primary(context)),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 10,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: primary(context),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.aboutUs),
                onPressed: () {
                  showSnackbar(context, 'Sorry, this feature is not currently available');
                },
              ),
              Container(
                height: 25,
                width: 25,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: primary(context)),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 10,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: primary(context),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.privacyPolicy),
                onPressed: () {
                  showSnackbar(context, 'Sorry, this feature is not currently available');
                },
              ),
              Container(
                height: 25,
                width: 25,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: primary(context)),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 10,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: primary(context),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.help),
                onPressed: () {
                  Navigator.of(context).pushNamed('Help');
                },
              ),
              Container(
                height: 25,
                width: 25,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: primary(context)),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 10,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context).pushNamed('Help');
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: primary(context),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.theme),
                onPressed: () {
                  showCustomDialog(context, 'Change Theme',
                      'At the moment, Imali only supports dark mode. More theme options will be available soon.', [
                    TextButton(
                        child: Text(AppLocalizations.of(context)!.ok), onPressed: () => Navigator.of(context).pop())
                  ]);
                },
              ),
              Container(
                height: 25,
                width: 25,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: primary(context)),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 10,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: primary(context),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.logOut),
                onPressed: () {
                  showCustomDialog(
                      context, 'Log out of your account', 'Are you sure you want to log out of your Imali account?', [
                    TextButton(
                        onPressed: () {
                          Provider.of<User>(context, listen: false).clearLocalStorage();
                          Navigator.of(context).pushNamedAndRemoveUntil('Home', (route) => false);
                        },
                        child: Text(AppLocalizations.of(context)!.yes)),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(AppLocalizations.of(context)!.no)),
                  ]);
                },
              ),
              Container(
                height: 25,
                width: 25,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: primary(context)),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 10,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: primary(context),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          Center(child: Text(AppLocalizations.of(context)!.checkOut)),
          const Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          SizedBox(
            width: width(context) * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _launchURL('https://www.facebook.com'),
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
                    onTap: () => _launchURL('https://www.google.com'),
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
                    onTap: () => _launchURL('https://www.twitter.com'),
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
        ],
      ),
    );
  }

  _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      log('An error occured');
      showSnackbar(context, 'Something went wrong');
    }

  }
}
