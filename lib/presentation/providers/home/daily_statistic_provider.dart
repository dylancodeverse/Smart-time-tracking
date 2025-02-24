import 'package:flutter/material.dart';
import 'package:sola/application/check/service_bus_state.dart';
import 'package:sola/application/check/service_check.dart';
import 'package:sola/domain/entity/bus_state.dart';
import 'package:sola/domain/service/interface/i_check_in.dart';
import 'package:sola/domain/service/interface/i_check_out.dart';
import 'package:sola/global/state_list.dart';
import 'package:sola/presentation/providers/home/daily_statistic_list_provider.dart';
import 'package:sola/presentation/model/daily_statistic.dart';

class DailyStatisticProvider with ChangeNotifier{
  DailyStatisticView bus ;
  late ICheckOut checkOut;
  late ICheckIn checkIn ;
  DailyStatisticListProvider dailyStatisticListProvider;
  
  DailyStatisticProvider({required this.bus, required this.dailyStatisticListProvider}) {
    _initCheckOut(); 
    _initCheckIn();
    notifyListeners(); // Met à jour l'UI quand c'est prêt

  }


  Future<void> _initCheckOut() async {
    checkOut = await ServiceCheck.getCheckOutService();
  }

  Future<void> _initCheckIn () async{
    checkIn = await ServiceCheck.getCheckInService();
  }

  void demarrerOuTerminerTour(BuildContext context){
    if (bus.statusCheck ==StateList.enableDeparture) {
       demarrerTour();

    } else if(bus.statusCheck ==StateList.enableArrivalDeclaration){
      roundDeclarationRedirect(context);
    }else{
      terminerTour(); 
    }
  }
  
  void terminerTour() async{
    BusState newBusState = await checkIn.arrival(bus.assignmentID, bus.busID, bus.busStateId, 0, bus.lastChecking as int);
    Map<String, dynamic> map= ServiceBusState.toMap(newBusState);  
    bus.amount+=0;
    bus.round+=1;
    bus.assignmentID= map['id_affectation'];    
    bus.statusCheck= map['etat_pointage'];
    //  mis a jour de la liste
    dailyStatisticListProvider.getDailyStats();
    // notifyListeners();
  }
  
  void demarrerTour() async{
    checkOut.departure(bus.assignmentID, bus.busID,bus.busStateId);
    // domaine fait le depart
    BusState newBusState = await checkOut.departure(bus.assignmentID, bus.busID,bus.busStateId);
    // mis a jour modele de l'UI
    Map<String, dynamic> map= ServiceBusState.toMap(newBusState);  
    bus.assignmentID= map['id_affectation'];
    bus.statusCheck= map['etat_pointage'];
    bus.lastChecking = map['dernier_pointage'];    
    //  mis a jour de la liste
    dailyStatisticListProvider.getDailyStats();
    // notifyListeners();
  }

  void roundDeclarationRedirect(BuildContext context) {
    Navigator.pushNamed(context, '/declaration', arguments: bus);
  }
}