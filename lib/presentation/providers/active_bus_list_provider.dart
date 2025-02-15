import 'package:flutter/material.dart';
import '../../data/models/active_bus.dart';
import '../../data/repositories/active_bus_repository.dart';

class ActiveBusListProvider with ChangeNotifier {
  final ActiveBusRepository repository;

  bool _isLoading = false;

  List<ActiveBus> _busList = [];
  List<ActiveBus> _filteredBus = [];

  bool get isLoading => _isLoading;
  List<ActiveBus> get busList => _busList;
  List<ActiveBus> get filteredBus => _filteredBus;

  ActiveBusListProvider(this.repository);
  
  void fetchActiveBusses() async{
    _isLoading = true;
    notifyListeners();
    _busList = await repository.getActiveBus();
    _filteredBus = _busList; // Par défaut, tout afficher
    _isLoading = false;
    notifyListeners();
  }

  void filterBusList(String query) {
    // ignore: avoid_print
    print("$query waouh");
    if (query.isEmpty) {      
      _filteredBus = _busList ;
    }else{
    _filteredBus = _busList
        .where((bus) => bus.bus.immatriculation.contains(query))
        .toList();
    }
    notifyListeners();
  }
}
