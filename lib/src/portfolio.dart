class Portfolio {
  String assetName;
  String assetType;
  double assetValue;
  double changePercentage;
  Portfolio(this.assetName, this.assetType, this.assetValue, this.changePercentage);
}

List<Portfolio> portfolioItems = [
  Portfolio('Imali MMF', 'MMF', 751.00, -0.07),
  Portfolio('Global MMF', 'MMF', 726.00, 0.07),
  Portfolio('Imali Bonds', 'Bond', 200.00, 0.80),
  Portfolio('KCB', 'Share', 350.00, -0.08),
  Portfolio('Co-operative Bank', 'Shares', 120.00, 1.80),
  Portfolio('Standard Chartered', 'Shares', 89.76, 19.80),
  Portfolio('National Bond', 'Bond', 751.00, -0.07),
  Portfolio('Federal Bond', 'Bond', 200.00, 0.80),
];
