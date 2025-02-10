import 'package:flutter/services.dart';
import 'package:sola/config/database_config.dart';
import 'package:sola/data/localdatabase/init_datas.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  


  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();


  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(DatabaseConfig.outputFileName);
    return _database!;
  }


  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    
    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    String queries = await rootBundle.loadString(DatabaseConfig.sqlFilePath);
    await db.execute(queries);
    await InitDatas().insertInitialData(db);
  }


  Future<int> insertVehicule(String id,String immatriculation, String modele, String statut) async {
    final db = await database;
    return await db.insert(
      'vehicules',
      {'id':id ,'immatriculation': immatriculation, 'modele': modele, 'statut': statut},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertChauffeur(String id,String nom, String prenom) async {
    final db = await database;
    return await db.insert(
      'chauffeurs',
      {'id':id,'nom': nom, 'prenom': prenom},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertPointage(String dateHeure, int idVehicule, int idChauffeur, double montant) async {
    final db = await database;
    return await db.insert(
      'pointages',
      {
        'date_heure': dateHeure,
        'id_vehicule': idVehicule,
        'id_chauffeur': idChauffeur,
        'montant': montant
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

}

