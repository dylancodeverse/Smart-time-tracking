import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesHelper {

  static Future<void> resetSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Supprime toutes les clés et valeurs
  }

}

class GetStorageHelper{
  static String boxName = "cacheSola";

  static Future<void> _resetGetStorage() async {
    final box = GetStorage(boxName);
    await box.erase(); // Efface toutes les clés/valeurs
  }
  static Future<void> initGetStorage(bool reset) async{
    await GetStorage.init(boxName);
    if(reset) _resetGetStorage() ;
  }
  static GetStorage getStorage(){
    return GetStorage(boxName);
  }
 
}