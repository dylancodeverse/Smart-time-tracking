import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sola/data/interface/datasource/datasource.dart';

class SharedPreferencesDataSource<T> implements DataSource<T> {
  final String key; // Clé sous laquelle les données seront stockées
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  SharedPreferencesDataSource({required this.key, required this.fromJson, required this.toJson});

  Future<SharedPreferences> _prefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<void> insert(T item) async {
    final prefs = await _prefs();
    List<T> allItems = await getAll();
    allItems.add(item);
    await prefs.setString(key, jsonEncode(allItems.map(toJson).toList()));
  }

  @override
  Future<void> insertAll(List<T> items) async {
    final prefs = await _prefs();
    List<T> allItems = await getAll();
    allItems.addAll(items);
    await prefs.setString(key, jsonEncode(allItems.map(toJson).toList()));
  }

  @override
  Future<T?> getById(String id) async {
    final allItems = await getAll();
    return allItems.firstWhere(
      (item) => (toJson(item)['id'] ?? '') == id,
    );
  }

  @override
  Future<List<T>> getAll() async {
    final prefs = await _prefs();
    prefs.reload();
    final data = prefs.getString(key);
    if (data == null) return [];
    final List<dynamic> jsonList = jsonDecode(data);
    return jsonList.map((json) => fromJson(json)).toList();
  }

  @override
  Future<void> update(T item) async {
    final prefs = await _prefs();
    List<T> allItems = await getAll();
    String itemId = toJson(item)['id'] ?? '';

    allItems = allItems.map((existingItem) {
      if (toJson(existingItem)['id'] == itemId) {
        return item;
      }
      return existingItem;
    }).toList();

    await prefs.setString(key, jsonEncode(allItems.map(toJson).toList()));
  }

  @override
  Future<void> updateAndIgnoreNullColumns(T item) async {
    final prefs = await _prefs();
    List<T> allItems = await getAll();
    String itemId = toJson(item)['id'] ?? '';

    allItems = allItems.map((existingItem) {
      if (toJson(existingItem)['id'] == itemId) {
        Map<String, dynamic> updatedJson = toJson(existingItem);
        Map<String, dynamic> newJson = toJson(item);

        newJson.forEach((key, value) {
          if (value != null) {
            updatedJson[key] = value;
          }
        });

        return fromJson(updatedJson);
      }
      return existingItem;
    }).toList();

    await prefs.setString(key, jsonEncode(allItems.map(toJson).toList()));
  }

  @override
  Future<void> delete(String id) async {
    final prefs = await _prefs();
    List<T> allItems = await getAll();
    allItems.removeWhere((item) => (toJson(item)['id'] ?? '') == id);
    await prefs.setString(key, jsonEncode(allItems.map(toJson).toList()));
  }

  @override
  Future<void> runTransaction(Future<void> Function() action) async {
    // SharedPreferences ne supporte pas de transactions natives, mais on peut exécuter une action de manière atomique.
    await action();
  }
  
  @override
  Future<List<T>> getWithRawQuery(String rawQuery) {
    // TODO: implement getWithRawQuery
    throw UnimplementedError();
  }
  
  @override
  Future updateAndIgnoreNullColumnsList(List<T> item) {
    // TODO: implement updateAndIgnoreNullColumnsList
    throw UnimplementedError();
  }
}
