import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sola/tomigrate/config/database_config.dart';

class DatabaseCreator {
  Future<void> createTables(Database db) async {
    String queries = await _loadSQLFile();
    List<String> lst = queries.split(";");

    Batch batch = db.batch();
    for (var query in lst) {
      if (query.trim().isNotEmpty) {
        batch.execute(query.trim());
      }
    }
    await batch.commit();
  }

  Future<String> _loadSQLFile() async {
    return await rootBundle.loadString(DatabaseConfig.sqlFilePath);
  }
}
