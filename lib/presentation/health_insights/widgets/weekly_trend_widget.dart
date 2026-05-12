import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nutricart/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';


class WeeklyTrendWidget extends StatefulWidget {
  final Map<String, dynamic> trends;

  const WeeklyTrendWidget({Key? key, required this.trends}) : super(key: key);

  @override
  State<WeeklyTrendWidget> createState() => _WeeklyTrendWidgetState();
}

class _WeeklyTrendWidgetState extends State<WeeklyTrendWidget> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.show_chart,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                l10n.insights7DayTrends,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          // Tab selector
          Row(
            children: [
              _buildTab(l10n.insightsTabAdherence, 0, theme),
              SizedBox(width: 2.w),
              _buildTab(l10n.insightsTabCalories, 1, theme),
              SizedBox(width: 2.w),
              _buildTab(l10n.insightsTabBudget, 2, theme),
            ],
          ),
          SizedBox(height: 2.h),
          // Chart
          SizedBox(height: 25.h, child: _buildChart(theme)),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index, ThemeData theme) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primaryContainer
                : theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelMedium?.copyWith(
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChart(ThemeData theme) {
    List<dynamic> data;
    String unit;
    Color lineColor;
    double maxY;

    switch (_selectedTab) {
      case 0:
        data = widget.trends['mealAdherence'] ?? [];
        unit = '%';
        lineColor = const Color(0xFF7CB342);
        maxY = 100;
        break;
      case 1:
        data = widget.trends['calorieIntake'] ?? [];
        unit = 'kcal';
        lineColor = const Color(0xFF4A90A4);
        maxY = 2000;
        break;
      case 2:
        data = widget.trends['budgetUsage'] ?? [];
        unit = '₹';
        lineColor = const Color(0xFFFFB74D);
        maxY = 350;
        break;
      default:
        data = [];
        unit = '';
        lineColor = theme.colorScheme.primary;
        maxY = 100;
    }

    if (data.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.insightsNoData,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    final spots = data.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value as Map<String, dynamic>;
      final value = (item['value'] ?? 0).toDouble();
      return FlSpot(index.toDouble(), value);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY / 4,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: theme.colorScheme.outline.withValues(alpha: 0.1),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 10.sp,
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < data.length) {
                  final day = data[value.toInt()]['day'] ?? '';
                  return Padding(
                    padding: EdgeInsets.only(top: 0.5.h),
                    child: Text(
                      day,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 10.sp,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (data.length - 1).toDouble(),
        minY: 0,
        maxY: maxY,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: lineColor,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: lineColor,
                  strokeWidth: 2,
                  strokeColor: theme.colorScheme.surface,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: lineColor.withValues(alpha: 0.1),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  '${spot.y.toInt()}$unit',
                  theme.textTheme.labelSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
