import 'package:flutter/material.dart';
import '../../data/repositories/active_bus_repository.dart';
import '../../data/models/active_bus.dart';

class ActiveBusProvider extends ChangeNotifier {
  final ActiveBusRepository repository;
  List<ActiveBus> activeBus = [];
  bool _isLoading = false;

  List<ActiveBus> get bus => activeBus;
  bool get isLoading => _isLoading;

  ActiveBusProvider(this.repository);

  Future<void> fetchActiveBuss() async {
    _isLoading = true;
    notifyListeners();
    activeBus = await repository.getActiveBus();
    _isLoading = false;
    notifyListeners();
  }
}
