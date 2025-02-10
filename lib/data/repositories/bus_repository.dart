import '../datasources/bus_db.dart';
import '../models/bus.dart';

class BusRepository {
  final BusDB busDB;

  BusRepository(this.busDB);

  Future<List<Bus>> getBus() => busDB.getBus();
}
