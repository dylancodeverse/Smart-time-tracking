import 'package:sola/domain/entity/bus_state.dart';

abstract class ICheckIn {
  Future<BusState> arrival (String assignementId , String busId, int busStateId, int amount, int lastChecking) ;

  Future<void> arrivalUpdate(String assignementId , String busId, int busStateId, int amount, int lastChecking, String comments);
}