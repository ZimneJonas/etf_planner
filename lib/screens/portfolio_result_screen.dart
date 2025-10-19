import 'package:flutter/material.dart';
import '../models/investment_option.dart';
import '../models/investment_preference.dart';
import '../models/portfolio.dart';
import '../services/portfolio_calculator.dart';
import '../widgets/portfolio_pie_chart.dart';
import '../widgets/allocation_slider.dart';

class PortfolioResultScreen extends StatefulWidget {
  final InvestmentPreference preference;
  final List<InvestmentOption> selectedOptions;

  const PortfolioResultScreen({
    super.key,
    required this.preference,
    required this.selectedOptions,
  });

  @override
  State<PortfolioResultScreen> createState() => _PortfolioResultScreenState();
}

class _PortfolioResultScreenState extends State<PortfolioResultScreen> {
  late Portfolio _portfolio;
  bool _showManualAdjustment = false;

  @override
  void initState() {
    super.initState();
    _portfolio = PortfolioCalculator.calculatePortfolio(
      selectedOptions: widget.selectedOptions,
      preference: widget.preference,
    );
  }

  void _updatePortfolio(Portfolio newPortfolio) {
    setState(() {
      _portfolio = newPortfolio;
    });
  }

  void _toggleManualAdjustment() {
    setState(() {
      _showManualAdjustment = !_showManualAdjustment;
    });
  }

  @override
  Widget build(BuildContext context) {
    final riskAssessment = PortfolioCalculator.getRiskAssessment(_portfolio);
    final recommendations = PortfolioCalculator.getRecommendations(_portfolio);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Portfolio'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(_showManualAdjustment ? Icons.visibility_off : Icons.tune),
            onPressed: _toggleManualAdjustment,
            tooltip: _showManualAdjustment ? 'Hide Manual Adjustment' : 'Show Manual Adjustment',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Portfolio Overview Card
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Portfolio Chart
                    Center(
                      child: PortfolioPieChart(
                        portfolio: _portfolio,
                        size: 250,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Portfolio Legend
                    PortfolioLegend(portfolio: _portfolio),
                    const SizedBox(height: 24),

                    // Risk Assessment
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _getRiskColor(riskAssessment).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _getRiskColor(riskAssessment).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.assessment,
                            color: _getRiskColor(riskAssessment),
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Risk Assessment',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: _getRiskColor(riskAssessment),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  riskAssessment,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: _getRiskColor(riskAssessment),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Recommendations
            if (recommendations.isNotEmpty) ...[
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Recommendations',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...recommendations.map((recommendation) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    recommendation,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],

            // Manual Adjustment Section
            if (_showManualAdjustment) ...[
              const SizedBox(height: 16),
              AllocationList(
                portfolio: _portfolio,
                onPortfolioChanged: _updatePortfolio,
              ),
            ],

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        // TODO: Implement save/share functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Portfolio saved!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Save Portfolio'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false,
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Start Over'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRiskColor(String riskAssessment) {
    if (riskAssessment.contains('Very High')) {
      return Colors.red;
    } else if (riskAssessment.contains('High')) {
      return Colors.orange;
    } else if (riskAssessment.contains('Moderate')) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }
}
