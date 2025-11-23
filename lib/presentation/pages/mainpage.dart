import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:realminder/core/theme/theme.dart';
import 'package:realminder/presentation/pages/achivementprompt.dart';
import 'package:realminder/presentation/pages/addmedia_page.dart';
import 'package:realminder/presentation/pages/alarmpopup.dart';
import 'package:realminder/presentation/pages/createreminder.dart';
import 'package:realminder/presentation/pages/homepage.dart';
import 'package:realminder/presentation/pages/trackreminder.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: PersistentTabView(
          tabs: [
            PersistentTabConfig(
              screen: HomePage(),
              item: ItemConfig(
                icon: Icon(FontAwesomeIcons.bell),
                title: "Reminders",
                activeForegroundColor: theme.colorScheme.primary,
              ),
            ),
            PersistentTabConfig(
              screen: CreateReminder(),
              item: ItemConfig(
                icon: Icon(Icons.add),
                title: "Create",
                activeForegroundColor: theme.colorScheme.primary,
              ),
            ),
            PersistentTabConfig(
              screen: ReminderTracker(),
              item: ItemConfig(
                activeForegroundColor: theme.colorScheme.primary,
                icon: Icon(Icons.calendar_month_outlined),
                title: "Tracker",
              ),
            ),
          ],
          navBarBuilder: (navBarConfig) =>
              Style1BottomNavBar(navBarConfig: navBarConfig),
        ),
      ),
    );
  }
}
