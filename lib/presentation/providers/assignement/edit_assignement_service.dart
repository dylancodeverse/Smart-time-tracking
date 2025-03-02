import 'package:flutter/material.dart';
import 'package:sola/presentation/providers/home/daily_statistic_provider.dart';

class EditAssignementService {
  static void redirectWithBus(BuildContext context, DailyStatisticProvider activeBusProvider){
    Navigator.pushNamed(context, '/edit/assignement', arguments: activeBusProvider);
  }
}