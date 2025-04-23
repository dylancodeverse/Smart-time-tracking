import 'package:sola/domain/entity/complete_participation/complete_participation.dart';

class CompleteParticipationHelper {
  static CompleteParticipation fromMap(Map<String, dynamic> map) {
    return CompleteParticipation(
      participationDate: map['PARTICIPATION_date'],
      registration: map['immatriculation'],
      amount: map['montant'],
      comments: map['comments'],
      paymentReference: map['reference_paiement'],
      paymentDate: map['date_paiement'],
    );
  }

  static Map<String, dynamic> toMap(CompleteParticipation entity) {
    return {
      'PARTICIPATION_date': entity.participationDate,
      'immatriculation': entity.registration,
      'montant': entity.amount,
      'comments': entity.comments,
      'reference_paiement': entity.paymentReference,
      'date_paiement': entity.paymentDate,
    };
  }
}
