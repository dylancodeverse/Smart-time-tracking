import 'package:flutter/material.dart';
import '../../data/models/active_bus.dart';

class ActiveBusProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  ActiveBus _activeBus;

  ActiveBusProvider(this._activeBus);

  ActiveBus get activeBus => _activeBus;

  void demarrerTour() {
    _activeBus.isDepart = true;
    notifyListeners();
  }

  void terminerTour() {
    _activeBus.isDepart = false;
    _activeBus.nombreTours+=1;
    notifyListeners();
  }
}
