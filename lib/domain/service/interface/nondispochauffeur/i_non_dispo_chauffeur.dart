import 'package:sola/domain/entity/nondispo/nondispochauffeur.dart';

abstract class INonDispoChauffeur {
    Future<List<NonDispoChauffeur>> nonDispoListe(String chauffeurId);
}