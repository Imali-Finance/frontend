import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imali/src/methods.dart';
import 'package:imali/src/res/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../portfolio.dart';

class Deposit extends StatefulWidget {
  const Deposit({Key? key}) : super(key: key);

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  InvestmentType? investment = InvestmentType.bonds;
  int _paymentGroup = 0;
  double? _shares, _bonds, _mmf;
  final GlobalKey<FormState> _form = GlobalKey<FormState>(),
      _mpesaForm = GlobalKey<FormState>(),
      _bankForm = GlobalKey<FormState>();
  final PageController _controller = PageController();
  final TextEditingController _amount = TextEditingController(text: '0'),
      _mpesaNumber = TextEditingController(),
      _bankAccount = TextEditingController(),
      _swiftCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<Portfolio>(context).getPortfolioValues();
    _shares = Provider.of<Portfolio>(context).sharesValue ?? 0;
    _bonds = Provider.of<Portfolio>(context).bondsValue ?? 0;
    _mmf = Provider.of<Portfolio>(context).mmfValue ?? 0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        padding: const EdgeInsets.all(30),
        child: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            investmentType(context),
            purchaseAmount(context),
            confirmSelection(context),
          ],
        ),
      ),
    );
  }

  Column confirmSelection(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          AppLocalizations.of(context)!.confirmSelection,
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.assetPurchased),
            Text(AppLocalizations.of(context)!.amount),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _confirm(),
                style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'KES ${_amount.text.isEmpty ? 0 : _amount.text}.00',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount Received',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                _received(),
                style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Spacer(flex: 2),
        Row(
          children: [
            Expanded(
              child: Radio(
                activeColor: MaterialStateColor.resolveWith((states) => Colors.white),
                groupValue: _paymentGroup,
                value: 1,
                onChanged: (int? value) {
                  setState(() {
                    _paymentGroup = value!;
                  });
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(AppLocalizations.of(context)!.payMpesa),
            ),
            Expanded(
              child: Radio(
                activeColor: MaterialStateColor.resolveWith((states) => Colors.white),
                groupValue: _paymentGroup,
                value: 2,
                onChanged: (int? value) {
                  setState(() {
                    _paymentGroup = value!;
                  });
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(AppLocalizations.of(context)!.payBank),
            ),
          ],
        ),
        const Spacer(),
        if (_paymentGroup == 1)
          Form(
            autovalidateMode: AutovalidateMode.always,
            key: _mpesaForm,
            child: TextFormField(
              controller: _mpesaNumber,
              validator: (val) {
                if (val!.isEmpty) return 'Please enter your phone number';
                if (!val.startsWith(RegExp(r'([1|7][1|2|4|5|7|9|0])'))) return 'This is not a valid Safaricom number';
                if (val.length < 9) return 'Please enter a valid phone number';
                return null;
              },
              maxLength: 9,
              autofillHints: const [AutofillHints.telephoneNumber],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.phone,
                prefixText: '+254',
              ),
            ),
          ),
        if (_paymentGroup == 2)
          Form(
            autovalidateMode: AutovalidateMode.always,
            key: _bankForm,
            child: Flexible(
              flex: 4,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  TextFormField(
                    controller: _bankAccount,
                    validator: (val) {
                      if (val!.isEmpty) return 'Please enter your Bank account number';
                      if (val.length > 17 || val.length < 8) return 'Please enter a valid Bank account number';
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.bankAccount,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  TextFormField(
                    controller: _swiftCode,
                    validator: (val) {
                      if (val!.isEmpty) return 'Please enter your SWIFT Code';
                      if (val.length > 11 || val.length < 8) return 'Please enter a valid SWIFT Code';
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.swiftCode,
                    ),
                  ),
                ],
              ),
            ),
          ),
        const Spacer(flex: 2),
        SizedBox(
          width: width(context),
          child: OutlinedButton(
            child: Text(AppLocalizations.of(context)!.nextButton),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (_paymentGroup == 1 || _paymentGroup == 2) {
                log('Payment option $_paymentGroup was selected');
                if (_paymentGroup == 1) {
                  if (_mpesaForm.currentState!.validate()) {
                    log('M-Pesa payment number is +254${_mpesaNumber.text}');
                  }
                }
                if (_paymentGroup == 2) {
                  if (_bankForm.currentState!.validate()) {
                    log('Banking details are: Bank Account Number ${_bankAccount.text} and SWIFT Code ${_swiftCode.text}');
                  }
                }
              } else {
                showSnackbar(context, 'Please select a payment option');
              }
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Column purchaseAmount(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 3),
        Text(
          _toBePurchased(),
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Text(
          _assetValue(_shares.toString(), _bonds.toString(), _mmf.toString()),
          style: TextStyle(
            color: primary(context).withOpacity(0.5),
          ),
        ),
        const Spacer(flex: 2),
        Form(
          key: _form,
          child: TextFormField(
            controller: _amount,
            validator: (val) {
              if (val!.isEmpty) {
                return 'Please enter a value';
              }
              if (val == '0') {
                return 'Please enter an amount';
              }
              if (!RegExp(r'([1-9]\d\d+)').hasMatch(val)) {
                return 'You cannot deposit less than KES 100';
              }
              if (RegExp(r'([a-z|A-Z]|\W)').hasMatch(val)) {
                return 'There seems to be something that is not a number here';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.headline4,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: 'Enter amount',
              prefixIcon: Text(
                'KES',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.bold, color: primary(context).withOpacity(0.5)),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 60,
              ),
            ),
          ),
        ),
        const Spacer(flex: 2),
        SizedBox(
          width: width(context),
          child: OutlinedButton(
            child: Text(AppLocalizations.of(context)!.nextButton),
            onPressed: () {
              if (_form.currentState!.validate()) {
                FocusManager.instance.primaryFocus?.unfocus();
                _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
              }
            },
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }

  String _received() {
    double sharesAmount = double.parse(_amount.text) / _shares!;
    double bondAmount = double.parse(_amount.text) / _bonds!;
    double mmfAmount = double.parse(_amount.text) / _mmf!;
    switch (investment) {
      case InvestmentType.shares:
        return sharesAmount.toStringAsFixed(2);
      case InvestmentType.bonds:
        return bondAmount.toStringAsFixed(2);
      case InvestmentType.mmf:
        return mmfAmount.toStringAsFixed(2);
      default:
        '0';
    }
    return '0';
  }

  String _assetValue(String shareValue, String mmfValue, String bondValue) {
    switch (investment) {
      case InvestmentType.shares:
        return '1 share = KES $shareValue';
      case InvestmentType.bonds:
        return '1 bond = KES $bondValue';
      case InvestmentType.mmf:
        return '1 MMF = KES $mmfValue';
      default:
        'An error has occured';
    }
    return 'Please wait';
  }

  String _confirm() {
    switch (investment) {
      case InvestmentType.shares:
        return 'Imali Shares';
      case InvestmentType.bonds:
        return 'Imali Bonds';
      case InvestmentType.mmf:
        return 'Imali MMF';
      default:
        'An error has occured';
    }
    return 'Please wait';
  }

  String _toBePurchased() {
    switch (investment) {
      case InvestmentType.shares:
        return AppLocalizations.of(context)!.sharesToPurchase;
      case InvestmentType.bonds:
        return AppLocalizations.of(context)!.bondsToPurchase;
      case InvestmentType.mmf:
        return AppLocalizations.of(context)!.mmfToPurchase;
      default:
        'An error has occured';
    }
    return 'Please wait';
  }

  Column investmentType(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 4),
        Text(
          AppLocalizations.of(context)!.investmentType,
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 2),
        SizedBox(
          width: width(context),
          child: OutlinedButton(
            child: const Text('SHARES'),
            onPressed: () {
              setState(() {
                investment = InvestmentType.shares;
              });
              _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
            },
          ),
        ),
        const Spacer(),
        SizedBox(
          width: width(context),
          child: OutlinedButton(
            child: const Text('BONDS'),
            onPressed: () {
              setState(() {
                investment = InvestmentType.bonds;
              });
              _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
            },
          ),
        ),
        const Spacer(),
        SizedBox(
          width: width(context),
          child: OutlinedButton(
            child: const Text('MMF'),
            onPressed: () {
              setState(() {
                investment = InvestmentType.mmf;
              });
              _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
            },
          ),
        ),
        const Spacer(flex: 4),
      ],
    );
  }
}
