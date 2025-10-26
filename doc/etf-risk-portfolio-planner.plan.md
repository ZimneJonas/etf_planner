<!-- 85cdfff2-c43a-499b-934d-a5f8983e198f f5012f05-6063-48c7-9520-fa4949fe29f0 -->
# Ranked ETF Selection Portfolio Builder

## Overview

Create a ranked list-based portfolio builder where investment options are displayed from best (World ETF) to higher risk (3x leverage, crypto, individual stocks). Users select options they want, and the app generates an intelligent portfolio allocation based on their risk acceptance and selected options, with manual fine-tuning available.

## Core Concept

- **Ranking System**: Green (best/recommended) → Yellow (acceptable) → Orange (higher risk) → Red (gambling/speculative)
- **Selection Process**: Click to add options to portfolio
- **Smart Allocation**: Algorithm distributes percentages based on risk score + selected options
- **Manual Override**: Percentage sliders for fine-tuning after auto-calculation

## Implementation Steps

### 1. Create Data Models

**`lib/models/investment_option.dart`**:

- Option details: name, ticker, description, category
- Risk tier: best (green), good (yellow), risky (orange), speculative (red)
- Type: etf_world, etf_leveraged_2x, etf_leveraged_3x, etf_sri, etf_climate, crypto, stock, regional_etf

**`lib/models/portfolio.dart`**:

- Selected options with allocated percentages
- Methods to calculate total, validate 100%
- Support for auto-calculation and manual adjustment

**`lib/models/investment_preference.dart`**:

- Investment horizon (years)
- Risk acceptance (1-10 scale)

### 2. Build Investment Database

**`lib/data/investment_options.dart`** with hardcoded real options:

**Tier 1 - Green (Recommended)**:

- MSCI World ETFs (e.g., IWDA, SWRD, URTH)
- FTSE All-World ETFs (e.g., VWRL, VT)

**Tier 2 - Yellow (SRI/Climate-aligned)**:

- SRI World ETFs (e.g., ISFE - MSCI World SRI)
- Paris-aligned ETFs (e.g., WPAE - World Paris-Aligned)
- ESG-focused ETFs

**Tier 3 - Orange (Moderate Leverage/Regional)**:

- 2x Leveraged ETFs (e.g., SSO - 2x S&P 500, QLD - 2x Nasdaq)
- Regional focus ETFs (Emerging markets, specific regions)

**Tier 4 - Red (Speculative/Gambling)**:

- 3x Leveraged ETFs (e.g., UPRO - 3x S&P 500, TQQQ - 3x Nasdaq)
- Crypto (Bitcoin, Ethereum)
- Individual stocks (Tesla, Apple, etc.)

### 3. Portfolio Allocation Algorithm

**`lib/services/portfolio_calculator.dart`**:

Smart allocation logic:

- **Base**: If only Tier 1 selected → 100%
- **With multiple tiers**: 
- Calculate base percentage for Tier 1 based on risk score (e.g., risk 3 → 85%, risk 7 → 60%, risk 10 → 40%)
- Distribute remaining % to other selected options weighted by tier and risk acceptance
- Formula: Lower risk acceptance → higher % to safer tiers
- Example: Risk 6, selected [World, 2x Leveraged, Crypto] → 65% World, 28% Leveraged, 7% Crypto

Algorithm parameters (can be fine-tuned):

- Risk-to-safe-percentage mapping
- Tier weight multipliers
- Minimum allocation thresholds

### 4. Build UI Flow

**Update `lib/main.dart`** to navigation flow:

- Screen 1: Investment horizon input (keep existing)
- Screen 2: Risk acceptance input
- Screen 3: Option selection screen
- Screen 4: Portfolio result screen

**`lib/screens/risk_input_screen.dart`**:

- 1-10 slider with descriptive labels
- Visual risk indicator
- Smooth transition to option selection

**`lib/screens/option_selection_screen.dart`**:

- Scrollable ranked list of investment options
- Color-coded cards (green → yellow → orange → red)
- Each card shows:
- Tier badge/color indicator
- Option name + ticker
- Brief description
- Risk level explanation
- "Add to Portfolio" button (or checkmark if selected)
- Selected options appear in summary bar at bottom
- "Generate Portfolio" button

**`lib/screens/portfolio_result_screen.dart`**:

- Auto-calculated portfolio allocation
- Pie chart visualization (green-yellow-orange-red segments)
- Allocation list with percentage bars
- Manual adjustment section:
- Slider for each selected option
- Auto-balances to 100%
- Reset to recommended button
- Educational warnings for red-tier selections

### 5. Build UI Components

**`lib/widgets/investment_option_card.dart`**:

- Color-coded card by tier
- Expandable for more details
- Selection toggle
- Tier badge (icons/labels)

**`lib/widgets/portfolio_pie_chart.dart`**:

- Custom painted pie chart
- Color-coded by tier colors
- Animated transitions
- Interactive legend

**`lib/widgets/allocation_slider.dart`**:

- Percentage slider for each option
- Shows option name, current %, tier color
- Live updates pie chart
- Validation (total = 100%)

**`lib/widgets/portfolio_summary_bar.dart`**:

- Fixed bottom bar on selection screen
- Shows selected options count
- Quick preview of selections
- "Generate Portfolio" CTA

### 6. Color System

Define consistent color scheme in theme:

- **Green (Tier 1)**: #4CAF50 - Recommended
- **Yellow (Tier 2)**: #FFC107 - Acceptable with values
- **Orange (Tier 3)**: #FF9800 - Higher risk
- **Red (Tier 4)**: #F44336 - Speculative/gambling

### 7. Educational Content

Add contextual information:

- Tooltip/info icons explaining each tier
- Warning dialogs for red-tier selections
- Brief explanation of why World ETF is optimal
- Risk disclaimers for leveraged products
- Scientific consensus references

## Key Files Structure

**New Models**:

- `lib/models/investment_option.dart`
- `lib/models/portfolio.dart`
- `lib/models/investment_preference.dart`

**Data**:

- `lib/data/investment_options.dart` (hardcoded real ETFs/options)

**Services**:

- `lib/services/portfolio_calculator.dart` (smart allocation algorithm)

**Screens**:

- `lib/screens/risk_input_screen.dart`
- `lib/screens/option_selection_screen.dart`
- `lib/screens/portfolio_result_screen.dart`

**Widgets**:

- `lib/widgets/investment_option_card.dart`
- `lib/widgets/portfolio_pie_chart.dart`
- `lib/widgets/allocation_slider.dart`
- `lib/widgets/portfolio_summary_bar.dart`

**Updated**:

- `lib/main.dart` (navigation + theme colors)

## Technical Details

- Flutter CustomPainter for pie chart
- State management: setState (simple for now)
- Navigation: MaterialPageRoute
- Validation: Ensure percentages sum to 100%
- Algorithm: Simple but expandable for future refinement

### To-dos

- [ ] Create data models (ETF, Portfolio, InvestmentPreference)
- [ ] Create predefined ETF database with World, EU leveraged, and US leveraged ETFs
- [ ] Implement portfolio recommendation logic and leverage calculation
- [ ] Build risk acceptance input screen with 1-10 slider
- [ ] Build pie chart widget using CustomPainter
- [ ] Build allocation list widget with percentage bars
- [ ] Build recommendation screen with charts, leverage slider, and educational content
- [ ] Update main.dart to implement multi-screen navigation flow