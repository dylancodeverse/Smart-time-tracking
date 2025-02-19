import 'package:sola/data/localdatabase/access_helper.dart';
import 'package:sola/data/models/etat/etat_voiture.dart';
import 'package:sqflite/sqflite.dart';

class EtatVoitureDB {
  // Instance privée statique pour le singleton
  static final EtatVoitureDB _instance = EtatVoitureDB._internal();

  // Variable pour stocker la base de données
  Database? _db;

  // Constructeur privé
  EtatVoitureDB._internal();

  // Factory pour obtenir l'instance unique
  factory EtatVoitureDB() {
    return _instance;
  }

  // Méthode pour obtenir la base de données
  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }

    // Sinon, on initialise la connexion à la base de données
    _db = await DBAccess.getDB(); // Exemple : accédez à votre méthode pour obtenir la DB
    return _db!;
  }

  // Insérer un état dans la base de données
  Future<int> insertEtatVoiture(EtatVoiture etatVoiture) async {
    final db = await database;
    return await db.insert('etat_voitures_actu', etatVoiture.toMap());
  }

  // Récupérer tous les états des voitures
  Future<List<EtatVoiture>> getAllEtatVoitures() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('etat_voitures_actu');
    return List.generate(maps.length, (i) => EtatVoiture.fromMap(maps[i]));
  }

  // Mettre à jour un état dans la base de données
  Future<int> updateEtatVoiture(EtatVoiture etatVoiture) async {
    final db = await database;
    return await db.update(
      'etat_voitures_actu',
      etatVoiture.toMap(),
      where: 'id_vehicule = ?',
      whereArgs: [etatVoiture.idVehicule],
    );
  }

}
