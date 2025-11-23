import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:realminder/core/theme/theme.dart';
import 'package:realminder/presentation/widgets/circularbar.dart';
import 'package:realminder/presentation/widgets/linearbar.dart';

class ReminderTracker extends StatefulWidget {
  const ReminderTracker({super.key});

  @override
  State<ReminderTracker> createState() => _ReminderTrackerState();
}

class _ReminderTrackerState extends State<ReminderTracker> {
  @override
  Widget build(BuildContext context) {
    // X-axis categories
    final labels = ['Work', 'Personal', 'Health', 'Education'];

    // Sample values for each day
    final values = [3.0, 4.5, 2.5, 5.0];
    final barcolor = [
      const Color.fromARGB(255, 62, 85, 0),
      const Color.fromARGB(255, 0, 145, 5),
      const Color.fromARGB(255, 0, 61, 126),
      const Color.fromARGB(255, 55, 0, 103),
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Tracker'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: Divider(
                color: theme.colorScheme.tertiary.withValues(alpha: 0.5),
              ),
            ),

            Column(
              spacing: 10,
              children: [
                CircularBar(),
                LinearBar(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 45, horizontal: 20),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: BoxBorder.all(
                      color: const Color.fromARGB(220, 146, 146, 146),
                      width: 0.4,
                    ),
                  ),
                  child: Column(
                    spacing: 30,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Reminder Frequency",
                            style: theme.textTheme.titleMedium,
                          ),
                          Icon(FontAwesomeIcons.tag, size: 15),
                        ],
                      ),
                      SizedBox(
                        height: 250,
                        width: MediaQuery.of(context).size.width * 0.70,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 6,
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              getDrawingHorizontalLine: (value) => FlLine(
                                color: Colors.grey.withOpacity(0.2),
                                strokeWidth: 1,
                              ),
                            ),
                            titlesData: FlTitlesData(
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 28,
                                  interval: 1,
                                  getTitlesWidget: (value, meta) => Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),

                              // ✅ Custom X-axis string labels
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    if (index >= 0 && index < labels.length) {
                                      return Text(
                                        labels[index],
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                  reservedSize: 28,
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            barGroups: List.generate(values.length, (index) {
                              return BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    toY: values[index],
                                    color: barcolor[index],
                                    borderRadius: BorderRadius.circular(4),
                                    width: 50,
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
