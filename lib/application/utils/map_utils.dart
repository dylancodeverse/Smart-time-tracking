class MapUtils {
  static Map<String, dynamic> removeNulls(Map<String, dynamic> map) {
    return Map.fromEntries(map.entries.where((entry) => entry.value != null));
  }
}