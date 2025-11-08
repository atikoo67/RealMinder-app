import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

import 'package:realminder/presentation/pages/homepage.dart';
import 'package:realminder/presentation/widgets/onbordingcard.dart';

class OnboardingPage extends StatelessWidget {
  List<Map> onboarding = [
    {
      'title': "jhgshgf",
      'description':
          "Begin your journey to mindfulness with guided meditations and breathing exercises designed for your daily routine.",
      'imagepath': Icons.task_alt_outlined,
    },
    {
      'title': "agnlg",
      'description':
          "Monitor your growth, celebrate milestones, and see how far you've come on your mindfulness journey.",
      'imagepath': Icons.task_alt_outlined,
    },
    {
      'title': "dajfndkjfn",
      'description':
          "Begin your journey to mindfulness with guided meditations and breathing exercises designed for your daily routine.",
      'imagepath': Icons.task_alt_outlined,
    },
    {
      'title': "the tasks",
      'description':
          "Monitor your growth, celebrate milestones, and see how far you've come on your mindfulness journey.",
      'imagepath': Icons.auto_graph_sharp,
    },
    {
      'title': "",
      'description':
          "Begin your journey to mindfulness with guided meditations and breathing exercises designed for your daily routine.",
      'imagepath': Icons.task_alt_outlined,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OnBoardingSlider(
          centerBackground: true,

          headerBackgroundColor: Colors.white,
          finishButtonText: 'Get Start',
          finishButtonStyle: FinishButtonStyle(backgroundColor: Colors.black),
          skipTextButton: Text('Skip'),
          onFinish: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          totalPage: onboarding.length,
          speed: 1.8,
          pageBodies: onboarding.map((onboard) {
            return OnbordingCard(
              title: onboard['title'],
              description: onboard['description'],
            );
          }).toList(),

          background: onboarding.map((onboard) {
            return Icon(
              onboard['imagepath'],
              size: 80,
              color: Colors.blueGrey[600],
            );
          }).toList(),
        ),
      ),
    );
  }
}
