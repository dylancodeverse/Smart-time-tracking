class Vehicle {
  final String id;
  final String immatriculation;
  final String modele;
  final int statut;

  Vehicle({
    required this.id,
    required this.immatriculation,
    required this.modele,
    required this.statut,
  });

  String get libStatut => statut==1 ? "En Activité" : "Hors Service" ;

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      immatriculation: map['immatriculation'],
      modele: map['modele'],
      statut: map['statut'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'immatriculation': immatriculation,
      'modele': modele,
      'statut': statut,
    };
  }
}
