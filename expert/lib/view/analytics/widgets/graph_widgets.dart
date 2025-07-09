import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EarningsTrendChart extends StatelessWidget {
  final double sw;
  final double sh;
  const EarningsTrendChart({Key? key, required this.sw, required this.sh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Earnings Trend',
            style: TextStyle(
                fontFamily: 'Jakarta-Medium',
                fontSize: sw * 0.05,
                fontWeight: FontWeight.w500)),
        SizedBox(height: sh * 0.01),
        SizedBox(
          height: sh * 0.3,
          width: double.infinity,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: sw * 0.1),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const months = ['Jan','Feb','Mar','Apr','May','Jun'];
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(months[value.toInt()], style: TextStyle(fontFamily: 'Jakarta-Light', fontSize: sw * 0.035)),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(0, 32000),
                    FlSpot(1, 38000),
                    FlSpot(2, 42000),
                    FlSpot(3, 40000),
                    FlSpot(4, 46000),
                    FlSpot(5, 47000),
                  ],
                  isCurved: true,
                  dotData: FlDotData(show: true),
                  barWidth: 3,
                  color: Colors.blue,
                )
              ],
              minY: 0,
              maxY: 60000,
            ),
          ),
        ),
      ],
    );
  }
}

class WeeklySessionsChart extends StatelessWidget {
  final double sw;
  final double sh;
  const WeeklySessionsChart({Key? key, required this.sw, required this.sh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Weekly Sessions',
            style: TextStyle(
                fontFamily: 'Jakarta-Medium',
                fontSize: sw * 0.05,
                fontWeight: FontWeight.w500)),
        SizedBox(height: sh * 0.01),
        SizedBox(
          height: sh * 0.3,
          width: double.infinity,
          child: BarChart(
            BarChartData(
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(days[value.toInt()], style: TextStyle(fontFamily: 'Jakarta-Light', fontSize: sw * 0.035)),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: sw * 0.1)),
              ),
              barGroups: [
                BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, width: sw * 0.05)]),
                BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 12, width: sw * 0.05)]),
                BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 15, width: sw * 0.05)]),
                BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 10, width: sw * 0.05)]),
                BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 14, width: sw * 0.05)]),
                BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 9, width: sw * 0.05)]),
                BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 7, width: sw * 0.05)]),
              ],
              maxY: 16,
            ),
          ),
        ),
      ],
    );
  }
}
