import 'package:flutter/material.dart';
import '../models/investment_option.dart';
import '../models/investment_preference.dart';
import '../data/investment_options.dart';
import '../widgets/investment_option_card.dart';
import '../widgets/portfolio_summary_bar.dart';

class OptionSelectionScreen extends StatefulWidget {
  final InvestmentPreference preference;

  const OptionSelectionScreen({super.key, required this.preference});

  @override
  State<OptionSelectionScreen> createState() => _OptionSelectionScreenState();
}

class _OptionSelectionScreenState extends State<OptionSelectionScreen> {
  final Set<String> _selectedCategories = <String>{};

  List<InvestmentOption> get _selectedOptions {
    return InvestmentOptionsDatabase.options
        .where((option) => _selectedCategories.contains(option.categoryId))
        .toList();
  }

  void _toggleSelection(InvestmentOption option) {
    setState(() {
      if (_selectedCategories.contains(option.categoryId)) {
        _selectedCategories.remove(option.categoryId);
      } else {
        _selectedCategories.add(option.categoryId);
      }
    });
  }

  void _generatePortfolio() {
    if (_selectedOptions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one investment option'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pushNamed(
      context,
      '/portfolio-result',
      arguments: {
        'preference': widget.preference,
        'selectedOptions': _selectedOptions,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Investments'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Choose Your Investments',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Select options that match your risk tolerance',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // Risk Summary
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Risk Level: ${widget.preference.riskDescription} (${widget.preference.riskAcceptance}/10)',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Options List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: InvestmentOptionsDatabase.options.length,
              itemBuilder: (context, index) {
                final option = InvestmentOptionsDatabase.options[index];
                return InvestmentOptionCard(
                  option: option,
                  isSelected: _selectedCategories.contains(option.categoryId),
                  onToggleSelection: () => _toggleSelection(option),
                );
              },
            ),
          ),

          // Summary Bar
          PortfolioSummaryBar(
            selectedCount: _selectedOptions.length,
            selectedOptions: _selectedOptions,
            onGeneratePortfolio: _generatePortfolio,
          ),
        ],
      ),
    );
  }
}
