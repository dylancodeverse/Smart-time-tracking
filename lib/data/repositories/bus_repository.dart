import '../datasources/bus_db.dart';
import '../models/bus.dart';

class BusRepository {
  // Crée une instance privée statique
  static final BusRepository _instance = BusRepository._internal(BusDB());

  // Instance de BusDB, qui est injectée dans le constructeur
  final BusDB busDB;

  // Constructeur privé pour empêcher la création d'instances en dehors de la classe
  BusRepository._internal(this.busDB);

  // Factory pour retourner l'instance unique
  factory BusRepository() {
    return _instance;
  }

  // Méthode pour récupérer la liste des bus
  Future<List<Bus>> getBus() => busDB.getBus();
}
