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
  double? mmfVal = 0,
      shareVal = 0,
      bondVal = 0,
      mmfCashVal = 0,
      bondCashVal = 0,
      shareCashVal = 0,
      _partialNum = 0,
      _withdrawalAmount = 0;
  InvestmentType? asset;
  PaymentType? paymentType;
  int _amountWithdrawnGroup = 0;
  int _selected = 0;
  double _amountCalculated() {
    switch (asset) {
      case InvestmentType.shares:
        return shareVal! * shareCashVal!;
      case InvestmentType.bonds:
        return bondVal! * bondCashVal!;
      case InvestmentType.mmf:
        return mmfVal! * mmfCashVal!;
      default:
        0;
        return 0;
    }
  }

  double _amountPartialCalculated(double? partial) {
    switch (asset) {
      case InvestmentType.shares:
        return shareCashVal! * (partial ?? 0);
      case InvestmentType.bonds:
        return bondCashVal! * (partial ?? 0);
      case InvestmentType.mmf:
        return mmfCashVal! * (partial ?? 0);
      default:
        0;
        return 0;
    }
  }

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
    Provider.of<Portfolio>(context).getWithdrawalAmount();
    mmfVal = Provider.of<User>(context).mmfInvestmentValue ?? 0;
    shareVal = Provider.of<User>(context).sharesInvestmentValue ?? 0;
    bondVal = Provider.of<User>(context).bondsInvestmentValue ?? 0;
    mmfCashVal = Provider.of<Portfolio>(context).mmfValue ?? 0;
    bondCashVal = Provider.of<Portfolio>(context).bondsValue ?? 0;
    shareCashVal = Provider.of<Portfolio>(context).sharesValue ?? 0;
    _withdrawalAmount = Provider.of<Portfolio>(context).withdrawalAmount ?? 0;
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
      body: SingleChildScrollView(
        child: Container(
          height: height(context)*0.9,
          width: width(context),
          padding: const EdgeInsets.all(20),
          child: PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              withdrawalType(context),
              if (paymentType == PaymentType.mpesa) mpesaPayment(),
              if (paymentType == PaymentType.bank) bankPayment(),
              Column(
                children: [
                  const Spacer(),
                  Text(
                    'Confirm your withdrawal request details',
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Asset withdrawn'),
                      Text(AppLocalizations.of(context)!.amount),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_withdrawalAmount!.toStringAsFixed(2)} of ' + _confirm(),
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'KES ' +
                              (_amountWithdrawnGroup == 1
                                  ? _amountCalculated().toStringAsFixed(0)
                                  : (_amountPartialCalculated(_partialNum!)).toStringAsFixed(0)) +
                              '.00',
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: width(context),
                    child: OutlinedButton(
                      child: const Text('WITHDRAW'),
                      onPressed: () {
                        if (paymentType == PaymentType.mpesa) {
                          Provider.of<User>(context, listen: false)
                              .withdrawViaMpesa(asset!)
                              .then((value) => Navigator.of(context).pop());
                        } else if (paymentType == PaymentType.bank) {
                          Provider.of<User>(context, listen: false)
                              .withdrawViaBank(asset!)
                              .then((value) => Navigator.of(context).pop());
                        }
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _confirm() {
    switch (asset) {
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
                FocusManager.instance.primaryFocus?.unfocus();
                _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
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
                  FocusManager.instance.primaryFocus?.unfocus();
                  _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: ChoiceChip(
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
                        shareVal!.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        'KES ${(shareCashVal! * shareVal!).toStringAsFixed(2)}',
                        style: TextStyle(color: primary(context)),
                      ),
                    ],
                  ),
                ),
                selected: _selected == 1,
              ),
            ),
            Flexible(
              child: ChoiceChip(
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
                        bondVal!.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        'KES ${(bondCashVal! * bondVal!).toStringAsFixed(2)}',
                        style: TextStyle(color: primary(context)),
                      ),
                    ],
                  ),
                ),
                selected: _selected == 2,
              ),
            ),
            Flexible(
              child: ChoiceChip(
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
                        mmfVal!.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        'KES ${(mmfCashVal! * mmfVal!).toStringAsFixed(2)}',
                        style: TextStyle(color: primary(context)),
                      ),
                    ],
                  ),
                ),
                selected: _selected == 3,
              ),
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
              autovalidateMode: AutovalidateMode.always,
              controller: _amount,
              validator: (val) {
                String source = val ?? '0';
                double _amount = double.parse(val!.isNotEmpty ? source : '0');
                if (val.isEmpty) {
                  return 'Please enter a value';
                }
                if (val == '0') {
                  return 'Please enter an amount';
                }
                if (_amount == 0) {
                  return 'Please enter an amount';
                }
                if (!(_amount < 9.990)) {
                  return 'The limit is 9.99';
                }
                if (!RegExp(r'(\d|[0-9]?[0-9])').hasMatch(val)) {
                  return 'The limit is 9.99';
                }
                if (RegExp(r'([a-z|A-Z]|\W^[\.])').hasMatch(val)) {
                  return 'There seems to be something that is not a number here';
                }
                if (asset == InvestmentType.mmf) {
                  if (_amount > mmfVal!) return 'You cannot withdraw more than your balance';
                } else if (asset == InvestmentType.bonds) {
                  if (_amount > bondVal!) return 'You cannot withdraw more than your balance';
                } else if (asset == InvestmentType.shares) {
                  if (_amount > shareVal!) return 'You cannot withdraw more than your balance';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.headline4,
              onChanged: (val) {
                setState(() => _partialNum = double.parse(val.isNotEmpty ? val : '0'));
              },
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
        Text(
            'You will receive: KES ${_amountWithdrawnGroup == 1 ? _amountCalculated().toStringAsFixed(0) : (_amountPartialCalculated(_partialNum!)).toStringAsFixed(0)}/-',
            style: TextStyle(color: primary(context).withOpacity(0.5))),
        const Spacer(),
        SizedBox(
          width: width(context),
          child: OutlinedButton(
            child: Text(AppLocalizations.of(context)!.mpesaWithdrawal),
            onPressed: () {
              if (_selected == 1 || _selected == 2 || _selected == 3) {
                if (_amountWithdrawnGroup == 1 || _amountWithdrawnGroup == 2) {
                  log('The user balance is ' + _amountCalculated().toString());
                  if (_amountCalculated() > 500 || _amountPartialCalculated(_partialNum) > 500) {
                    if (_amountWithdrawnGroup == 1 && _amountCalculated() > 500) {
                      storeData('amountWithdrawn', doub: _amountCalculated());
                      storeAmountOfAsset();
                      setState(() {
                        paymentType = PaymentType.mpesa;
                      });
                      _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                    } else if (_amountWithdrawnGroup == 2 && _amountPartialCalculated(_partialNum) > 500) {
                      if (_form.currentState!.validate()) {
                        storeData('amountWithdrawn', doub: _amountPartialCalculated(_partialNum));
                        storeAmountOfAsset();
                        setState(() {
                          paymentType = PaymentType.mpesa;
                        });
                        _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                      }
                    } else {
                      showSnackbar(context, 'Your withdrawal needs to at least be KES 500');
                    }
                  } else {
                    log('The user balance is ' + _amountCalculated().toString());
                    showSnackbar(context, 'Your withdrawal cannot be less than KES 500');
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
                  log('The user balance is ' + _amountCalculated().toString());
                  if (_amountCalculated() > 500 || _amountPartialCalculated(_partialNum) > 500) {
                    if (_amountWithdrawnGroup == 1 && _amountCalculated() > 500) {
                      storeData('amountWithdrawn', doub: _amountCalculated());
                      storeAmountOfAsset();
                      setState(() {
                        paymentType = PaymentType.bank;
                      });
                      _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                    } else if (_amountWithdrawnGroup == 2 && _amountPartialCalculated(_partialNum) > 500) {
                      if (_form.currentState!.validate()) {
                        storeData('amountWithdrawn', doub: _amountPartialCalculated(_partialNum));
                        storeAmountOfAsset();
                        setState(() {
                          paymentType = PaymentType.bank;
                        });
                        _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                      }
                    } else {
                      showSnackbar(context, 'Your withdrawal needs to at least be KES 500');
                    }
                  } else {
                    log('The user balance is ' + _amountCalculated().toString());
                    showSnackbar(context, 'Your withdrawal cannot be less than KES 500');
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

  storeAmountOfAsset() {
    switch (asset) {
      case InvestmentType.shares:
        if (_amountWithdrawnGroup == 1) {
          storeData('amountOfAssetWithdrawn', doub: shareVal);
        } else if (_amountWithdrawnGroup == 2) {
          storeData('amountOfAssetWithdrawn', doub: _partialNum);
        }
        break;
      case InvestmentType.bonds:
        if (_amountWithdrawnGroup == 1) {
          storeData('amountOfAssetWithdrawn', doub: bondVal);
        } else if (_amountWithdrawnGroup == 2) {
          storeData('amountOfAssetWithdrawn', doub: _partialNum);
        }
        break;
      case InvestmentType.mmf:
        if (_amountWithdrawnGroup == 1) {
          storeData('amountOfAssetWithdrawn', doub: mmfVal);
        } else if (_amountWithdrawnGroup == 2) {
          storeData('amountOfAssetWithdrawn', doub: _partialNum);
        }
        break;
      default:
        log('Oof, something was null');
    }
  }
}

enum PaymentType { mpesa, bank }
