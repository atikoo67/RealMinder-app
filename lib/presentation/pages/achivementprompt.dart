import 'package:flutter/material.dart';
import 'package:realminder/core/theme/theme.dart';
import 'package:realminder/presentation/widgets/mybutton.dart';

class AchievementPrompt extends StatelessWidget {
  const AchievementPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                border: BoxBorder.all(
                  color: const Color.fromARGB(220, 146, 146, 146),
                  width: 0.4,
                ),
              ),
              child: Column(
                spacing: 25,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 1),
                  Text(
                    'Did you achieve your goal for "Maditation morning" ?',
                    style: theme.textTheme.titleLarge,
                  ),

                  Column(
                    spacing: 15,
                    children: [
                      MyButton(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.close),
                            Text(
                              'Yes, i achieved it!',
                              style: theme.textTheme.titleMedium!.copyWith(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      MyButton(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.close),
                            Text(
                              "No, I'm still planning.",
                              style: theme.textTheme.titleMedium!.copyWith(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
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
