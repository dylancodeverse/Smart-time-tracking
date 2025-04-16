import 'package:flutter/material.dart';
import 'package:sola/domain/service/interface/participation/i_payment_participation_process_service.dart';

class PaymentService extends ChangeNotifier {

  IPaymentParticipationProcessService iPaymentParticipationProcessService ;
  String reference ;
  PaymentService({required this.iPaymentParticipationProcessService ,required this.reference});

  void setReference(String newRef) {
    iPaymentParticipationProcessService.updatePayment(newRef);
    reference = newRef ;
    notifyListeners();
  }  

}