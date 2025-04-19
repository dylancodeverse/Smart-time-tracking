import 'package:sola/presentation/model/payment/payment_state_model.dart';

class PaymentScreenModel {
  String _reference ;
  PaymentStateModel paymentState ;

  PaymentScreenModel({required String reference}):
    _reference= reference  ,
    paymentState = PaymentStateModel(reference: reference)
  ;


  String getReference(){
    return _reference;
  }
  String getReferenceLabel(){
    return _reference ==""?"Référence en attente":"Référence: $_reference";

  }
  void setReference(String reference){
    _reference= reference;
    paymentState =PaymentStateModel(reference: reference);
  }
}