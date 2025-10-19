class InvestmentPreference {
  final int investmentHorizonYears;
  final int riskAcceptance; // 1-10 scale

  const InvestmentPreference({
    required this.investmentHorizonYears,
    required this.riskAcceptance,
  });

  InvestmentPreference copyWith({
    int? investmentHorizonYears,
    int? riskAcceptance,
  }) {
    return InvestmentPreference(
      investmentHorizonYears:
          investmentHorizonYears ?? this.investmentHorizonYears,
      riskAcceptance: riskAcceptance ?? this.riskAcceptance,
    );
  }

  String get riskDescription {
    if (riskAcceptance <= 3) {
      return 'Conservative';
    } else if (riskAcceptance <= 6) {
      return 'Moderate';
    } else if (riskAcceptance <= 8) {
      return 'Aggressive';
    } else {
      return 'Very Aggressive';
    }
  }

  String get horizonDescription {
    if (investmentHorizonYears <= 2) {
      return 'Short-term';
    } else if (investmentHorizonYears <= 5) {
      return 'Medium-term';
    } else if (investmentHorizonYears <= 10) {
      return 'Long-term';
    } else {
      return 'Very long-term';
    }
  }
}
