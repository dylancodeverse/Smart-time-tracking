import 'package:sola/domain/entity/bus_state.dart';

abstract class ICheckIn {
  Future<BusState> arrival (String assignementId , int busStateId, int amount, int lastChecking) ;
}