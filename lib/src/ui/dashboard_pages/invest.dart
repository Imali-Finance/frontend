import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../methods.dart';
import '../../res/styles.dart';

class Invest extends StatelessWidget {

  String user = 'Kimberly';
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height(context),
        width: width(context),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.preference,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const Spacer(),
            Expanded(
              flex: 4,
              child: SizedBox(
                width: width(context),
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(AppLocalizations.of(context)!.depositButton)
                ),
              ),
            ),
            const Spacer(),
            Text(
              AppLocalizations.of(context)!.or,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const Spacer(),
            Expanded(
              flex: 4,
              child: SizedBox(
                width: width(context),
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(AppLocalizations.of(context)!.withdrawButton)
                ),
              ),
            ),
          ],
        ),
    );
  }
}
