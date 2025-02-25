import 'package:flutter/material.dart';
import 'package:sola/domain/service/interface/i_check_in.dart';
import 'package:sola/presentation/model/daily_statistic.dart';

class ArrivalDeclaration {

  final ICheckIn checkIn ;

  ArrivalDeclaration({required this.checkIn});

  void declaration(DailyStatisticView daily, int amount, String comments, BuildContext context) async{
    await checkIn.arrivalUpdate(daily.assignmentID, daily.busID, daily.busStateId, amount, daily.lastChecking!, comments);
    Navigator.pushNamed(context,'/');
  }
}