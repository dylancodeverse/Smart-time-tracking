import 'package:flutter/services.dart';
import 'package:sola/data/helper/sqflite/sqflite_database.dart';
import 'package:sqflite/sqflite.dart';

class ServiceInitdb {
  static initSQFlite(bool reset)async{
    final dbPath = await SqfliteDatabaseHelper.getDbPath();
    if(reset){
      await deleteDatabase(dbPath); // Supprime l'ancienne base
    }
    await  SqfliteDatabaseHelper().database;

  }

  static Future<void> synchronizeImportedData() async {
    Database db = await SqfliteDatabaseHelper().database;

    // 1. Charger le contenu du fichier SQL depuis les assets
    String sqlScript = await rootBundle.loadString('assets/sql/import.sql');

    // 2. Découper les requêtes si plusieurs séparées par ;
    List<String> queries = sqlScript.split(';');

    // 3. Exécuter chaque requête non vide
    for (var query in queries) {
      String trimmed = query.trim();
      if (trimmed.isNotEmpty) {
        await db.execute(trimmed);
      }
    }
  }
  
}