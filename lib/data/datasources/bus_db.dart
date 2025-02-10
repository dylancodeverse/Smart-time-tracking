import 'package:sqflite/sqflite.dart';
import '../models/bus.dart';

class BusDB {
  final Database db;

  BusDB(this.db);

  Future<List<Bus>> getBus() async {
    final List<Map<String, dynamic>> maps = await db.query('affectations_completes');
    return List.generate(maps.length, (i) => Bus.fromMap(maps[i]));
  }
}
