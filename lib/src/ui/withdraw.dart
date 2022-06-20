import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imali/src/methods.dart';
import 'package:imali/src/res/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:imali/src/user.dart';
import 'package:provider/provider.dart';

import '../portfolio.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  double? mmfVal, shareVal, bondVal;
  InvestmentType? asset;
  PaymentType? paymentType;
  int _amountWithdrawnGroup = 0;
  int _selected = 0;
  final double? _partialAmount = 1287.23;
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
    Provider.of<User>(context).getUserInformation();
    Provider.of<Portfolio>(context).getPortfolioValues();
    mmfVal = Provider.of<User>(context).mmfInvestmentValue ?? 0;
    shareVal = Provider.of<User>(context).sharesInvestmentValue ?? 0;
    bondVal = Provider.of<User>(context).bondsInvestmentValue ?? 0;
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
        padding: const EdgeInsets.all(20),
        child: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            withdrawalType(context),
            if (paymentType == PaymentType.mpesa) mpesaPayment(),
            if (paymentType == PaymentType.bank) bankPayment(),
          ],
        ),
      ),
    );
  }

  Widget mpesaPayment() {
    return Column(
      children: [
        const Spacer(flex: 2),
        Text(
          AppLocalizations.of(context)!.mpesaWithdrawalPrompt,
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
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
        const Spacer(),
        SizedBox(
          width: width(context),
          child: OutlinedButton(
            child: Text(AppLocalizations.of(context)!.nextButton),
            onPressed: () {
              if (_mpesaForm.currentState!.validate()) {
                log('M-Pesa payment number is +254${_mpesaNumber.text}');
              }
            },
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }

  Widget bankPayment() {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _bankForm,
      child: Column(
        children: [
          const Spacer(flex: 2),
          Text(
            AppLocalizations.of(context)!.mpesaWithdrawalPrompt,
            style: Theme.of(context).textTheme.subtitle2,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
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
          const Spacer(),
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
          const Spacer(),
          SizedBox(
            width: width(context),
            child: OutlinedButton(
              child: Text(AppLocalizations.of(context)!.nextButton),
              onPressed: () {
                if (_bankForm.currentState!.validate()) {
                  log('Banking details are: Bank Account Number ${_bankAccount.text} and SWIFT Code ${_swiftCode.text}');
                }
              },
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Column withdrawalType(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          AppLocalizations.of(context)!.withdrawalType,
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ChoiceChip(
              onSelected: (val) {
                setState(() {
                  _selected == 1 ? {_selected = 0, asset = null} : {_selected = 1, asset = InvestmentType.shares};
                });
              },
              elevation: 0,
              shape: const RoundedRectangleBorder(),
              avatarBorder: RoundedRectangleBorder(side: BorderSide(color: primary(context))),
              label: Container(
                padding: const EdgeInsets.all(10),
                height: height(context) * 0.15,
                child: Column(
                  children: [
                    Text(
                      'Shares',
                      style: TextStyle(color: primary(context)),
                    ),
                    const Spacer(),
                    Text(
                      shareVal!.toString(),
                      style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      'KES ${Provider.of<Portfolio>(context).sharesValue}',
                      style: TextStyle(color: primary(context)),
                    ),
                  ],
                ),
              ),
              selected: _selected == 1,
            ),
            ChoiceChip(
              onSelected: (val) {
                setState(() {
                  _selected == 2 ? {_selected = 0, asset = null} : {_selected = 2, asset = InvestmentType.bonds};
                });
              },
              shape: const RoundedRectangleBorder(),
              avatarBorder: RoundedRectangleBorder(side: BorderSide(color: primary(context))),
              label: Container(
                padding: const EdgeInsets.all(10),
                height: height(context) * 0.15,
                child: Column(
                  children: [
                    Text(
                      'Bonds',
                      style: TextStyle(color: primary(context)),
                    ),
                    const Spacer(),
                    Text(
                      bondVal!.toString(),
                      style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      'KES ${Provider.of<Portfolio>(context).bondsValue}',
                      style: TextStyle(color: primary(context)),
                    ),
                  ],
                ),
              ),
              selected: _selected == 2,
            ),
            ChoiceChip(
              onSelected: (val) {
                setState(() {
                  _selected == 3 ? {_selected = 0, asset = null} : {_selected = 3, asset = InvestmentType.mmf};
                });
              },
              shape: const RoundedRectangleBorder(),
              avatarBorder: RoundedRectangleBorder(side: BorderSide(color: primary(context))),
              label: Container(
                padding: const EdgeInsets.all(10),
                height: height(context) * 0.15,
                child: Column(
                  children: [
                    Text(
                      'MMF',
                      style: TextStyle(color: primary(context)),
                    ),
                    const Spacer(),
                    Text(
                      mmfVal!.toString(),
                      style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      'KES ${Provider.of<Portfolio>(context).mmfValue}',
                      style: TextStyle(color: primary(context)),
                    ),
                  ],
                ),
              ),
              selected: _selected == 3,
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: Radio(
                activeColor: MaterialStateColor.resolveWith((states) => Colors.white),
                groupValue: _amountWithdrawnGroup,
                value: 1,
                onChanged: (int? value) {
                  setState(() {
                    _amountWithdrawnGroup = value!;
                  });
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(AppLocalizations.of(context)!.total),
            ),
            Expanded(
              child: Radio(
                activeColor: MaterialStateColor.resolveWith((states) => Colors.white),
                groupValue: _amountWithdrawnGroup,
                value: 2,
                onChanged: (int? value) {
                  setState(() {
                    _amountWithdrawnGroup = value!;
                  });
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(AppLocalizations.of(context)!.partial),
            ),
          ],
        ),
        const Spacer(),
        if (_amountWithdrawnGroup == 2)
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
                if (!RegExp(r'(1|2)').hasMatch(val)) {
                  return 'You cannot withdraw more than 2';
                }
                if (RegExp(r'([a-z|A-Z]|\W^[\.])').hasMatch(val)) {
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
                  asset == InvestmentType.bonds
                      ? 'Bonds'
                      : asset == InvestmentType.mmf
                          ? 'MMF'
                          : asset == InvestmentType.shares
                              ? 'Shares'
                              : 'N/A',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.bold, color: primary(context).withOpacity(0.5)),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 100,
                ),
              ),
            ),
          ),
        if (_amountWithdrawnGroup == 2) const Spacer(),
        if (_amountWithdrawnGroup == 2)
          Text('You will receive: KES $_partialAmount', style: TextStyle(color: primary(context).withOpacity(0.5))),
        if (_amountWithdrawnGroup == 2) const Spacer(),
        SizedBox(
          width: width(context),
          child: OutlinedButton(
            child: Text(AppLocalizations.of(context)!.mpesaWithdrawal),
            onPressed: () {
              if (_selected == 1 || _selected == 2 || _selected == 3) {
                if (_amountWithdrawnGroup == 1 || _amountWithdrawnGroup == 2) {
                  if (_amountWithdrawnGroup == 1) {
                    setState(() {
                      paymentType = PaymentType.mpesa;
                    });
                    _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                  } else if (_amountWithdrawnGroup == 2) {
                    if (_form.currentState!.validate()) {
                      setState(() {
                        paymentType = PaymentType.mpesa;
                      });
                      _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                    }
                  }
                } else {
                  showSnackbar(context, 'How much do you want to withdraw?');
                }
              } else {
                showSnackbar(context, 'Please select which asset you want to withdraw');
              }
            },
          ),
        ),
        const Spacer(),
        SizedBox(
          width: width(context),
          child: OutlinedButton(
            child: Text(AppLocalizations.of(context)!.bankWithdrawal),
            onPressed: () {
              if (_selected == 1 || _selected == 2 || _selected == 3) {
                if (_amountWithdrawnGroup == 1 || _amountWithdrawnGroup == 2) {
                  if (_amountWithdrawnGroup == 1) {
                    setState(() {
                      paymentType = PaymentType.bank;
                    });
                    _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                  } else if (_amountWithdrawnGroup == 2) {
                    if (_form.currentState!.validate()) {
                      setState(() {
                        paymentType = PaymentType.bank;
                      });
                      _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                    }
                  }
                } else {
                  showSnackbar(context, 'How much do you want to withdraw?');
                }
              } else {
                showSnackbar(context, 'Please select which asset you want to withdraw');
              }
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

enum PaymentType { mpesa, bank }
