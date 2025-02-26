import 'package:flutter/material.dart';
import 'package:sola/domain/entity/violation/violation.dart';
import 'package:sola/domain/service/interface/checking/i_check_in.dart';
import 'package:sola/presentation/model/stats/daily_statistic.dart';

class ArrivalDeclaration {

  final ICheckIn checkIn ;
  ArrivalDeclaration({required this.checkIn});

  void declaration(DailyStatisticView daily, int amount, String comments, List<Violation> violation ,BuildContext context) async{
    await checkIn.arrivalUpdate(daily.assignmentID, daily.busID, daily.busStateId, amount, daily.lastChecking!, comments,violation);
    Navigator.pushNamed(context,'/');
  }
  
}