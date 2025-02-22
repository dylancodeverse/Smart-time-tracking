import 'package:sola/data/config/sqfllite/sqflite_config.dart';
import 'package:sola/data/helper/sqflite/database_creator.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';


//  Cette classe ne fait  que gérer la base : ouverture et accès.

class SqfliteDatabaseHelper {
  static final SqfliteDatabaseHelper _instance = SqfliteDatabaseHelper._internal();
  static Database? _database;

  factory SqfliteDatabaseHelper() => _instance;

  SqfliteDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(SqfliteConfig.outputFileName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        final creator = DatabaseCreator();
        await creator.createTables(db);
      },
    );
  }
  
  static Future<String> getDbPath() async {
    return join(await getDatabasesPath(), SqfliteConfig.outputFileName);
  }
}
