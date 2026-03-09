import 'package:fintrack/features/currency/logic/currency_provider.dart';
import 'package:fintrack/features/home_screen/presentation/bar%20graph/bar_data.dart';
import 'package:fintrack/theming/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyBarGraph extends ConsumerWidget {
  const MyBarGraph({super.key, required this.weeklySummary});
  final List<double> weeklySummary;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencySymbol = ref.watch(currencySymbolProvider);
    BarData myBarData = BarData(
      sunAmount: weeklySummary[0].toDouble(),
      monAmount: weeklySummary[1].toDouble(),
      tueAmount: weeklySummary[2].toDouble(),
      wedAmount: weeklySummary[3].toDouble(),
      thuAmount: weeklySummary[4].toDouble(),
      friAmount: weeklySummary[5].toDouble(),
      satAmount: weeklySummary[6].toDouble(),
    );
    List<double> sortedList = List.from(weeklySummary)..sort();
    double highestSpend = sortedList.last;
    myBarData.getBarData();
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipPadding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            tooltipMargin: 2,
            getTooltipColor: (group) => AppColors.kBackgroundColor,
            tooltipBorderRadius: BorderRadius.circular(6),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '$currencySymbol${rod.toY.toInt()}',
                const TextStyle(
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
            ),
          ),
        ),
        maxY: highestSpend,
        minY: 0,
        barGroups: myBarData.getBarData().map((data) {
          return BarChartGroupData(
            barsSpace: 6,
            x: data.x,
            showingTooltipIndicators:
                highestSpend == data.y && highestSpend != 0 ? [0] : [],
            barRods: [
              BarChartRodData(
                toY: data.y,
                color: data.y == highestSpend
                    ? AppColors.kPrimaryColor
                    : AppColors.kBarGraphNotHighest,
                width: 26,
                borderRadius: const BorderRadius.all(Radius.circular(0)),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Mon', style: style);
        break;
      case 1:
        text = const Text('Tue', style: style);
        break;
      case 2:
        text = const Text('Wed', style: style);
        break;
      case 3:
        text = const Text('Thu', style: style);
        break;
      case 4:
        text = const Text('Fri', style: style);
        break;
      case 5:
        text = const Text('Sat', style: style);
        break;
      case 6:
        text = const Text('Sun', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      meta: meta,
      space: 8.0,
      child: text,
    );
  }
}
