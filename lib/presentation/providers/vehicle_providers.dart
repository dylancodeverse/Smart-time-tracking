import 'package:flutter/material.dart';
import '../../data/repositories/vehicule_repository.dart';
import '../../data/models/vehicle.dart';

class VehiculeProvider extends ChangeNotifier {
  final VehiculeRepository repository;
  List<Vehicle> _vehicules = [];
  bool _isLoading = false;

  List<Vehicle> get vehicules => _vehicules;
  bool get isLoading => _isLoading;

  VehiculeProvider(this.repository);

  Future<void> fetchVehicules() async {
    _isLoading = true;
    notifyListeners();
    _vehicules = await repository.getVehicules();
    _isLoading = false;
    notifyListeners();
  }
}
