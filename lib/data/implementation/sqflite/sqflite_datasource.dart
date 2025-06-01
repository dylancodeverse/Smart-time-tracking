import 'package:sola/application/utils/map_utils.dart';
import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDataSource<T> implements DataSource<T> {
  Database database;
  String tableName;
  T Function(Map<String, dynamic>) fromMap;
  Map<String, dynamic> Function(T) toMap;

  SQLiteDataSource({
    required this.database,
    required this.tableName,
    required this.fromMap,
    required this.toMap,
  });

  @override
  Future<int> insert(T item) async {
    return await database.insert(tableName, toMap(item));
  }

  @override
  Future<void> insertAll(List<T> items) async {
    final batch = database.batch();
    for (var item in items) {
      batch.insert(tableName, toMap(item));
    }
    await batch.commit();
  }

  @override
  Future<T?> getById(String id) async {
    final result = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return fromMap(result.first);
    }
    return null;
  }

  @override
  Future<List<T>> getAll() async {
    final result = await database.query(tableName);
    return result.map(fromMap).toList();
  }

  @override
  Future<void> update(T item) async {
    final id = toMap(item)['id'];

    if (id == null) {
      // Si l'ID est null, mettre à jour toutes les lignes de la table
      await database.update(
        tableName,
        toMap(item), // Utilise les données de l'objet `item` pour mettre à jour
      );
    } else {
      // Sinon, met à jour seulement l'enregistrement correspondant à l'ID
      await database.update(
        tableName,
        toMap(item),
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }


  @override
  Future<void> delete(String id) async {
    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  @override
  Future<void> runTransaction(Future<void> Function() action) async {
    await database.transaction((txn) async {
      await action();
    });
  }
  
  @override
  Future updateAndIgnoreNullColumns(T item) async{
    await database.update(
      tableName,
      MapUtils.removeNulls(toMap(item)),
      where: 'id = ?',
      whereArgs: [toMap(item)['id']],
    );
  }
  
  @override
  Future<List<T>> getWithRawQuery(String rawQuery) async{
    final result = await database.rawQuery(rawQuery);
    return result.map(fromMap).toList();
  }
    
  @override
  Future<void> updateAndIgnoreNullColumnsList(List<T> items) async {
    final batch = database.batch();

    for (T item in items) {
      final map = MapUtils.removeNulls(toMap(item));
      final id = map['id'];
      if (id != null) {
        batch.update(
          tableName,
          map,
          where: 'id = ?',
          whereArgs: [id],
        );
      }
    }

    await batch.commit(noResult: true);
  }


}
