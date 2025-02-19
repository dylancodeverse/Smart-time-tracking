import 'package:sola/data/datasources/pointages_db.dart';
import 'package:sola/data/models/pointage/pointage.dart';

class PointagesRepository {
  static final PointagesRepository _instance = PointagesRepository._internal(PointagesDB());

  final PointagesDB pointagesDB;

  PointagesRepository._internal(this.pointagesDB);

  factory PointagesRepository() {
    return _instance;
  }

  Future<int> saveBusPointages(Pointages pointage) async {
    int id = await pointagesDB.savePointages(pointage.toMap());
    pointage.id = id;
    return id;
  }

  Future<int> updateBusPointages(Pointages pointage) async {
    if (pointage.id == null) {
      throw Exception("Impossible de mettre à jour un pointage sans ID.");
    }
    print(pointage.toMap()); 
    return await pointagesDB.updatePointages(pointage.mapTerminerTour());
  }
}
