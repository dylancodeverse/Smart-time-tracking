import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/features/queue/assignement/edit_assignment_helper.dart';
import 'package:sola/presentation/providers_services/home/daily_statistic_provider.dart';

class EditAssignementService {
  static void redirectWithBus(BuildContext context, DailyStatisticProvider activeBusProvider){
    showEditAssignementSheet(context, activeBusProvider);
  }
}