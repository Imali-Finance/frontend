import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imali/src/portfolio.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:imali/src/res/styles.dart';

class DetailedPortfolio extends StatefulWidget {
  const DetailedPortfolio({Key? key}) : super(key: key);

  @override
  State<DetailedPortfolio> createState() => _DetailedPortfolioState();
}

class _DetailedPortfolioState extends State<DetailedPortfolio> {
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
      body: SingleChildScrollView(
        child: Container(
          width: width(context),
          height: height(context),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Imali Shares',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Spacer(),
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
                height: height(context) *0.175,
                width: width(context),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: portfolioItems.where((element) => element.type! ==  InvestmentType.shares).toList().length,
                  itemBuilder: (context, index) {
                    var _item = portfolioItems.where((element) => element.type! ==  InvestmentType.shares).toList()[index];
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
                                  child: Text(_item.assetValue!.toStringAsFixed(2), style: Theme.of(context).textTheme.subtitle2),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(_item.changePercentage!.toStringAsFixed(2) + '%',
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
              const Spacer(),
              Divider(color: primary(context)),
              const Spacer(flex: 2),
              Text(
                'Imali Bonds',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Spacer(),
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
                height: height(context) *0.175,
                width: width(context),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: portfolioItems.where((element) => element.type! ==  InvestmentType.bonds).toList().length,
                  itemBuilder: (context, index) {
                    var _item = portfolioItems.where((element) => element.type! ==  InvestmentType.bonds).toList()[index];
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
                                  child: Text(_item.assetValue!.toStringAsFixed(2), style: Theme.of(context).textTheme.subtitle2),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(_item.changePercentage!.toStringAsFixed(2) + '%',
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
              const Spacer(),
              Divider(color: primary(context)),
              const Spacer(),
              Text(
                'Imali MMF',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Spacer(),
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
                height: height(context) *0.175,
                width: width(context),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: portfolioItems.where((element) => element.type! ==  InvestmentType.mmf).toList().length,
                  itemBuilder: (context, index) {
                    var _item = portfolioItems.where((element) => element.type! ==  InvestmentType.mmf).toList()[index];
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
                                  child: Text(_item.assetValue!.toStringAsFixed(2), style: Theme.of(context).textTheme.subtitle2),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(_item.changePercentage!.toStringAsFixed(2) + '%',
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
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
