
import 'package:sola/data/datasources/etat_voiture_db.dart';
import 'package:sola/data/models/etat/etat_voiture.dart';

class EtatVoitureRepository {
  // Instance privée statique pour le singleton
  static final EtatVoitureRepository _instance = EtatVoitureRepository._internal();

  // Constructeur privé
  EtatVoitureRepository._internal();

  // Factory pour obtenir l'instance unique
  factory EtatVoitureRepository() {
    return _instance;
  }

  // Méthode pour insérer un état
  Future<int> insertEtatVoiture(EtatVoiture etatVoiture) async {
    return await EtatVoitureDB().insertEtatVoiture(etatVoiture);
  }

  // Méthode pour récupérer tous les états
  Future<List<EtatVoiture>> getAllEtatVoitures() async {
    return await EtatVoitureDB().getAllEtatVoitures();
  }

  // Méthode pour mettre à jour un état
  Future<int> updateEtatVoiture(EtatVoiture etatVoiture) async {
    return await EtatVoitureDB().updateEtatVoiture(etatVoiture);
  }

}
