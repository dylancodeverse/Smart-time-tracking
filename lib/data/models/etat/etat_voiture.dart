class EtatVoiture {
  final int? id;
  int etatPointage; // 0 pour départ, 1 pour arrivée
  final String idVehicule;
  String idAffectation;
  int ? dernierPointage ;

  EtatVoiture({
    this.id,
    required this.etatPointage,
    required this.idVehicule,
    required this.idAffectation,
    required this.dernierPointage
  });

  // Convertir une map en un objet EtatVoiture
  factory EtatVoiture.fromMap(Map<String, dynamic> map) {
    return EtatVoiture(
      id: map['id'],
      etatPointage: map['etat_pointage'],
      idVehicule: map['id_vehicule'],
      idAffectation: map['id_affectation'],
      dernierPointage: map['dernier_pointage']
    );
  }

  // Convertir un objet EtatVoiture en map
  Map<String, dynamic> toMap() {
    return {
      'etat_pointage': etatPointage,
      'id_vehicule': idVehicule,
      'id_affectation': idAffectation,
      'dernier_pointage': dernierPointage
    };
  }
}
