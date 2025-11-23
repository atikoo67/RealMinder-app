import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:realminder/core/theme/theme.dart';
import 'package:realminder/presentation/pages/achivementprompt.dart';
import 'package:realminder/presentation/widgets/mybutton.dart';

class AlarmPopup extends StatelessWidget {
  const AlarmPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                spacing: 25,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 1),
                  Icon(FontAwesomeIcons.bell, size: 80),
                  Text(
                    'Daily Meditation',
                    style: theme.textTheme.titleLarge!.copyWith(fontSize: 30),
                  ),
                  Text(
                    'Take a moment to center yourself and find inner peace.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleSmall!.copyWith(fontSize: 18),
                  ),
                  Column(
                    spacing: 15,
                    children: [
                      MyButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AchievementPrompt(),
                            ),
                          );
                        },
                        child: Text(
                          'Complete',
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.secondary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      MyButton(
                        color: Color.fromARGB(151, 215, 215, 215),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Snooze",
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),

                  TextButton(
                    onPressed: () {},
                    child: Text('Cancel', style: theme.textTheme.titleMedium),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
