import 'investment_option.dart';
import 'investment_preference.dart';

class PortfolioAllocation {
  final InvestmentOption option;
  final double percentage;

  const PortfolioAllocation({required this.option, required this.percentage});

  PortfolioAllocation copyWith({InvestmentOption? option, double? percentage}) {
    return PortfolioAllocation(
      option: option ?? this.option,
      percentage: percentage ?? this.percentage,
    );
  }
}

class Portfolio {
  final List<PortfolioAllocation> allocations;
  final InvestmentPreference preference;

  const Portfolio({required this.allocations, required this.preference});

  Portfolio copyWith({
    List<PortfolioAllocation>? allocations,
    InvestmentPreference? preference,
  }) {
    return Portfolio(
      allocations: allocations ?? this.allocations,
      preference: preference ?? this.preference,
    );
  }

  double get totalPercentage {
    return allocations.fold(
      0.0,
      (sum, allocation) => sum + allocation.percentage,
    );
  }

  bool get isValid {
    return (totalPercentage - 100.0).abs() < 0.1; // Allow small rounding errors
  }

  List<PortfolioAllocation> get allocationsByTier {
    final sorted = List<PortfolioAllocation>.from(allocations);
    sorted.sort((a, b) => a.option.tier.index.compareTo(b.option.tier.index));
    return sorted;
  }

  double getPercentageForTier(RiskTier tier) {
    return allocations
        .where((allocation) => allocation.option.tier == tier)
        .fold(0.0, (sum, allocation) => sum + allocation.percentage);
  }

  bool hasTier(RiskTier tier) {
    return allocations.any((allocation) => allocation.option.tier == tier);
  }

  List<PortfolioAllocation> get allocationsForTier {
    return allocationsByTier;
  }
}
