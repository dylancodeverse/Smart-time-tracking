import 'package:intl/intl.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/check.dart';
import 'package:sola/domain/entity/statistics/daily_statisitc.dart';
import 'package:sola/global/participation.dart';
import 'package:sola/global/state_list.dart';
import 'package:sola/lib/date_helper.dart';

class DailyStatisticView {
  int round;
  int amount;
  int participationState ;
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
   required this.copilotCompleteName, required this.busStateId , required this.nextActionEstimation , required this.participationState});

  static List<DailyStatisticView> convert(List<DailyStatistic> list) {
      return list.map((dailyStatistic) {
        // Assignment (from the DailyStatistic)
        Assignment assignment = dailyStatistic.busState.lastAssignment!;
        // Check (from the DailyStatistic)
        Check? lastCheck = dailyStatistic.busState.lastCheck;

        // Returning a new DailyStatisticView instance
        return DailyStatisticView(
          round: dailyStatistic.round,
          amount: dailyStatistic.amount,
          statusCheck: dailyStatistic.busState.statusCheck!, // Assuming `etatPointage` is the status check in `Check`
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
          busStateId: dailyStatistic.busState.id!,
          nextActionEstimation: dailyStatistic.busState.nextChangeDatePrevision != null 
              ? Date.formatTimeFromMillis(dailyStatistic.busState.nextChangeDatePrevision as int) 
              : "En attente",
          participationState: dailyStatistic.busState.participationState!
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
  String isDepart(int index , Duration remainingTime){
    if( statusCheck == StateList.enableDeparture){
      if (index!=0) {
        return "Départ" ;
      }else{
        String minutes = remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0');
        String seconds = remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0');

        return "Départ dans : $minutes:$seconds";
      }
    }
    else if(statusCheck==StateList.enableArrivalDeclaration){
      return "Déclaration";
    }else{
      String minutes = remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0');
      String seconds = remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0');
      return "Arrivée dans : $minutes:$seconds";

    }
  } 

  participationActive() => participationState == ParticipationVar.showParticipation ;

  
}