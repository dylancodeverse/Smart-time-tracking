import 'package:sqflite/sqflite.dart';
import '../models/vehicle.dart';

class VehiculeDB {
  final Database db;

  VehiculeDB(this.db);

  Future<List<Vehicle>> getVehicules() async {
    final List<Map<String, dynamic>> maps = await db.query('vehicules');
    return List.generate(maps.length, (i) => Vehicle.fromMap(maps[i]));
  }
}
