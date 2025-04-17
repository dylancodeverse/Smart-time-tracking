import 'package:sola/domain/entity/depense/depense.dart';

abstract class IDepense {
  Future<void> save(Depense depense);
  Future<Depense> getDepenseToday();
}
