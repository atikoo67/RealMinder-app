import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
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
            item: ItemConfig(icon: Icon(Icons.home_outlined), title: "Home"),
          ),
          PersistentTabConfig(
            screen: HomePage(),
            item: ItemConfig(
              icon: Icon(Icons.calendar_month_outlined),
              title: "Calander",
            ),
          ),
          PersistentTabConfig(
            screen: CreateReminder(),
            item: ItemConfig(icon: Icon(Icons.add), title: "Add"),
          ),
          PersistentTabConfig(
            screen: HomePage(),
            item: ItemConfig(icon: Icon(Icons.task_alt), title: "Tasks"),
          ),
          PersistentTabConfig(
            screen: HomePage(),
            item: ItemConfig(
              icon: Icon(Icons.person_outline_rounded),
              title: "Profile",
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) =>
            Style1BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}
