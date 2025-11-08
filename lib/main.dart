import 'package:flutter/material.dart';
import 'package:realminder/core/theme/theme.dart';
import 'package:realminder/presentation/pages/mainpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: theme,
    );
  }
}
