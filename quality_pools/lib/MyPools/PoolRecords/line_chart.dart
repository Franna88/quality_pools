import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:quality_pools/CommonComponants/my_utility.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';
import 'package:quality_pools/Themes/quality_pools_colors.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            'pH Level',
            style: QualityPoolTextstyle(context).blackStyleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SizedBox(
            height: MyUtility(context).height * 0.4,
            width: MyUtility(context).width,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true, // Show vertical lines
                  drawHorizontalLine: true, // Show horizontal lines
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: MyColors().lightGrey, // Light grey grid lines
                    strokeWidth: 1, // Solid line
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: MyColors().lightGrey, // Light grey grid lines
                    strokeWidth: 1, // Solid line
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: false), // Hide top titles
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: false), // Hide left titles
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        // Return x-axis months (Jan to Dec), but only every second month
                        switch (value.toInt()) {
                          case 0:
                            return const Text('Jan');
                          case 2:
                            return const Text('Mar');
                          case 4:
                            return const Text('May');
                          case 6:
                            return const Text('Jul');
                          case 8:
                            return const Text('Sep');
                          case 10:
                            return const Text('Nov');
                          default:
                            return const Text('');
                        }
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize:
                          40, // Add margin to the right axis titles to prevent cutting off
                      getTitlesWidget: (value, meta) {
                        // Display custom right y-axis titles (100k, 200k, 300k, 400k)
                        switch (value.toInt()) {
                          case 100000:
                            return const Text('100k');
                          case 200000:
                            return const Text('200k');
                          case 300000:
                            return const Text('300k');
                          case 400000:
                            return const Text('400k');
                          default:
                            return const Text('');
                        }
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.black, width: 1)),
                minX: 0,
                maxX: 11, // For 12 months (Jan-Dec)
                minY: 0,
                maxY: 400000, // For 400k
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 100000), // Jan
                      FlSpot(1, 150000), // Feb
                      FlSpot(2, 200000), // Mar
                      FlSpot(3, 250000), // Apr
                      FlSpot(4, 300000), // May
                      FlSpot(5, 350000), // Jun
                      FlSpot(6, 300000), // Jul
                      FlSpot(7, 200000), // Aug
                      FlSpot(8, 250000), // Sep
                      FlSpot(9, 150000), // Oct
                      FlSpot(10, 100000), // Nov
                      FlSpot(11, 200000), // Dec
                    ],
                    isCurved: false, // Make the line smooth
                    color: MyColors().red,
                    barWidth: 4,
                    isStrokeCapRound: false,
                    dotData: const FlDotData(show: false), // Hide the dots
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
