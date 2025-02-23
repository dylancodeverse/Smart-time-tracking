import 'package:intl/intl.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/check.dart';
import 'package:sola/domain/entity/statistics/daily_statisitc.dart';
import 'package:sola/lib/date_helper.dart';

class DailyStatisticView {
  int round;
  int amount;

  int statusCheck;
  int? lastChecking;

  final String registrationNumber;
  final String model;
  int status;
  final String busID;
  String assignmentID;
  String driverId;
  String driverCompleteName;
  String copilotId;
  String copilotCompleteName;
  int busStateId ;

  String nextActionEstimation; 


  DailyStatisticView({required this.round, required this.amount, required this.statusCheck, 
  this.lastChecking, required this.registrationNumber, required this.model, required this.status, 
  required this.busID, required this.assignmentID, required this.driverId, required this.driverCompleteName, required this.copilotId, 
   required this.copilotCompleteName, required this.busStateId , required this.nextActionEstimation});

  static List<DailyStatisticView> convert(List<DailyStatistic> list) {
      return list.map((dailyStatistic) {
        // Assignment (from the DailyStatistic)
        Assignment assignment = dailyStatistic.busState.lastAssignment;
        // Check (from the DailyStatistic)
        Check? lastCheck = dailyStatistic.busState.lastCheck;

        // Returning a new DailyStatisticView instance
        return DailyStatisticView(
          round: dailyStatistic.round,
          amount: dailyStatistic.amount,
          statusCheck: dailyStatistic.busState.statusCheck, // Assuming `etatPointage` is the status check in `Check`
          lastChecking: lastCheck?.id, // Assuming `id` is the last check ID
          registrationNumber: assignment.bus?.registrationNumber ?? "",
          model: assignment.bus?.model ?? "" ,
          status: assignment.bus?.status ?? 2, 
          busID: assignment.bus?.id ?? "",         
          assignmentID: assignment.id ?? "",      
          driverId: assignment.driver?.id ?? "",   
          driverCompleteName: "${assignment.driver?.firstName} ${assignment.driver?.lastName}",
          copilotId: assignment.copilot?.id ?? "" , 
          copilotCompleteName: "${assignment.copilot?.firstName} ${assignment.copilot?.lastName}" ,
          busStateId: dailyStatistic.busState.id,
          nextActionEstimation: dailyStatistic.busState.nextChangeDatePrevision != null 
              ? Date.formatTimeFromMillis(dailyStatistic.busState.nextChangeDatePrevision as int) 
              : "En attente",

        );
      }).toList();
    }

  String getLibAmount() {
    var formatter = NumberFormat('#,##0');
    // Formater le nombre
    String formattedNumber = formatter.format(amount);
    return "$formattedNumber AR";

  }

  getLibRound() {
    return "Tours: $round";
  }

  libStatus() => status ==1 ? "En Activité" : "Hors Service" ;
  isDepart() => statusCheck != 0 ? "Arrivée" : "Départ";

  participationActive() => round >= 2 ;
}