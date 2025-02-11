import 'package:sola/data/models/active_bus.dart';
import '../datasources/active_bus_db.dart';

class ActiveBusRepository {
  final ActiveBusDB busDB;

  ActiveBusRepository(this.busDB);

  Future<List<ActiveBus>> getActiveBus() => busDB.getActiveBus();
}
