import 'package:flutter/material.dart';

enum InvestmentType {
  globalIndex,
  leveraged2x,
  leveraged3x,
  sriIndex,
  climateIndex,
  crypto,
  individualStock,
  regionalIndex,
}

enum RiskTier {
  best, // Green - Recommended
  good, // Yellow - Acceptable with values
  risky, // Orange - Higher risk
  speculative, // Red - Speculative/gambling
}

class InvestmentExample {
  final String name;
  final String ticker;
  final String description;

  const InvestmentExample({
    required this.name,
    required this.ticker,
    required this.description,
  });
}

class InvestmentOption {
  final String name;
  final String categoryId;
  final String description;
  final InvestmentType type;
  final RiskTier tier;
  final String riskExplanation;
  final String? region;
  final double? leverageMultiplier;
  final List<InvestmentExample> examples;
  final List<String> scientificReferences;

  const InvestmentOption({
    required this.name,
    required this.categoryId,
    required this.description,
    required this.type,
    required this.tier,
    required this.riskExplanation,
    this.region,
    this.leverageMultiplier,
    required this.examples,
    required this.scientificReferences,
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
