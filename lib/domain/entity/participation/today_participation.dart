class TodayParticipationLib {
  int id;
  String idVehicule;
  int participationDate;
  int montant;
  String comments;
  int idPaymentParticipation;
  String immatriculation;
  String modele;  

  TodayParticipationLib({
    required this.id,
    required this.idVehicule,
    required this.participationDate,
    required this.montant,
    required this.comments,
    required this.idPaymentParticipation,
    required this.immatriculation,
    required this.modele,    
  });
  TodayParticipationLib copyWith({
  int? id,
  String? idVehicule,
  int? participationDate,
  int? montant,
  String? comments,
  int? idPaymentParticipation,
  String? immatriculation,
  String? modele,
}) {
  return TodayParticipationLib(
    id: id ?? this.id,
    idVehicule: idVehicule ?? this.idVehicule,
    participationDate: participationDate ?? this.participationDate,
    montant: montant ?? this.montant,
    comments: comments ?? this.comments,
    idPaymentParticipation: idPaymentParticipation ?? this.idPaymentParticipation,
    immatriculation: immatriculation ?? this.immatriculation,
    modele: modele ?? this.modele,
  );
}

  
}