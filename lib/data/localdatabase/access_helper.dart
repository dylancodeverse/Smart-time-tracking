import 'package:sola/config/database_config.dart';
import 'package:sola/data/localdatabase/database_helper.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart'; // Pour manipuler les chemins de fichiers

class DBAccess {
  static Future<String> getDbPath() async {
    return join(await getDatabasesPath(), DatabaseConfig.outputFileName);
  }

  static Future<Database>  getDB() async{
    return DatabaseHelper().database;
  }
}
