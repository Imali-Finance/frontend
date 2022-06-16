import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:imali/src/portfolio.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../methods.dart';
import '../../res/styles.dart';

class Summary extends StatelessWidget {
  String user = 'Kimberly';
  String? mmfVal = '0.0';
  String? mmfCashVal = '0.00';
  String? shareVal = '0.0';
  String? shareCashVal = '0.00';
  String? bondVal = '0.0';
  String? bondCashVal = '0.00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height(context),
        width: width(context),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.greeting('evening') + ', $user',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const Spacer(),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text(
                        'MMF',
                      ),
                      const Spacer(),
                      Text(
                        mmfVal!,
                        style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        'KES $mmfCashVal',
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Bonds',
                      ),
                      const Spacer(),
                      Text(
                        bondVal!,
                        style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        'KES $bondCashVal',
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Shares',
                      ),
                      const Spacer(),
                      Text(
                        shareVal!,
                        style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        'KES $shareCashVal',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.portfolioSummary,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
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
            const Spacer(),
            SizedBox(
              width: width(context),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(AppLocalizations.of(context)!.asset),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(AppLocalizations.of(context)!.lastPrice),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(AppLocalizations.of(context)!.change),
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 10)),
            SizedBox(
              width: width(context),
              height: height(context) * 0.25,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  var _item = portfolioItems.where((element) => element.assetValue > 0).toList()[index];
                  return SizedBox(
                    width: width(context),
                    child: Column(
                      children: [
                        Padding(padding: const EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(_item.assetName, style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(_item.assetValue.toString(), style: Theme.of(context).textTheme.subtitle2),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(_item.changePercentage.toString()+ '%', style: Theme.of(context).textTheme.subtitle2!.copyWith(color: _item.changePercentage.isNegative == true ? Colors.red[900] : Colors.green[700]))
                              ),
                            ),
                          ],
                        ),
                      Padding(padding: const EdgeInsets.only(top: 10)),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
