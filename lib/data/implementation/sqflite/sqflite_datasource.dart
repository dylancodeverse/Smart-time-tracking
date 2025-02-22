import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDataSource<T> implements DataSource<T> {
  final Database database;
  final String tableName;
  final T Function(Map<String, dynamic>) fromMap;
  final Map<String, dynamic> Function(T) toMap;

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
    await database.update(
      tableName,
      toMap(item),
      where: 'id = ?',
      whereArgs: [toMap(item)['id']],
    );
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

}
