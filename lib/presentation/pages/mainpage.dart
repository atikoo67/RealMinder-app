import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:realminder/core/theme/theme.dart';
import 'package:realminder/presentation/pages/createreminder.dart';
import 'package:realminder/presentation/pages/homepage.dart';
import 'package:realminder/presentation/pages/trackreminder.dart';
import 'package:realminder/presentation/widgets/main_navigation.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    CreateReminder(),
    ReminderTracker(),
  ];

  void indexofItems(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: CustomBottomNavBar(
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          navItems: [
            NavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              isActive: _currentIndex == 0,
              onTap: () => indexofItems(0),
              activeColor: null,
              inactiveColor: null,
              activebackgroundColor: null,
              inactivebackgroundColor: null,
            ),
            NavItem(
              icon: Icons.menu_book_outlined,
              label: 'Create',
              isActive: _currentIndex == 1,
              onTap: () => indexofItems(1),
              activeColor: null,
              inactiveColor: null,
              activebackgroundColor: null,
              inactivebackgroundColor: null,
            ),
            NavItem(
              icon: Icons.article_outlined,
              label: 'Tracker',
              isActive: _currentIndex == 2,
              onTap: () => indexofItems(1),
              activeColor: null,
              inactiveColor: null,
              activebackgroundColor: null,
              inactivebackgroundColor: null,
            ),
          ],
        ),
      ),
    );
  }
}
