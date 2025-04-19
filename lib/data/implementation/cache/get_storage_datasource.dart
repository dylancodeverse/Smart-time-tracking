import 'package:get_storage/get_storage.dart';
import 'package:sola/data/interface/datasource/datasource.dart';

typedef ToJson<T> = Map<String, dynamic> Function(T item);
typedef FromJson<T> = T Function(Map<String, dynamic> json);

class GetStorageDataSource<T> implements DataSource<T> {
  final GetStorage _box;
  final String key;
  final ToJson<T> toJson;
  final FromJson<T> fromJson;

  GetStorageDataSource({
    required this.key,
    required this.toJson,
    required this.fromJson,
    required GetStorage box,
  }) : _box = box;

  @override
  Future<T?> getById(String id) async {
    // Pas applicable ici, on ignore le paramètre 'id' et retourne la seule valeur.
    final json = _box.read(key);
    if (json == null) return null;
    return fromJson(Map<String, dynamic>.from(json));
  }

  @override
  Future<List<T>> getAll() async {
    final json = _box.read(key);
    if (json == null) return [];
    return [fromJson(Map<String, dynamic>.from(json))];
  }

  @override
  Future insert(T item) async {
    await _box.write(key, toJson(item));
    await _box.save(); //  sauvegarde sur disque
    return true;
  }

  @override
  Future insertAll(List<T> items) async {
    // Écrase avec le dernier élément (car on stocke un seul objet)
    throw UnimplementedError();
  }

  @override
  Future update(T item) async {
    await _box.write(key, toJson(item));
    await _box.save(); //  sauvegarde sur disque
    return true;
  }

  @override
  Future updateAndIgnoreNullColumns(T item) async {
    final existing = _box.read(key);
    Map<String, dynamic> current = existing != null
        ? Map<String, dynamic>.from(existing)
        : {};
    final updateData = toJson(item);

    updateData.forEach((key, value) {
      if (value != null) {
        current[key] = value;
      }
    });

    await _box.write(key, current);
    await _box.save(); //  sauvegarde sur disque    
    return true;
  }

  @override
  Future delete(String id) async {
    // On ignore le paramètre `id` ici, car on supprime la seule donnée existante
    await _box.remove(key);
    await _box.save(); //  sauvegarde sur disque    
    return true;
  }

  @override
  Future runTransaction(Future<void> Function() action) async {
    await action();
    await _box.save(); //  sauvegarde sur disque    
    return true;
  }
}
