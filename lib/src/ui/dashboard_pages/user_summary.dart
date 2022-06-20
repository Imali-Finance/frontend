import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:imali/src/portfolio.dart';
import 'package:imali/src/user.dart';
import 'package:provider/provider.dart';
import '../../res/styles.dart';

class Summary extends StatefulWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  String? user;

  double? mmfVal;
  double? bondVal;
  double? shareVal;

  double? mmfCashVal, shareCashVal, bondCashVal;

  @override
  void initState() {
    super.initState();
    Provider.of<User>(context, listen: false).getUserInformation();
    Provider.of<Portfolio>(context, listen: false).getPortfolioValues();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context).displayName ?? 'User';
    mmfVal = Provider.of<User>(context).mmfInvestmentValue ?? 0;
    bondVal = Provider.of<User>(context).bondsInvestmentValue ?? 0;
    shareVal = Provider.of<User>(context).sharesInvestmentValue ?? 0;
    mmfCashVal = Provider.of<Portfolio>(context).mmfValue ?? 0;
    bondCashVal = Provider.of<Portfolio>(context).bondsValue ?? 0;
    shareCashVal = Provider.of<Portfolio>(context).sharesValue ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {});
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
                        mmfVal!.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        'KES ${(mmfCashVal! * mmfVal!).toStringAsFixed(2)}',
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
                        bondVal!.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        'KES ${(bondCashVal! * bondVal!).toStringAsFixed(2)}',
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
                        shareVal!.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        'KES ${(shareCashVal! * shareVal!).toStringAsFixed(2)}',
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
                    onPressed: () {
                      Navigator.of(context).pushNamed('Detailed Portfolio');
                    },
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
            const Padding(padding: EdgeInsets.only(top: 10)),
            SizedBox(
              width: width(context),
              height: height(context) * 0.25,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  var _item = portfolioItems.where((element) => element.assetValue! > 0).toList()[index];
                  return SizedBox(
                    width: width(context),
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(_item.assetName!,
                                    style:
                                        Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold)),
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
                                  child: Text(_item.changePercentage.toString() + '%',
                                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                          color: _item.changePercentage!.isNegative == true
                                              ? Colors.red[900]
                                              : Colors.green[700]))),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
