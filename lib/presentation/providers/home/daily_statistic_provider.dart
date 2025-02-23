import 'package:flutter/material.dart';
import 'package:sola/application/check/service_bus_state.dart';
import 'package:sola/application/check/service_check.dart';
import 'package:sola/domain/entity/bus_state.dart';
import 'package:sola/domain/service/interface/i_check_out.dart';
import 'package:sola/presentation/providers/home/model/daily_statistic.dart';

class DailyStatisticProvider with ChangeNotifier{
  DailyStatisticView bus ;
  late ICheckOut checkOut;
  
  DailyStatisticProvider({required this.bus}) {
    _initCheckOut(); 
  }


  Future<void> _initCheckOut() async {
    checkOut = await ServiceCheck.getCheckOutService();
    notifyListeners(); // Met à jour l'UI quand c'est prêt
  }

  void demarrerOuTerminerTour(){
    bus.statusCheck !=0 ? terminerTour() : demarrerTour();
  }
  
  void terminerTour() {
    // checkIn.execute();
  }
  
  void demarrerTour() async{
    checkOut.departure(bus.assignmentID, bus.busID,2000,bus.busStateId);
    // domaine fait le depart
    BusState newBusState = await checkOut.departure(bus.assignmentID, bus.busID,2000,bus.busStateId);
    // mis a jour modele de l'UI
    print("hahah");
    Map<String, dynamic> map= ServiceBusState.toMap(newBusState);  
    print(map);
    bus.assignmentID= map['id_affectation'];
    bus.statusCheck= map['etat_pointage'];
    bus.lastChecking = map['dernier_pointage'];
    bus.assignmentID= map['id_affectation'];    
    
    notifyListeners();
  }
}