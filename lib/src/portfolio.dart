import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Portfolio extends ChangeNotifier {
  String? assetName;
  InvestmentType? type;
  double? assetValue;
  double? changePercentage;
  Portfolio([this.assetName, this.type, this.assetValue, this.changePercentage]);
  // Values of the portfolio assets
  double? _sharesValue;
  double? _bondsValue;
  double? _mmfValue;

  // Withdrawal amount
  double? _withdrawalAmount;

  // Getters
  double? get sharesValue => _sharesValue;
  double? get bondsValue => _bondsValue;
  double? get mmfValue => _mmfValue;
  double? get withdrawalAmount => _withdrawalAmount;

  // Get value of the Imali funds
  Future<void> getPortfolioValues() async {
    _sharesValue = 1200.01;
    _bondsValue = 450.14;
    _mmfValue = 341.22;
  }

  // Get user amount to be withdrawn
  Future<void> getWithdrawalAmount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _withdrawalAmount = pref.getDouble('amountOfAssetWithdrawn');
    notifyListeners();
  }
}

enum InvestmentType {
  shares,
  bonds,
  mmf,
}

final List<Portfolio> portfolioItems = [
  Portfolio('Imali MMF', InvestmentType.mmf, 751.00, -0.07),
  Portfolio('Global MMF', InvestmentType.mmf, 726.00, 0.07),
  Portfolio('Imali Bonds', InvestmentType.bonds, 200.00, 0.80),
  Portfolio('KCB', InvestmentType.shares, 350.00, -0.08),
  Portfolio('Co-operative Bank', InvestmentType.shares, 120.00, 1.80),
  Portfolio('Standard Chartered', InvestmentType.shares, 89.76, 19.80),
  Portfolio('National Bond', InvestmentType.bonds, 751.00, -0.07),
  Portfolio('Federal Bond', InvestmentType.bonds, 200.00, 0.80),
];
