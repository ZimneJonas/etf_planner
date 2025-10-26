import 'package:flutter/material.dart';
import '../models/investment_option.dart';
import '../models/portfolio.dart';
import '../services/portfolio_calculator.dart';

class AllocationSlider extends StatelessWidget {
  final PortfolioAllocation allocation;
  final ValueChanged<double> onChanged;
  final double remainingPercentage;

  const AllocationSlider({
    super.key,
    required this.allocation,
    required this.onChanged,
    required this.remainingPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                // Tier Color Indicator
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: allocation.option.tierColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                // Option Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allocation.option.name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Percentage Display
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: allocation.option.tierColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: allocation.option.tierColor.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    '${allocation.percentage.toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: allocation.option.tierColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Slider
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: allocation.option.tierColor,
                inactiveTrackColor: allocation.option.tierColor.withOpacity(
                  0.3,
                ),
                thumbColor: allocation.option.tierColor,
                overlayColor: allocation.option.tierColor.withOpacity(0.2),
                trackHeight: 4,
              ),
              child: Slider(
                value: allocation.percentage,
                min: 0.0,
                max: 100.0,
                divisions: 1000, // Allow 0.1% increments
                label: '${allocation.percentage.toStringAsFixed(1)}%',
                onChanged: onChanged,
              ),
            ),

            // Risk Warning for High-Risk Options
            if (allocation.option.tier.index >= RiskTier.risky.index) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: allocation.option.tierColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      allocation.option.tierIcon,
                      size: 16,
                      color: allocation.option.tierColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        allocation.option.riskExplanation,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: allocation.option.tierColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AllocationList extends StatelessWidget {
  final Portfolio portfolio;
  final ValueChanged<Portfolio> onPortfolioChanged;

  const AllocationList({
    super.key,
    required this.portfolio,
    required this.onPortfolioChanged,
  });

  void _updateAllocation(InvestmentOption option, double newPercentage) {
    final updatedPortfolio = PortfolioCalculator.adjustAllocation(
      portfolio: portfolio,
      option: option,
      newPercentage: newPercentage,
    );
    onPortfolioChanged(updatedPortfolio);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(
                Icons.tune,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Manual Adjustment',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              // Total Percentage Indicator
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: portfolio.isValid
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: portfolio.isValid
                        ? Colors.green.withOpacity(0.3)
                        : Colors.red.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  'Total: ${portfolio.totalPercentage.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: portfolio.isValid ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Allocation Sliders
        ...portfolio.allocationsByTier.map((allocation) {
          return AllocationSlider(
            allocation: allocation,
            onChanged: (value) => _updateAllocation(allocation.option, value),
            remainingPercentage: 100.0 - allocation.percentage,
          );
        }).toList(),

        // Reset Button
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                // Reset to recommended allocation
                final recommendedPortfolio =
                    PortfolioCalculator.calculatePortfolio(
                      selectedOptions: portfolio.allocations
                          .map((a) => a.option)
                          .toList(),
                      preference: portfolio.preference,
                    );
                onPortfolioChanged(recommendedPortfolio);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reset to Recommended'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
