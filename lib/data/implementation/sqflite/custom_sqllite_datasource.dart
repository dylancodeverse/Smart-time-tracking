import 'package:sola/data/interface/datasource/datasource.dart';
import 'package:sqflite/sqflite.dart';

class CustomSqlliteDatasource<T> implements DataSource<T> {
  final Database database;
  final String rawQuery;
  final T Function(Map<String, dynamic>) fromMap;

  CustomSqlliteDatasource({
    required this.database,
    required this.rawQuery,
    required this.fromMap,
  });

  @override
  Future<List<T>> getAll() async {
    final result = await database.rawQuery(rawQuery);
    final result1= await database.rawQuery("select *  from vehicules");
    return result.map(fromMap).toList();
  }

  // On désactive les autres méthodes pour ce DataSource particulier
  @override
  Future<void> insert(T item) => throw UnimplementedError();
  @override
  Future<void> insertAll(List<T> items) => throw UnimplementedError();
  @override
  Future<T?> getById(String id) => throw UnimplementedError();
  @override
  Future<void> update(T item) => throw UnimplementedError();
  @override
  Future<void> delete(String id) => throw UnimplementedError();
  @override
  Future<void> runTransaction(Future<void> Function() action) => throw UnimplementedError();
  
  @override
  Future updateAndIgnoreNullColumns(T item) => throw UnimplementedError();
  
  
}
