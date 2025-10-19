import 'package:flutter/material.dart';

enum InvestmentType {
  etfWorld,
  etfLeveraged2x,
  etfLeveraged3x,
  etfSri,
  etfClimate,
  crypto,
  stock,
  regionalEtf,
}

enum RiskTier {
  best, // Green - Recommended
  good, // Yellow - Acceptable with values
  risky, // Orange - Higher risk
  speculative, // Red - Speculative/gambling
}

class InvestmentOption {
  final String name;
  final String ticker;
  final String description;
  final InvestmentType type;
  final RiskTier tier;
  final String riskExplanation;
  final String? region;
  final double? leverageMultiplier;

  const InvestmentOption({
    required this.name,
    required this.ticker,
    required this.description,
    required this.type,
    required this.tier,
    required this.riskExplanation,
    this.region,
    this.leverageMultiplier,
  });

  Color get tierColor {
    switch (tier) {
      case RiskTier.best:
        return const Color(0xFF4CAF50); // Green
      case RiskTier.good:
        return const Color(0xFFFFC107); // Yellow
      case RiskTier.risky:
        return const Color(0xFFFF9800); // Orange
      case RiskTier.speculative:
        return const Color(0xFFF44336); // Red
    }
  }

  String get tierLabel {
    switch (tier) {
      case RiskTier.best:
        return 'Recommended';
      case RiskTier.good:
        return 'Values-aligned';
      case RiskTier.risky:
        return 'Higher Risk';
      case RiskTier.speculative:
        return 'Speculative';
    }
  }

  IconData get tierIcon {
    switch (tier) {
      case RiskTier.best:
        return Icons.check_circle;
      case RiskTier.good:
        return Icons.eco;
      case RiskTier.risky:
        return Icons.warning;
      case RiskTier.speculative:
        return Icons.casino;
    }
  }
}
