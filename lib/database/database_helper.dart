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
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'traffic_management.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE vehicules (
        id TEXT PRIMARY KEY,
        immatriculation TEXT NOT NULL UNIQUE,
        modele TEXT NOT NULL,
        statut INTEGER NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE chauffeurs (
        id TEXT PRIMARY KEY,
        nom TEXT NOT NULL,
        prenom TEXT NOT NULL,
        UNIQUE(nom, prenom)
      );
    ''');

    await db.execute('''
      CREATE TABLE copilote (
        id TEXT PRIMARY KEY,
        nom TEXT NOT NULL,
        prenom TEXT NOT NULL,
        UNIQUE(nom, prenom)
      );
    ''');

    await db.execute('''
      CREATE TABLE affectations (
        id TEXT PRIMARY KEY,
        date TEXT NOT NULL,
        id_vehicule TEXT NOT NULL,
        id_chauffeur TEXT NOT NULL,
        id_copilote TEXT,
        is_default int ,
        FOREIGN KEY (id_vehicule) REFERENCES vehicules(id),
        FOREIGN KEY (id_chauffeur) REFERENCES chauffeurs(id),
        FOREIGN KEY (id_copilote) REFERENCES chauffeurs(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE pointages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date_arrivee INTEGER NOT NULL,
        date_depart INTEGER ,
        id_vehicule TEXT NOT NULL,
        id_chauffeur TEXT NOT NULL,
        montant REAL NOT NULL,
        commentaires TEXT,
        FOREIGN KEY (id_vehicule) REFERENCES vehicules(id),
        FOREIGN KEY (id_chauffeur) REFERENCES chauffeurs(id)
      );
    ''');
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

