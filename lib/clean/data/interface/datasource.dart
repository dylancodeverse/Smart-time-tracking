//  contrat commun pour tous les accès aux bases de données.
abstract class DataSource<T> {
  Future<void> insert(T item);
  Future<void> insertAll(List<T> items);
  Future<T?> getById(String id);
  Future<List<T>> getAll();
  Future<void> update(T item);
  Future<void> delete(String id);

}
