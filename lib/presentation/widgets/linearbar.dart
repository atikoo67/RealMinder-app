import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:realminder/core/theme/theme.dart';

class LinearBar extends StatelessWidget {
  const LinearBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 45, horizontal: 25),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: BoxBorder.all(
          color: const Color.fromARGB(220, 146, 146, 146),
          width: 0.4,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Daily Completion Trend",
                style: theme.textTheme.titleMedium,
              ),
              Icon(Icons.calendar_month_outlined, size: 15),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width * 0.80,
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 6,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false, // only horizontal lines
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          const labels = [0, 8, 16, 24, 32, 40];
                          String text = '';
                          if (value >= 0 && value < labels.length) {
                            text = labels[value.toInt()].toString();
                          }
                          return Text(
                            text,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                        interval: 1, // one label per point
                      ),
                    ), // hide axis labels for clean look
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ), // hide axis labels for clean look
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ), // hide axis labels for clean look
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          const labels = [
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                            'Sun',
                          ];
                          String text = '';
                          if (value.toInt() >= 0 &&
                              value.toInt() < labels.length) {
                            text = labels[value.toInt()];
                          }
                          return Text(
                            text,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                        interval: 1, // one label per point
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: Colors.orange,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                      spots: const [
                        FlSpot(0, 3),
                        FlSpot(1, 4),
                        FlSpot(2, 3.5),
                        FlSpot(3, 5),
                        FlSpot(4, 2),
                        FlSpot(5, 2.5),
                        FlSpot(6, 3),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
