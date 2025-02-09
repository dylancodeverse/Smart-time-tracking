import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColorLib {
  static Color getColorByStatus(int status){
    return status==1 ? Colors.green : Colors.red ; 
  }
}