import 'package:sola/domain/entity/participation/today_participation.dart';

class TodayParticipationHelper {
  static TodayParticipationLib fromMap(Map<String, dynamic> map) {
    return TodayParticipationLib(
      id: map['ID'],
      idVehicule: map['id_vehicule'],
      participationDate: map['PARTICIPATION_date'],
      montant: map['montant'],
      comments: map['comments'],
      idPaymentParticipation: map['id_PAYMENTPARTICIPATION'],
      immatriculation: map['immatriculation'],
      modele: map['modele'],      
    );
  }

  static Map<String, dynamic> toMap(TodayParticipationLib participation) {
    final map = <String, dynamic>{
      'id_vehicule': participation.idVehicule,
      'PARTICIPATION_date': participation.participationDate,
      'montant': participation.montant,
      'comments': participation.comments,
      'id_PAYMENTPARTICIPATION': participation.idPaymentParticipation,
      'immatriculation': participation.immatriculation,
      'modele': participation.modele,      
    };

    map['ID'] = participation.id;
    return map;
  }
}
