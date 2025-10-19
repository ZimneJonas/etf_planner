import 'package:flutter/material.dart';
import 'models/investment_preference.dart';
import 'models/investment_option.dart';
import 'screens/investment_horizon_screen.dart';
import 'screens/risk_input_screen.dart';
import 'screens/option_selection_screen.dart';
import 'screens/portfolio_result_screen.dart';

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
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const InvestmentHorizonScreen(),
        '/risk-input': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as InvestmentPreference?;
          return RiskInputScreen(
            preference:
                args ??
                const InvestmentPreference(
                  investmentHorizonYears: 5,
                  riskAcceptance: 5,
                ),
          );
        },
        '/option-selection': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as InvestmentPreference?;
          return OptionSelectionScreen(
            preference:
                args ??
                const InvestmentPreference(
                  investmentHorizonYears: 5,
                  riskAcceptance: 5,
                ),
          );
        },
        '/portfolio-result': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>?;
          if (args == null) {
            return const Scaffold(
              body: Center(child: Text('Error: No portfolio data')),
            );
          }
          return PortfolioResultScreen(
            preference: args['preference'] as InvestmentPreference,
            selectedOptions: args['selectedOptions'] as List<InvestmentOption>,
          );
        },
      },
    );
  }
}
