import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
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
      body: Container(
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
            const Spacer(),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container();
                },
              ),
            ),
            const Spacer(),
            Text(
              'Imali Bonds',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const Spacer(),
            Text(
              'Imali MMF',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
