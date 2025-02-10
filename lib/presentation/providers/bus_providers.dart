import 'package:flutter/material.dart';
import '../../data/repositories/bus_repository.dart';
import '../../data/models/bus.dart';

class BusProvider extends ChangeNotifier {
  final BusRepository repository;
  List<Bus> _bus = [];
  bool _isLoading = false;

  List<Bus> get bus => _bus;
  bool get isLoading => _isLoading;

  BusProvider(this.repository);

  Future<void> fetchBuss() async {
    _isLoading = true;
    notifyListeners();
    _bus = await repository.getBus();
    _isLoading = false;
    notifyListeners();
  }
}
