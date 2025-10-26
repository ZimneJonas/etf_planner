<!-- ec71ac32-dd54-4f3e-9b96-f4e8922bf59f 1494c2ca-6f5b-4834-8490-dba1f6191d22 -->
# Refactor Investment Options to Category-Based System

## Overview

Transform the investment option system from listing specific products (e.g., "iShares Core MSCI World UCITS ETF") to general categories (e.g., "Global Index Fund") with examples and scientific references.

## Data Model Changes

### 1. Create InvestmentExample Model

**File**: `lib/models/investment_option.dart`

Add a new class to represent specific product examples:

```dart
class InvestmentExample {
  final String name;
  final String ticker;
  final String description;
}
```

### 2. Update InvestmentOption Model

**File**: `lib/models/investment_option.dart`

- Make `ticker` field optional (or remove it, use category ID instead)
- Add `List<InvestmentExample> examples` field
- Add `List<String> scientificReferences` field for paper links
- Update constructor to include new fields
- Add unique category identifier (e.g., `id` or use `name` as identifier)

### 3. Refactor Investment Data

**File**: `lib/data/investment_options.dart`

Transform each specific product into a general category:

**Tier 1 (Recommended)**:

- "Global Index Fund" with examples: IWDA, SWRD, VT, VWRL
- Description: "Low-cost, diversified exposure to global equity markets"

**Tier 2 (Values-aligned)**:

- "Socially Responsible Index Fund" with examples: ISFE, ESG MSCI World
- "Climate-Aligned Index Fund" with examples: WPAE

**Tier 3 (Higher Risk)**:

- "Leveraged ETF (2x)" - NO examples per user request
- "Regional Index Fund" with examples: EIMI, IMEU

**Tier 4 (Speculative)**:

- "Leveraged ETF (3x)" - NO examples per user request
- "Cryptocurrency" with examples: BTC, ETH
- "Individual Stocks" with examples: TSLA, AAPL

Add scientific paper references for each category's claims.

## UI Updates

### 4. Update InvestmentOptionCard Widget

**File**: `lib/widgets/investment_option_card.dart`

- Remove ticker display from main card (since categories don't have tickers)
- Add expandable "Examples" section (collapsed by default)
- Show examples when user expands this new section
- Display scientific references as clickable links (perhaps with an info icon)
- Keep the existing risk explanation expandable section

### 5. Update Selection Logic

**File**: `lib/screens/option_selection_screen.dart`

- Change from tracking by `ticker` to tracking by category identifier (name or ID)
- Update `_selectedTickers` to `_selectedCategories` or similar
- Update all references to use category identifiers

## Portfolio Calculator Updates

### 6. Update Portfolio Comparison Logic

**File**: `lib/services/portfolio_calculator.dart`

- Replace ticker-based comparison (lines 137, 144, 159) with category identifier comparison
- Update `adjustAllocation` method to use category ID instead of ticker

### 7. Update Portfolio Model

**File**: `lib/models/portfolio.dart`

No changes needed - already uses `InvestmentOption` objects directly.

## Implementation Details

### Scientific References

Add references for claims like:

- Global diversification benefits (e.g., Merton, Solnik papers)
- Low-cost index advantages (e.g., Bogle, Fama-French)
- Leverage decay risks
- ESG/SRI performance studies

### Category Identifiers

Use category name as unique identifier or add explicit `id` field like:

- "global-index-fund"
- "sri-index-fund"
- "leveraged-2x-etf"
- etc.

### Examples Display Format

Show examples as a simple list:

```
Examples:
• iShares Core MSCI World (IWDA)
• SPDR MSCI World (SWRD)
• Vanguard Total World Stock (VT)
```

### To-dos

- [ ] Add InvestmentExample class and update InvestmentOption model with examples, references, and category ID
- [ ] Transform specific products to categories with examples and add scientific references
- [ ] Modify InvestmentOptionCard to show category info and expandable examples section
- [ ] Update OptionSelectionScreen to use category identifiers instead of tickers
- [ ] Update PortfolioCalculator to use category identifiers for comparison
- [ ] Verify all screens work correctly with category-based system