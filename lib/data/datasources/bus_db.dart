import 'package:sola/data/localdatabase/access_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../models/bus.dart';

class BusDB {
  // Instance privée statique pour le singleton
  static final BusDB _instance = BusDB._internal();

  // Variable pour stocker la base de données
  Database? _db;

  // Constructeur privé
  BusDB._internal();

  // Factory pour obtenir l'instance unique
  factory BusDB() {
    return _instance;
  }

  // Méthode pour obtenir la base de données
  Future<Database> get database async {
    // Si la base de données n'est pas encore ouverte, on l'ouvre
    if (_db != null) {
      return _db!;
    }

    // Sinon, on initialise la connexion à la base de données
    _db = await DBAccess.getDB();
    return _db!;
  }


  // Méthode pour récupérer la liste des bus
  Future<List<Bus>> getBus() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('affectations_completes');
    return List.generate(maps.length, (i) => Bus.fromMap(maps[i]));
  }
}
