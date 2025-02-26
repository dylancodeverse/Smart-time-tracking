import 'package:flutter/material.dart';
import 'package:sola/domain/service/interface/checking/i_check_in.dart';
import 'package:sola/domain/service/interface/violation/i_violation_checking.dart';
import 'package:sola/presentation/model/stats/daily_statistic.dart';

class ArrivalDeclaration {

  final ICheckIn checkIn ;
  final IViolationChecking iViolationChecking;
  ArrivalDeclaration({required this.checkIn, required this.iViolationChecking});

  void declaration(DailyStatisticView daily, int amount, String comments, BuildContext context) async{
    await checkIn.arrivalUpdate(daily.assignmentID, daily.busID, daily.busStateId, amount, daily.lastChecking!, comments);
    Navigator.pushNamed(context,'/');
  }
  
}