import 'package:sola/config/sql_request_config.dart';
import 'package:sqflite/sqflite.dart';
import '../models/active_bus.dart';

class ActiveBusDB {
  final Database db;

  ActiveBusDB(this.db);

  Future<List<ActiveBus>> getActiveBus() async {
    final List<Map<String, dynamic>> maps = await db.rawQuery(SqlRequestConfig.getTodayReportRequest());
    return List.generate(maps.length, (i) => ActiveBus.fromMap(maps[i]));
  }
}
