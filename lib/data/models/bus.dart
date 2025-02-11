class Bus {
  final String affectationId;
  final String affectationDate;
  final String vehiculeId;
  final String immatriculation;
  final String modele;
  final int statut;
  final String chauffeurId;
  final String chauffeurNom;
  final String chauffeurPrenom;
  final String copiloteId;
  final String copiloteNom;
  final String copilotePrenom;    

  Bus({
    required this. affectationId,
    required this. affectationDate,
    required this. vehiculeId,
    required this. immatriculation,
    required this. modele,
    required this. statut,
    required this. chauffeurId,
    required this. chauffeurNom,
    required this. chauffeurPrenom,
    required this. copiloteId,
    required this. copiloteNom,
    required this. copilotePrenom
  }) ;

  String get libStatut => statut==1 ? "En Activité" : "Hors Service" ;
  String get chauffeurNomPrenom => "$chauffeurNom $chauffeurPrenom" ;

// Factory constructors
  // When encountering one of following two cases of implementing a constructor, use the factory keyword:
    //1 The constructor doesn't always create a new instance of its class. Although a factory constructor cannot return null, it might return:
        // an existing instance from a cache instead of creating a new one
        // a new instance of a subtype
    //2 You need to perform non-trivial work prior to constructing an instance. This could include checking arguments or doing any other processing that cannot be handled in the initializer list.
  factory Bus.fromMap(Map<String, dynamic> map) {
    return Bus(
      affectationId:map ['affectation_id'],
      affectationDate:map ['affectation_date'],
      vehiculeId:map ['vehicule_id'],
      immatriculation:map ['immatriculation'],
      modele:map ['modele'],
      statut:map ['statut'],
      chauffeurId:map ['chauffeur_id'],
      chauffeurNom:map ['chauffeur_nom'],
      chauffeurPrenom:map ['chauffeur_prenom'],
      copiloteId:map ['copilote_id'],
      copiloteNom:map ['copilote_nom'],
      copilotePrenom:map ['copilote_prenom'],
    );
  }



}