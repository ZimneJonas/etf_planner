import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/portfolio.dart';

class PortfolioPieChart extends StatefulWidget {
  final Portfolio portfolio;
  final double size;

  const PortfolioPieChart({
    super.key,
    required this.portfolio,
    this.size = 200,
  });

  @override
  State<PortfolioPieChart> createState() => _PortfolioPieChartState();
}

class _PortfolioPieChartState extends State<PortfolioPieChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void didUpdateWidget(PortfolioPieChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.portfolio != widget.portfolio) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: PortfolioPieChartPainter(
            portfolio: widget.portfolio,
            animationValue: _animation.value,
          ),
        );
      },
    );
  }
}

class PortfolioPieChartPainter extends CustomPainter {
  final Portfolio portfolio;
  final double animationValue;

  PortfolioPieChartPainter({
    required this.portfolio,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 10;

    // Calculate angles for each allocation
    double startAngle = -math.pi / 2; // Start from top
    final allocations = portfolio.allocationsByTier;

    for (final allocation in allocations) {
      final sweepAngle =
          (allocation.percentage / 100) * 2 * math.pi * animationValue;

      // Create paint for this segment
      final paint = Paint()
        ..color = allocation.option.tierColor
        ..style = PaintingStyle.fill;

      // Draw the arc segment
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Draw border
      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        borderPaint,
      );

      startAngle += sweepAngle;
    }

    // Draw center circle
    final centerPaint = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.3, centerPaint);

    // Draw percentage text in center
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${portfolio.totalPercentage.toStringAsFixed(0)}%',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is PortfolioPieChartPainter &&
        (oldDelegate.portfolio != portfolio ||
            oldDelegate.animationValue != animationValue);
  }
}

class PortfolioLegend extends StatelessWidget {
  final Portfolio portfolio;

  const PortfolioLegend({super.key, required this.portfolio});

  @override
  Widget build(BuildContext context) {
    final allocations = portfolio.allocationsByTier;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: allocations.map((allocation) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: allocation.option.tierColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${allocation.option.name} - ${allocation.percentage.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                allocation.option.tierLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: allocation.option.tierColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
