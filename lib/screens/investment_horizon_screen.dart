import 'package:flutter/material.dart';
import '../models/investment_preference.dart';

class InvestmentHorizonScreen extends StatefulWidget {
  const InvestmentHorizonScreen({super.key});

  @override
  State<InvestmentHorizonScreen> createState() =>
      _InvestmentHorizonScreenState();
}

class _InvestmentHorizonScreenState extends State<InvestmentHorizonScreen> {
  double _investmentYears = 5;

  InvestmentPreference get _preference {
    return InvestmentPreference(
      investmentHorizonYears: _investmentYears.toInt(),
      riskAcceptance: 5, // Default, will be updated in next screen
    );
  }

  void _proceedToRiskInput() {
    Navigator.pushNamed(
      context,
      '/risk-input',
      arguments: _preference,
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
                    Icons.account_balance,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'ETF Planner',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Let\'s find the right investment for you',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  // Question Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What is your investment horizon?',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'How many years do you plan to invest?',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.6),
                                ),
                          ),
                          const SizedBox(height: 32),

                          // Years Display
                          Center(
                            child: Text(
                              '${_investmentYears.toInt()} ${_investmentYears.toInt() == 1 ? 'year' : 'years'}',
                              style: Theme.of(context).textTheme.displaySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Slider
                          Slider(
                            value: _investmentYears,
                            min: 1,
                            max: 30,
                            divisions: 29,
                            label: '${_investmentYears.toInt()} years',
                            onChanged: (value) {
                              setState(() {
                                _investmentYears = value;
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
                                Text(
                                  '1 year',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.5),
                                      ),
                                ),
                                Text(
                                  '30 years',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.5),
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
                              onPressed: _proceedToRiskInput,
                              icon: const Icon(Icons.arrow_forward),
                              label: const Text('Continue'),
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
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
