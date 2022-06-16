import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../methods.dart';
import '../../res/styles.dart';

class Account extends StatelessWidget {
  String user = 'Kimberly Kuya';
  String username = 'kimberlykuya';
  String email = 'kimberlykeisha9@gmail.com';
  String phoneNumber = '+254712345678';
  @override
  Widget build(BuildContext context) {
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
              user,
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
          Center(child: Text(email)),
          const Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Center(child: Text(phoneNumber)),
          const Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.editProfile),
                onPressed: () {},
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
                child: Text(AppLocalizations.of(context)!.notifications),
                onPressed: () {},
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
                child: Text(AppLocalizations.of(context)!.lang),
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
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
                child: Text(AppLocalizations.of(context)!.theme),
                onPressed: () {},
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
                onPressed: () {},
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
        ],
      ),
    );
  }
}
