import 'package:flutter/material.dart';
import '../models/investment_preference.dart';

class RiskInputScreen extends StatefulWidget {
  final InvestmentPreference preference;

  const RiskInputScreen({super.key, required this.preference});

  @override
  State<RiskInputScreen> createState() => _RiskInputScreenState();
}

class _RiskInputScreenState extends State<RiskInputScreen> {
  late double _riskAcceptance;

  @override
  void initState() {
    super.initState();
    _riskAcceptance = widget.preference.riskAcceptance.toDouble();
  }

  InvestmentPreference get _updatedPreference {
    return widget.preference.copyWith(riskAcceptance: _riskAcceptance.round());
  }

  String get _riskDescription {
    if (_riskAcceptance <= 3) {
      return 'Conservative';
    } else if (_riskAcceptance <= 6) {
      return 'Moderate';
    } else if (_riskAcceptance <= 8) {
      return 'Aggressive';
    } else {
      return 'Very Aggressive';
    }
  }

  String get _riskExplanation {
    if (_riskAcceptance <= 3) {
      return 'You prefer stability and are willing to accept lower returns for reduced volatility.';
    } else if (_riskAcceptance <= 6) {
      return 'You\'re comfortable with moderate volatility in exchange for potentially higher returns.';
    } else if (_riskAcceptance <= 8) {
      return 'You\'re willing to accept significant volatility for the potential of higher returns.';
    } else {
      return 'You\'re comfortable with high volatility and potential for significant losses in pursuit of maximum returns.';
    }
  }

  Color get _riskColor {
    if (_riskAcceptance <= 3) {
      return Colors.green;
    } else if (_riskAcceptance <= 6) {
      return Colors.orange;
    } else if (_riskAcceptance <= 8) {
      return Colors.red;
    } else {
      return Colors.deepPurple;
    }
  }

  IconData get _riskIcon {
    if (_riskAcceptance <= 3) {
      return Icons.shield;
    } else if (_riskAcceptance <= 6) {
      return Icons.trending_up;
    } else if (_riskAcceptance <= 8) {
      return Icons.speed;
    } else {
      return Icons.flash_on;
    }
  }

  void _proceedToOptionSelection() {
    Navigator.pushNamed(
      context,
      '/option-selection',
      arguments: _updatedPreference,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header
                  Icon(
                    Icons.psychology,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Risk Acceptance',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'How comfortable are you with investment volatility?',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  // Risk Input Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Risk Tolerance Scale',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Rate your comfort level with investment volatility',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.6),
                                ),
                          ),
                          const SizedBox(height: 32),

                          // Risk Level Display
                          Center(
                            child: Column(
                              children: [
                                Icon(_riskIcon, size: 64, color: _riskColor),
                                const SizedBox(height: 16),
                                Text(
                                  _riskDescription,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: _riskColor,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Level ${_riskAcceptance.round()}',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.6),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Slider
                          Slider(
                            value: _riskAcceptance,
                            min: 1,
                            max: 10,
                            divisions: 9,
                            label: 'Level ${_riskAcceptance.round()}',
                            activeColor: _riskColor,
                            onChanged: (value) {
                              setState(() {
                                _riskAcceptance = value;
                              });
                            },
                          ),

                          // Slider Labels
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Conservative',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      '1',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.5),
                                          ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Very Aggressive',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      '10',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.5),
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Risk Explanation
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _riskColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _riskColor.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: _riskColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _riskExplanation,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: _riskColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Continue Button
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: _proceedToOptionSelection,
                              icon: const Icon(Icons.arrow_forward),
                              label: const Text(
                                'Continue to Investment Options',
                              ),
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                backgroundColor: _riskColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
