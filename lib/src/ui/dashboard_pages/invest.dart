import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../res/styles.dart';

class Invest extends StatefulWidget {
  const Invest({Key? key}) : super(key: key);

  @override
  State<Invest> createState() => _InvestState();
}

class _InvestState extends State<Invest> {
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
                  onPressed: () {
                    Navigator.pushNamed(context, 'Deposit');
                  },
                  child: Text(AppLocalizations.of(context)!.depositButton)),
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
                  onPressed: () {
                    Navigator.pushNamed(context, 'Withdraw');
                  },
                  child: Text(AppLocalizations.of(context)!.withdrawButton)),
            ),
          ),
        ],
      ),
    );
  }
}
