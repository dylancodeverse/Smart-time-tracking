import 'package:flutter/material.dart';
import 'package:sola/core/theme.dart';
import 'package:sola/features/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion de Traffic',
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
    );
  }
}
