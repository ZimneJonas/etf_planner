import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ETF Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const InvestmentHorizonScreen(),
    );
  }
}

class InvestmentHorizonScreen extends StatefulWidget {
  const InvestmentHorizonScreen({super.key});

  @override
  State<InvestmentHorizonScreen> createState() =>
      _InvestmentHorizonScreenState();
}

class _InvestmentHorizonScreenState extends State<InvestmentHorizonScreen> {
  double _investmentYears = 5;
  bool _showRecommendation = false;

  String get _recommendation {
    if (_investmentYears > 5) {
      return 'MSCI World ETF';
    } else {
      return 'Daily Interest-Bearing Account';
    }
  }

  String get _recommendationDescription {
    if (_investmentYears > 5) {
      return 'With an investment horizon of ${_investmentYears.toInt()} years, you have enough time to weather market volatility. An MSCI World ETF provides global diversification and historically strong returns over the long term.';
    } else {
      return 'With an investment horizon of ${_investmentYears.toInt()} years or less, it\'s safer to avoid market volatility. A daily interest-bearing account provides stability and guaranteed returns for your short-term goals.';
    }
  }

  IconData get _recommendationIcon {
    if (_investmentYears > 5) {
      return Icons.trending_up;
    } else {
      return Icons.savings;
    }
  }

  Color get _recommendationColor {
    if (_investmentYears > 5) {
      return Colors.green;
    } else {
      return Colors.blue;
    }
  }

  void _calculateRecommendation() {
    setState(() {
      _showRecommendation = true;
    });
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
                                _showRecommendation = false;
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

                          // Get Recommendation Button
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: _calculateRecommendation,
                              icon: const Icon(Icons.lightbulb_outline),
                              label: const Text('Get Recommendation'),
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

                  // Recommendation Card (shown after clicking button)
                  if (_showRecommendation) ...[
                    const SizedBox(height: 24),
                    Card(
                      color: _recommendationColor.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Icon(
                              _recommendationIcon,
                              size: 64,
                              color: _recommendationColor,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Our Recommendation',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.6),
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _recommendation,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: _recommendationColor,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _recommendationDescription,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
