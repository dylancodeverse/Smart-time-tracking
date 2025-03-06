import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesHelper {

  static Future<void> resetSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Supprime toutes les clés et valeurs
  }

}