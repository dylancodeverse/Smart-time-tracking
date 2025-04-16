import 'package:sola/domain/entity/participation/payment.dart';


abstract class IPaymentParticipation {
  Future<void> save(PaymentParticipation participation);
  Future<void> update(PaymentParticipation participation);
}
