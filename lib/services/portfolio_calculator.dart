import '../models/investment_option.dart';
import '../models/investment_preference.dart';
import '../models/portfolio.dart';

class PortfolioCalculator {
  // Risk-to-safe-percentage mapping
  static const Map<int, double> _riskToSafePercentage = {
    1: 0.95, // 95% safe
    2: 0.90, // 90% safe
    3: 0.85, // 85% safe
    4: 0.80, // 80% safe
    5: 0.70, // 70% safe
    6: 0.60, // 60% safe
    7: 0.50, // 50% safe
    8: 0.40, // 40% safe
    9: 0.30, // 30% safe
    10: 0.20, // 20% safe
  };

  // Tier weight multipliers for allocation
  static const Map<RiskTier, double> _tierWeights = {
    RiskTier.best: 1.0,
    RiskTier.good: 0.8,
    RiskTier.risky: 0.6,
    RiskTier.speculative: 0.4,
  };

  static Portfolio calculatePortfolio({
    required List<InvestmentOption> selectedOptions,
    required InvestmentPreference preference,
  }) {
    if (selectedOptions.isEmpty) {
      throw ArgumentError('At least one investment option must be selected');
    }

    // If only Tier 1 (best) options selected, allocate 100% to them
    final tier1Options = selectedOptions
        .where((opt) => opt.tier == RiskTier.best)
        .toList();
    if (tier1Options.length == selectedOptions.length) {
      return _allocateEqually(tier1Options, preference);
    }

    // Calculate base safe percentage based on risk acceptance
    final safePercentage =
        _riskToSafePercentage[preference.riskAcceptance] ?? 0.5;

    // Group selected options by tier
    final optionsByTier = <RiskTier, List<InvestmentOption>>{};
    for (final tier in RiskTier.values) {
      optionsByTier[tier] = selectedOptions
          .where((opt) => opt.tier == tier)
          .toList();
    }

    // Calculate allocations
    final allocations = <PortfolioAllocation>[];
    double remainingPercentage = 100.0;

    // Allocate to Tier 1 (best) options first
    if (optionsByTier[RiskTier.best]!.isNotEmpty) {
      final tier1Allocation = safePercentage * 100;
      final perOptionAllocation =
          tier1Allocation / optionsByTier[RiskTier.best]!.length;

      for (final option in optionsByTier[RiskTier.best]!) {
        allocations.add(
          PortfolioAllocation(option: option, percentage: perOptionAllocation),
        );
      }
      remainingPercentage -= tier1Allocation;
    }

    // Distribute remaining percentage to other tiers
    final otherTiers = [RiskTier.good, RiskTier.risky, RiskTier.speculative];

    for (final tier in otherTiers) {
      if (optionsByTier[tier]!.isNotEmpty && remainingPercentage > 0) {
        final tierWeight = _tierWeights[tier]!;
        final tierAllocation = remainingPercentage * tierWeight;
        final perOptionAllocation =
            tierAllocation / optionsByTier[tier]!.length;

        for (final option in optionsByTier[tier]!) {
          allocations.add(
            PortfolioAllocation(
              option: option,
              percentage: perOptionAllocation,
            ),
          );
        }
        remainingPercentage -= tierAllocation;
      }
    }

    // Normalize to ensure total is 100%
    final total = allocations.fold(0.0, (sum, alloc) => sum + alloc.percentage);
    if (total != 100.0) {
      final factor = 100.0 / total;
      for (int i = 0; i < allocations.length; i++) {
        allocations[i] = PortfolioAllocation(
          option: allocations[i].option,
          percentage: allocations[i].percentage * factor,
        );
      }
    }

    return Portfolio(allocations: allocations, preference: preference);
  }

  static Portfolio _allocateEqually(
    List<InvestmentOption> options,
    InvestmentPreference preference,
  ) {
    final perOptionPercentage = 100.0 / options.length;
    final allocations = options
        .map(
          (option) => PortfolioAllocation(
            option: option,
            percentage: perOptionPercentage,
          ),
        )
        .toList();

    return Portfolio(allocations: allocations, preference: preference);
  }

  static Portfolio adjustAllocation({
    required Portfolio portfolio,
    required InvestmentOption option,
    required double newPercentage,
  }) {
    final allocations = List<PortfolioAllocation>.from(portfolio.allocations);

    // Find and update the allocation for the specified option
    for (int i = 0; i < allocations.length; i++) {
      if (allocations[i].option.ticker == option.ticker) {
        allocations[i] = PortfolioAllocation(
          option: option,
          percentage: newPercentage,
        );
        break;
      }
    }

    // Normalize other allocations to maintain 100% total
    final total = allocations.fold(0.0, (sum, alloc) => sum + alloc.percentage);
    if (total != 100.0) {
      final otherAllocations = allocations
          .where((alloc) => alloc.option.ticker != option.ticker)
          .toList();
      if (otherAllocations.isNotEmpty) {
        final remainingPercentage = 100.0 - newPercentage;
        final factor =
            remainingPercentage /
            otherAllocations.fold(0.0, (sum, alloc) => sum + alloc.percentage);

        for (int i = 0; i < allocations.length; i++) {
          if (allocations[i].option.ticker != option.ticker) {
            allocations[i] = PortfolioAllocation(
              option: allocations[i].option,
              percentage: allocations[i].percentage * factor,
            );
          }
        }
      }
    }

    return Portfolio(
      allocations: allocations,
      preference: portfolio.preference,
    );
  }

  static String getRiskAssessment(Portfolio portfolio) {
    final speculativePercentage = portfolio.getPercentageForTier(
      RiskTier.speculative,
    );
    final riskyPercentage = portfolio.getPercentageForTier(RiskTier.risky);
    final totalRiskyPercentage = speculativePercentage + riskyPercentage;

    if (totalRiskyPercentage > 50) {
      return 'Very High Risk - Consider reducing speculative and leveraged positions';
    } else if (totalRiskyPercentage > 30) {
      return 'High Risk - Monitor leveraged positions closely';
    } else if (totalRiskyPercentage > 15) {
      return 'Moderate Risk - Balanced approach with some leverage';
    } else {
      return 'Low Risk - Conservative, diversified approach';
    }
  }

  static List<String> getRecommendations(Portfolio portfolio) {
    final recommendations = <String>[];

    if (portfolio.hasTier(RiskTier.speculative)) {
      recommendations.add('⚠️ Speculative investments carry high risk of loss');
    }

    if (portfolio.hasTier(RiskTier.risky)) {
      recommendations.add(
        '📈 Leveraged ETFs amplify volatility - monitor closely',
      );
    }

    if (!portfolio.hasTier(RiskTier.best)) {
      recommendations.add(
        '💡 Consider adding diversified world ETFs as foundation',
      );
    }

    if (portfolio.preference.investmentHorizonYears < 5 &&
        portfolio.hasTier(RiskTier.risky)) {
      recommendations.add('⏰ Short horizon with leveraged products is risky');
    }

    return recommendations;
  }
}
