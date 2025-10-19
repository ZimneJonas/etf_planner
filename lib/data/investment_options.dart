import '../models/investment_option.dart';

class InvestmentOptionsDatabase {
  static const List<InvestmentOption> options = [
    // Tier 1 - Green (Recommended)
    InvestmentOption(
      name: 'iShares Core MSCI World UCITS ETF',
      ticker: 'IWDA',
      description:
          'Diversified global equity exposure tracking MSCI World Index',
      type: InvestmentType.etfWorld,
      tier: RiskTier.best,
      riskExplanation:
          'Broad diversification across developed markets. Low cost, scientifically proven optimal baseline.',
      region: 'Global',
    ),
    InvestmentOption(
      name: 'SPDR MSCI World UCITS ETF',
      ticker: 'SWRD',
      description: 'Low-cost global equity ETF tracking MSCI World Index',
      type: InvestmentType.etfWorld,
      tier: RiskTier.best,
      riskExplanation:
          'Excellent diversification with very low expense ratio. Ideal foundation for any portfolio.',
      region: 'Global',
    ),
    InvestmentOption(
      name: 'Vanguard Total World Stock ETF',
      ticker: 'VT',
      description:
          'Complete global stock market exposure including emerging markets',
      type: InvestmentType.etfWorld,
      tier: RiskTier.best,
      riskExplanation:
          'Most comprehensive global diversification including emerging markets. Vanguard\'s low-cost approach.',
      region: 'Global',
    ),
    InvestmentOption(
      name: 'Vanguard FTSE All-World UCITS ETF',
      ticker: 'VWRL',
      description: 'All-world equity exposure with dividend distribution',
      type: InvestmentType.etfWorld,
      tier: RiskTier.best,
      riskExplanation:
          'Broad global diversification with dividend income. Suitable for income-focused investors.',
      region: 'Global',
    ),

    // Tier 2 - Yellow (SRI/Climate-aligned)
    InvestmentOption(
      name: 'iShares MSCI World SRI UCITS ETF',
      ticker: 'ISFE',
      description: 'Socially responsible global equity exposure',
      type: InvestmentType.etfSri,
      tier: RiskTier.good,
      riskExplanation:
          'Screens for companies with strong ESG practices. Slightly higher costs but aligned with values.',
      region: 'Global',
    ),
    InvestmentOption(
      name: 'Lyxor MSCI World Climate Change ESG Filtered UCITS ETF',
      ticker: 'WPAE',
      description: 'Paris-aligned climate-focused global equity ETF',
      type: InvestmentType.etfClimate,
      tier: RiskTier.good,
      riskExplanation:
          'Focuses on companies aligned with Paris Agreement goals. Higher costs but climate impact.',
      region: 'Global',
    ),
    InvestmentOption(
      name: 'iShares ESG MSCI World UCITS ETF',
      ticker: 'IWDA',
      description: 'ESG-screened global equity exposure',
      type: InvestmentType.etfSri,
      tier: RiskTier.good,
      riskExplanation:
          'Environmental, social, and governance screening. Moderate additional costs for values alignment.',
      region: 'Global',
    ),

    // Tier 3 - Orange (Moderate Leverage/Regional)
    InvestmentOption(
      name: 'ProShares Ultra S&P 500',
      ticker: 'SSO',
      description: '2x leveraged exposure to S&P 500',
      type: InvestmentType.etfLeveraged2x,
      tier: RiskTier.risky,
      riskExplanation:
          '2x leverage amplifies both gains and losses. Higher volatility and decay risk.',
      region: 'US',
      leverageMultiplier: 2.0,
    ),
    InvestmentOption(
      name: 'ProShares Ultra QQQ',
      ticker: 'QLD',
      description: '2x leveraged exposure to NASDAQ-100',
      type: InvestmentType.etfLeveraged2x,
      tier: RiskTier.risky,
      riskExplanation:
          '2x leverage on tech-heavy index. High volatility with potential for significant losses.',
      region: 'US',
      leverageMultiplier: 2.0,
    ),
    InvestmentOption(
      name: 'iShares MSCI Emerging Markets UCITS ETF',
      ticker: 'EIMI',
      description: 'Emerging markets equity exposure',
      type: InvestmentType.regionalEtf,
      tier: RiskTier.risky,
      riskExplanation:
          'Higher volatility and political risk compared to developed markets. Currency exposure.',
      region: 'Emerging Markets',
    ),
    InvestmentOption(
      name: 'iShares Core MSCI Europe UCITS ETF',
      ticker: 'IMEU',
      description: 'European equity market exposure',
      type: InvestmentType.regionalEtf,
      tier: RiskTier.risky,
      riskExplanation:
          'Regional concentration risk. Lower diversification than global funds.',
      region: 'Europe',
    ),

    // Tier 4 - Red (Speculative/Gambling)
    InvestmentOption(
      name: 'ProShares UltraPro S&P 500',
      ticker: 'UPRO',
      description: '3x leveraged exposure to S&P 500',
      type: InvestmentType.etfLeveraged3x,
      tier: RiskTier.speculative,
      riskExplanation:
          '3x leverage is extremely risky. High volatility, decay risk, and potential for total loss.',
      region: 'US',
      leverageMultiplier: 3.0,
    ),
    InvestmentOption(
      name: 'ProShares UltraPro QQQ',
      ticker: 'TQQQ',
      description: '3x leveraged exposure to NASDAQ-100',
      type: InvestmentType.etfLeveraged3x,
      tier: RiskTier.speculative,
      riskExplanation:
          '3x leverage on volatile tech index. Extremely high risk of significant losses.',
      region: 'US',
      leverageMultiplier: 3.0,
    ),
    InvestmentOption(
      name: 'Bitcoin',
      ticker: 'BTC',
      description: 'Cryptocurrency - digital asset with extreme volatility',
      type: InvestmentType.crypto,
      tier: RiskTier.speculative,
      riskExplanation:
          'Extremely volatile digital asset. No intrinsic value, regulatory risk, and high speculation.',
      region: 'Global',
    ),
    InvestmentOption(
      name: 'Ethereum',
      ticker: 'ETH',
      description: 'Cryptocurrency and blockchain platform',
      type: InvestmentType.crypto,
      tier: RiskTier.speculative,
      riskExplanation:
          'Digital asset with utility but extreme volatility. Regulatory and technological risks.',
      region: 'Global',
    ),
    InvestmentOption(
      name: 'Tesla Inc.',
      ticker: 'TSLA',
      description: 'Electric vehicle and clean energy company',
      type: InvestmentType.stock,
      tier: RiskTier.speculative,
      riskExplanation:
          'Individual stock risk. High volatility, concentration risk, and company-specific risks.',
      region: 'US',
    ),
    InvestmentOption(
      name: 'Apple Inc.',
      ticker: 'AAPL',
      description: 'Technology company and consumer electronics',
      type: InvestmentType.stock,
      tier: RiskTier.speculative,
      riskExplanation:
          'Individual stock risk despite being large-cap. Concentration risk and company-specific factors.',
      region: 'US',
    ),
  ];

  static List<InvestmentOption> getOptionsByTier(RiskTier tier) {
    return options.where((option) => option.tier == tier).toList();
  }

  static List<InvestmentOption> getOptionsByType(InvestmentType type) {
    return options.where((option) => option.type == type).toList();
  }

  static List<InvestmentOption> getAllTierOptions() {
    return options;
  }

  static InvestmentOption? getOptionByTicker(String ticker) {
    try {
      return options.firstWhere((option) => option.ticker == ticker);
    } catch (e) {
      return null;
    }
  }
}
