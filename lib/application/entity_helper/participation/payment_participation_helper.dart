import 'package:sola/domain/entity/participation/payment.dart';

class PaymentParticipationHelper {

  static PaymentParticipation fromMap(Map<String, dynamic> map) {
    return PaymentParticipation(
      id: map['id'],
      montantTotal: map['montanttotal'],
      participationDate: map['PARTICIPATION_date'],
      reference: map['reference'],
    );
  }

  static Map<String, dynamic> toMap(PaymentParticipation payment) {
    final map = <String, dynamic>{
      'montanttotal': payment.montantTotal,
      'PARTICIPATION_date': payment.participationDate,
      'reference': payment.reference,
    };

    if (payment.id != null) {
      map['id'] = payment.id;
    }

    return map;
  }

  
}