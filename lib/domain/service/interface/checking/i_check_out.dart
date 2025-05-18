
import 'package:sola/domain/entity/bus_state.dart';

abstract class ICheckOut {
  Future<BusState> departure (String assignementId , String busId, int busStateId, String pilotId) ;
}