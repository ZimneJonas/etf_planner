import 'package:flutter/material.dart';
import '../models/investment_option.dart';

class InvestmentOptionCard extends StatefulWidget {
  final InvestmentOption option;
  final bool isSelected;
  final VoidCallback onToggleSelection;

  const InvestmentOptionCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onToggleSelection,
  });

  @override
  State<InvestmentOptionCard> createState() => _InvestmentOptionCardState();
}

class _InvestmentOptionCardState extends State<InvestmentOptionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    widget.onToggleSelection();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            color: widget.isSelected
                ? widget.option.tierColor.withOpacity(0.1)
                : null,
            child: InkWell(
              onTap: _handleTap,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      children: [
                        // Tier Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: widget.option.tierColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                widget.option.tierIcon,
                                size: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.option.tierLabel,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        // Selection Indicator
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: widget.isSelected
                                  ? widget.option.tierColor
                                  : Theme.of(context).colorScheme.outline,
                              width: 2,
                            ),
                            color: widget.isSelected
                                ? widget.option.tierColor
                                : Colors.transparent,
                          ),
                          child: widget.isSelected
                              ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Option Name and Ticker
                    Text(
                      widget.option.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: widget.isSelected
                            ? widget.option.tierColor
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.option.ticker,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Description
                    Text(
                      widget.option.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                      maxLines: _isExpanded ? null : 2,
                      overflow: _isExpanded ? null : TextOverflow.ellipsis,
                    ),

                    // Expandable Risk Explanation
                    if (_isExpanded) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: widget.option.tierColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: widget.option.tierColor.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: widget.option.tierColor,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.option.riskExplanation,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: widget.option.tierColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // Additional Info Row
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (widget.option.region != null) ...[
                          Icon(
                            Icons.public,
                            size: 14,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.option.region!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.5),
                                ),
                          ),
                          const SizedBox(width: 16),
                        ],
                        if (widget.option.leverageMultiplier != null) ...[
                          Icon(
                            Icons.trending_up,
                            size: 14,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.option.leverageMultiplier}x',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.5),
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                        const Spacer(),
                        // Expand/Collapse Button
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          icon: Icon(
                            _isExpanded ? Icons.expand_less : Icons.expand_more,
                            size: 20,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.5),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 24,
                            minHeight: 24,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
