import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../methods.dart';
import '../res/styles.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'logo',
          child: SvgPicture.asset(
            'images/Logo.svg',
            height: 40,
          ),
        ),
      ),
      body: Container(
        height: height(context),
        width: width(context),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Container(
                width: width(context),
                height: width(context),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: onPrimary(context),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.scale(
                      scaleX: -1,
                      child: Container(
                        width: 200,
                        alignment: Alignment.topRight,
                        child: Text(
                          AppLocalizations.of(context)!.home1,
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ),
                    ),
                    Center(
                      child: SvgPicture.asset('images/home3.svg'),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        width: 200,
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          AppLocalizations.of(context)!.home1,
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: width(context),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('Log In');
                },
                child: Text(
                  AppLocalizations.of(context)!.loginButton,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: width(context),
              child: OutlinedButton(
                onPressed: () => {},
                child: Text(
                  AppLocalizations.of(context)!.registerButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
