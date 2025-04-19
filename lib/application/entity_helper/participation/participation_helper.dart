import 'package:sola/domain/entity/participation/participation.dart';

class ParticipationHelper {
  // Convert an instance to a Map for database insertion
  static Map<String, dynamic> toMap(Participation participation) {

    Map<String,dynamic> map = {
      'id_vehicule': participation.busId,
      'PARTICIPATION_date': participation.participationDate,
      'montant': participation.amount,
      'comments':participation.comments,
      'id_PAYMENTPARTICIPATION' : participation.superParticipation

    };
    if (participation.id!=null) {
      map['id']= participation.id;
    }
    return map ;
  }

  // Create an instance from a Map
  static Participation fromMap(Map<String, dynamic> map) {
    return Participation(
      id: map['id'],
      busId: map['id_vehicule'],
      participationDate: map['PARTICIPATION_date'],
      amount: map['montant'],
      comments: map['comments'],
      superParticipation: map['id_PAYMENTPARTICIPATION']
    );
  }
}