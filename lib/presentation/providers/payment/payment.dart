import 'package:flutter/material.dart';

class PaymentService extends ChangeNotifier {
  String _reference = "";

  String get reference => _reference;

  void setReference(String newRef) {
    _reference = newRef;
    notifyListeners();
  }  
}