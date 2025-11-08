import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:realminder/core/theme/theme.dart';
import 'package:realminder/presentation/pages/achivementprompt.dart';
import 'package:realminder/presentation/pages/createreminder.dart';
import 'package:realminder/presentation/pages/homepage.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: HomePage(),
            item: ItemConfig(
              icon: Icon(Icons.home_outlined),
              title: "Home",
              activeForegroundColor: theme.colorScheme.primary,
            ),
          ),
          PersistentTabConfig(
            screen: HomePage(),
            item: ItemConfig(
              activeForegroundColor: theme.colorScheme.primary,
              icon: Icon(Icons.calendar_month_outlined),
              title: "Calander",
            ),
          ),
          PersistentTabConfig(
            screen: CreateReminder(),
            item: ItemConfig(
              icon: Icon(Icons.add),
              title: "Add",
              activeForegroundColor: theme.colorScheme.primary,
            ),
          ),
          PersistentTabConfig(
            screen: AchievementPrompt(),
            item: ItemConfig(
              icon: Icon(Icons.task_alt),
              title: "Tasks",
              activeForegroundColor: theme.colorScheme.primary,
            ),
          ),
          PersistentTabConfig(
            screen: HomePage(),
            item: ItemConfig(
              icon: Icon(Icons.person_outline_rounded),
              title: "Profile",
              activeForegroundColor: theme.colorScheme.primary,
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) =>
            Style1BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}
