import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: AppTheme.scaff,
    fontFamily: 'Montserrat', // ✅ Définition de la police globale
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.teal,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.teal,
      unselectedItemColor: AppTheme.scaff,
    ),
    textTheme: TextTheme(
      bodyLarge: AppTheme.bodyLarge,
      bodyMedium:AppTheme.bodyMediu,
      titleLarge:AppTheme.titleLarg,
    ),
  );
  static String get appName => "Coopérative SOLA";
  static Color get primaryColor => Colors.teal;
  static Color get textColor => Colors.black87;
  static Color get cardColor => Colors.white;
  
  static Color get scaff => Color(0xFFF2F9F7); 
  static TextStyle get bodyLarge =>TextStyle(fontFamily: 'Montserrat', fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400 );
  static TextStyle get bodyMediu => TextStyle(fontFamily: 'Montserrat', fontSize: 16, color: Colors.black , fontWeight: FontWeight.w300);
  static TextStyle get titleLarg => TextStyle(fontFamily: 'Montserrat', fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle get smallText => TextStyle(fontFamily: 'Montserrat', fontSize: 10, color: Colors.black , fontWeight: FontWeight.w300);
  static Color? get darkPrimary => Colors.teal[800];

}
