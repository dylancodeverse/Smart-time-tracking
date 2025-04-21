import 'package:sola/domain/entity/depense/depense.dart';

abstract class IDepense {
  Future<void> save(Depense depense);
  Future<List<Depense>> getAll();
  Future<void> update(Depense depense);
}
