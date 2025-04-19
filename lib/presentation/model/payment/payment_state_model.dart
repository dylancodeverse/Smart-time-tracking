import 'package:flutter/material.dart';

class PaymentStateModel {
  String paymentState;
  IconData icon ;
  Color color ;

  PaymentStateModel({required String reference}):
    paymentState = reference=="" ? "En attente":"Payé", 
    icon = reference=="" ? Icons.timer : Icons.check_circle ,
    color = reference=="" ? Colors.black54 : Colors.green
  ;
}