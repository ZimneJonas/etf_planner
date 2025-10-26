import 'package:flutter/material.dart';
import '../models/investment_option.dart';

class PortfolioSummaryBar extends StatelessWidget {
  final int selectedCount;
  final List<InvestmentOption> selectedOptions;
  final VoidCallback onGeneratePortfolio;

  const PortfolioSummaryBar({
    super.key,
    required this.selectedCount,
    required this.selectedOptions,
    required this.onGeneratePortfolio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Selected Options Preview
            if (selectedCount > 0) ...[
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$selectedCount option${selectedCount == 1 ? '' : 's'} selected',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: selectedOptions.take(3).map(
                          (option) => Container(
                            margin: const EdgeInsets.only(left: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: option.tierColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  option.tierIcon,
                                  size: 12,
                                  color: option.tierColor,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  option.name.split(' ').first,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: option.tierColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            // Generate Portfolio Button
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: selectedCount > 0 ? onGeneratePortfolio : null,
                icon: const Icon(Icons.pie_chart),
                label: Text(
                  selectedCount == 0
                      ? 'Select at least one option'
                      : 'Generate Portfolio',
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: selectedCount > 0
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
