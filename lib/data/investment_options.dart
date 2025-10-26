import '../models/investment_option.dart';

class InvestmentOptionsDatabase {
  static const List<InvestmentOption> options = [
    // Tier 1 - Green (Recommended)
    InvestmentOption(
      name: 'Global Index Fund',
      categoryId: 'global-index-fund',
      description: 'Low-cost, diversified exposure to global equity markets',
      type: InvestmentType.globalIndex,
      tier: RiskTier.best,
      riskExplanation:
          'Broad diversification across developed markets. Low cost, scientifically proven optimal baseline for long-term wealth building.',
      region: 'Global',
      examples: [
        InvestmentExample(
          name: 'iShares Core MSCI World UCITS ETF',
          ticker: 'IWDA',
          description: 'Diversified global equity exposure tracking MSCI World Index',
        ),
        InvestmentExample(
          name: 'SPDR MSCI World UCITS ETF',
          ticker: 'SWRD',
          description: 'Low-cost global equity ETF tracking MSCI World Index',
        ),
        InvestmentExample(
          name: 'Vanguard Total World Stock ETF',
          ticker: 'VT',
          description: 'Complete global stock market exposure including emerging markets',
        ),
        InvestmentExample(
          name: 'Vanguard FTSE All-World UCITS ETF',
          ticker: 'VWRL',
          description: 'All-world equity exposure with dividend distribution',
        ),
      ],
      scientificReferences: [
        'Merton, R. C. (1973). Theory of Rational Option Pricing. Bell Journal of Economics, 4(1), 141-183.',
        'Fama, E. F., & French, K. R. (1992). The Cross-Section of Expected Stock Returns. Journal of Finance, 47(2), 427-465.',
        'Bogle, J. C. (2015). The Little Book of Common Sense Investing. Wiley.',
      ],
    ),

    // Tier 2 - Yellow (SRI/Climate-aligned)
    InvestmentOption(
      name: 'Socially Responsible Index Fund',
      categoryId: 'sri-index-fund',
      description: 'ESG-screened global equity exposure',
      type: InvestmentType.sriIndex,
      tier: RiskTier.good,
      riskExplanation:
          'Environmental, social, and governance screening. Moderate additional costs for values alignment without significant performance trade-off.',
      region: 'Global',
      examples: [
        InvestmentExample(
          name: 'iShares MSCI World SRI UCITS ETF',
          ticker: 'ISFE',
          description: 'Socially responsible global equity exposure',
        ),
        InvestmentExample(
          name: 'iShares ESG MSCI World UCITS ETF',
          ticker: 'IWDA',
          description: 'ESG-screened global equity exposure',
        ),
      ],
      scientificReferences: [
        'Friede, G., Busch, T., & Bassen, A. (2015). ESG and financial performance: aggregated evidence from more than 2000 empirical studies. Journal of Sustainable Finance & Investment, 5(4), 210-233.',
        'Riedl, A., & Smeets, P. (2017). Why do investors hold socially responsible mutual funds? Journal of Finance, 72(6), 2505-2550.',
      ],
    ),
    InvestmentOption(
      name: 'Climate-Aligned Index Fund',
      categoryId: 'climate-index-fund',
      description: 'Paris Agreement aligned climate-focused global equity ETF',
      type: InvestmentType.climateIndex,
      tier: RiskTier.good,
      riskExplanation:
          'Focuses on companies aligned with Paris Agreement goals. Higher costs but climate impact. Suitable for investors prioritizing climate action.',
      region: 'Global',
      examples: [
        InvestmentExample(
          name: 'Lyxor MSCI World Climate Change ESG Filtered UCITS ETF',
          ticker: 'WPAE',
          description: 'Paris-aligned climate-focused global equity ETF',
        ),
      ],
      scientificReferences: [
        'Andersson, M., Bolton, P., & Samama, F. (2016). Hedging climate risk. Financial Analysts Journal, 72(3), 13-32.',
        'Bolton, P., & Kacperczyk, M. (2021). Do investors care about carbon risk? Journal of Financial Economics, 142(2), 517-549.',
      ],
    ),

    // Tier 3 - Orange (Moderate Leverage/Regional)
    InvestmentOption(
      name: 'Leveraged ETF (2x)',
      categoryId: 'leveraged-2x-etf',
      description: '2x leveraged equity exposure amplifying gains and losses',
      type: InvestmentType.leveraged2x,
      tier: RiskTier.risky,
      riskExplanation:
          '2x leverage amplifies both gains and losses. Higher volatility, decay risk from daily rebalancing, and potential for significant losses over time.',
      region: 'Various',
      leverageMultiplier: 2.0,
      examples: [], // No examples per user request
      scientificReferences: [
        'Shum, W. C., & Kang, J. (2013). Leveraged and inverse ETF performance during the financial crisis. Financial Review, 48(4), 671-694.',
        'Cheng, M., & Madhavan, A. (2009). The dynamics of leveraged and inverse exchange-traded funds. Journal of Investment Management, 7(4), 43-62.',
        'Avellaneda, M., & Zhang, S. (2010). Path-dependence of leveraged ETF returns. SIAM Journal of Financial Mathematics, 1(1), 586-603.',
      ],
    ),
    InvestmentOption(
      name: 'Regional Index Fund',
      categoryId: 'regional-index-fund',
      description: 'Regional equity market exposure with concentration risk',
      type: InvestmentType.regionalIndex,
      tier: RiskTier.risky,
      riskExplanation:
          'Higher volatility and concentration risk compared to global funds. Currency exposure adds additional risk. Lower diversification than global portfolios.',
      region: 'Various',
      examples: [
        InvestmentExample(
          name: 'iShares MSCI Emerging Markets UCITS ETF',
          ticker: 'EIMI',
          description: 'Emerging markets equity exposure',
        ),
        InvestmentExample(
          name: 'iShares Core MSCI Europe UCITS ETF',
          ticker: 'IMEU',
          description: 'European equity market exposure',
        ),
      ],
      scientificReferences: [
        'Errunza, V., & Losq, E. (1985). International asset pricing under mild segmentation: Theory and test. Journal of Finance, 40(1), 105-124.',
        'Merton, R. C. (1973). An intertemporal capital asset pricing model. Econometrica, 41(5), 867-887.',
      ],
    ),

    // Tier 4 - Red (Speculative/Gambling)
    InvestmentOption(
      name: 'Leveraged ETF (3x+)',
      categoryId: 'leveraged-3x-etf',
      description: '3x+ leveraged equity exposure with extreme volatility',
      type: InvestmentType.leveraged3x,
      tier: RiskTier.speculative,
      riskExplanation:
          '3x leverage is extremely risky. High volatility, severe decay risk, and potential for total loss even if underlying trend is favorable.',
      region: 'Various',
      leverageMultiplier: 3.0,
      examples: [], // No examples per user request
      scientificReferences: [
        'Shum, W. C., & Kang, J. (2013). Leveraged and inverse ETF performance during the financial crisis. Financial Review, 48(4), 671-694.',
        'Cheng, M., & Madhavan, A. (2009). The dynamics of leveraged and inverse exchange-traded funds. Journal of Investment Management, 7(4), 43-62.',
        'Simmons, G., & Lester, T. (2014). Leverage-induced volatility drag. Journal of Portfolio Management, 40(3), 86-97.',
      ],
    ),
    InvestmentOption(
      name: 'Cryptocurrency',
      categoryId: 'cryptocurrency',
      description: 'Digital assets with extreme volatility',
      type: InvestmentType.crypto,
      tier: RiskTier.speculative,
      riskExplanation:
          'Extremely volatile digital assets. No intrinsic value, regulatory risk, technological risks, and high speculation. Not suitable for most investors.',
      region: 'Global',
      examples: [
        InvestmentExample(
          name: 'Bitcoin',
          ticker: 'BTC',
          description: 'Cryptocurrency - digital asset with extreme volatility',
        ),
        InvestmentExample(
          name: 'Ethereum',
          ticker: 'ETH',
          description: 'Cryptocurrency and blockchain platform',
        ),
      ],
      scientificReferences: [
        'Baur, D. G., & Dimpfl, T. (2019). The volatility of Bitcoin and its role as a medium of exchange and a store of value. Empirical Economics, 56(4), 1285-1321.',
        'Cheah, E. T., & Fry, J. (2015). Speculative bubbles in Bitcoin markets? An empirical investigation into the fundamental value of Bitcoin. Economics Letters, 130, 32-36.',
        'Bouri, E., Molnár, P., Azzi, G., Roubaud, D., & Hagfors, L. I. (2017). On the hedge and safe haven properties of Bitcoin: Is it really more than a diversifier? Finance Research Letters, 20, 192-198.',
      ],
    ),
    InvestmentOption(
      name: 'Individual Stocks',
      categoryId: 'individual-stocks',
      description: 'Concentrated holdings in specific companies',
      type: InvestmentType.individualStock,
      tier: RiskTier.speculative,
      riskExplanation:
          'Individual stock risk. High volatility, concentration risk, and company-specific risks. Research shows stock pickers underperform diversified portfolios over long term.',
      region: 'Various',
      examples: [
        InvestmentExample(
          name: 'Tesla Inc.',
          ticker: 'TSLA',
          description: 'Electric vehicle and clean energy company',
        ),
        InvestmentExample(
          name: 'Apple Inc.',
          ticker: 'AAPL',
          description: 'Technology company and consumer electronics',
        ),
      ],
      scientificReferences: [
        'Fama, E. F., & French, K. R. (2010). Luck versus skill in the cross-section of mutual fund returns. Journal of Finance, 65(5), 1915-1947.',
        'Barber, B. M., & Odean, T. (2000). Trading is hazardous to your wealth: The common stock investment performance of individual investors. Journal of Finance, 55(2), 773-806.',
        'Bessenbinder, H. (2018). On the potential for non-parametric risk-adjusted performance attribution using characteristic-attribute-sorted factors. Journal of Investment Management, 16(3), 1-14.',
      ],
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

  static InvestmentOption? getOptionByCategoryId(String categoryId) {
    try {
      return options.firstWhere((option) => option.categoryId == categoryId);
    } catch (e) {
      return null;
    }
  }
}
