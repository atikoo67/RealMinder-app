import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:realminder/core/theme/theme.dart';

class CircularBar extends StatelessWidget {
  const CircularBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text("Overall Compliance", style: theme.textTheme.titleMedium),
              Icon(Icons.info_outline, size: 15),
            ],
          ),

          CircularPercentIndicator(
            radius: 100,
            animation: true,
            animationDuration: 1200,
            lineWidth: 20.0,
            percent: 0.85,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "85%",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                    fontSize: 40.0,
                  ),
                ),
                Text("Achieved", style: TextStyle(fontSize: 16)),
              ],
            ),
            circularStrokeCap: CircularStrokeCap.butt,
            backgroundColor: const Color.fromARGB(255, 255, 157, 0),
            progressColor: theme.colorScheme.primary,
          ),

          LinearPercentIndicator(
            animation: true,
            animationDuration: 1200,
            lineHeight: 8,
            percent: 0.85,
            barRadius: Radius.circular(8),

            backgroundColor: const Color.fromARGB(255, 255, 157, 0),
            progressColor: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
