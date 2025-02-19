import 'package:sola/data/localdatabase/access_helper.dart';
import 'package:sola/data/models/pointage/pointage.dart';
import 'package:sqflite/sqflite.dart';

class PointagesDB {
  static final PointagesDB _instance = PointagesDB._internal();

  Database ? _db;

  PointagesDB._internal();

  factory PointagesDB(){
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


  Future<List<Pointages>> getPointages() async {
    final db = await database; 
    final List<Map<String, dynamic>> maps = await db.query('pointages');
    return List.generate(maps.length, (i) => Pointages.fromMap(maps[i]));
  }
  Future<int> savePointages(Map<String,dynamic>  pointage) async{
    final db= await database;
    return await db.insert("pointages", pointage);
  }

  Future<int> updatePointages(Map<String, dynamic> pointage) async {
  final db = await database;
  return await db.update(
    'pointages',
    pointage,
    where: 'id = ?',
    whereArgs: [pointage['id']],
  );
}


}
