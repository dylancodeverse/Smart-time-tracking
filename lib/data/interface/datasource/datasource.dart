//  contrat commun pour tous les accès aux bases de données.
abstract class DataSource<T> {
  Future<dynamic> insert(T item);
  Future<dynamic> insertAll(List<T> items);
  Future<T?> getById(String id);
  Future<List<T>> getAll();
  Future<List<T>> getWithRawQuery(String rawQuery) ;
  Future<dynamic> update(T item);
  Future<dynamic> updateAndIgnoreNullColumns(T item);
  Future<dynamic> updateAndIgnoreNullColumnsList(List<T> item);
  Future<dynamic> delete(String id);
  Future<dynamic> runTransaction(Future<void> Function() action);

}
