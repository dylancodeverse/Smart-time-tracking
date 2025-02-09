import '../datasources/vehicule_db.dart';
import '../models/vehicle.dart';

class VehiculeRepository {
  final VehiculeDB vehiculeDB;

  VehiculeRepository(this.vehiculeDB);

  Future<List<Vehicle>> getVehicules() => vehiculeDB.getVehicules();
}
