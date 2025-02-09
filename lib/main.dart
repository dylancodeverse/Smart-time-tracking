import 'package:flutter/material.dart';
import 'package:spracheeasy/core/theme.dart';
import 'package:spracheeasy/features/home/home_screen.dart';

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
