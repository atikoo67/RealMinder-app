import 'package:flutter/material.dart';

class OnbordingCard extends StatelessWidget {
  final String title;
  final String description;

  const OnbordingCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 48),

        // Topic/Title
        Text(
          title,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w300,
            color: Colors.black87,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 16),

        // Description
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
