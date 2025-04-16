import 'package:get_storage/get_storage.dart';
import 'package:sola/data/interface/datasource/datasource.dart';

typedef ToJson<T> = Map<String, dynamic> Function(T item);
typedef FromJson<T> = T Function(Map<String, dynamic> json);

class GetStorageDataSource<T> implements DataSource<T> {
  final GetStorage _box;
  final String _collectionKey;
  final ToJson<T> toJson;
  final FromJson<T> fromJson;

  GetStorageDataSource({
    required String collectionKey,
    required this.toJson,
    required this.fromJson,
    required GetStorage box
  })  : _collectionKey = collectionKey,
        _box = box;

  // Récupère les données de la collection, si la clé n'existe pas, retourne une map vide.
  Future<Map<String, dynamic>> _getCollection() async {
    return Map<String, dynamic>.from(_box.read(_collectionKey) ?? {});
  }

  // Sauvegarde ou remplace l'intégralité de la collection dans la box
  Future<void> _saveCollection(Map<String, dynamic> collection) async {
    await _box.write(_collectionKey, collection);
  }

  @override
  Future<dynamic> insert(T item) async {
    final data = await _getCollection(); // Récupère la collection actuelle
    data[getCollectionKey(item)] = toJson(item); // Remplace la valeur sous la collectionKey
    await _saveCollection(data); // Sauvegarde les données après modification
    return true;
  }

  @override
  Future<dynamic> insertAll(List<T> items) async {
    final data = await _getCollection(); // Récupère la collection actuelle
    for (var item in items) {
      data[getCollectionKey(item)] = toJson(item); // Remplace la valeur sous la collectionKey
    }
    await _saveCollection(data); // Sauvegarde les données après modification
    return true;
  }

  @override
  Future<List<T>> getAll() async {
    final data = await _getCollection(); // Récupère la collection actuelle
    return data.values
        .map((e) => fromJson(Map<String, dynamic>.from(e))) // Convertit les données en objets T
        .toList();
  }

  @override
  Future<dynamic> update(T item) async {
    final data = await _getCollection(); // Récupère la collection actuelle
    data[getCollectionKey(item)] = toJson(item); // Remplace la valeur sous la collectionKey
    await _saveCollection(data); // Sauvegarde les données après modification
    return true;
  }

  @override
  Future<dynamic> updateAndIgnoreNullColumns(T item) async {
    final data = await _getCollection(); // Récupère la collection actuelle
    final current = Map<String, dynamic>.from(data[getCollectionKey(item)] ?? {});
    final updateData = toJson(item);

    // Ignore les colonnes nulles
    updateData.forEach((key, value) {
      if (value != null) {
        current[key] = value;
      }
    });

    data[getCollectionKey(item)] = current; // Sauvegarde après mise à jour
    await _saveCollection(data); // Sauvegarde les données après modification
    return true;
  }

  @override
  Future<dynamic> delete(String id) async {
    final data = await _getCollection(); // Récupère la collection actuelle
    data.remove(id); // Supprime la donnée par clé
    await _saveCollection(data); // Sauvegarde les données après suppression
    return true;
  }

  @override
  Future<dynamic> runTransaction(Future<void> Function() action) async {
    await action(); // Exécute l'action passée en paramètre
    return true;
  }

  // Cette méthode permet de récupérer la clé de collection pour chaque objet (ici basé sur la collectionKey)
  String getCollectionKey(T item) {
    return _collectionKey; // Par défaut, on retourne simplement la collectionKey
  }
  
  @override
  Future<T?> getById(String id) {
    throw UnimplementedError();
  }
}
