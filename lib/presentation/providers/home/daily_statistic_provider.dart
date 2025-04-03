import 'package:flutter/material.dart';
import 'package:sola/application/injection_helper/check/service_bus_state.dart';
import 'package:sola/application/injection_helper/check/service_check.dart';
import 'package:sola/application/injection_helper/participation/participation_datasource.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/entity/bus_state.dart';
import 'package:sola/domain/service/interface/checking/i_check_in.dart';
import 'package:sola/domain/service/interface/checking/i_check_out.dart';
import 'package:sola/domain/service/interface/participation/i_participation.dart';
import 'package:sola/global/participation.dart';
import 'package:sola/global/state_list.dart';
import 'package:sola/presentation/providers/utils/countdownmixin.dart';
import 'package:sola/presentation/providers/home/daily_statistic_list_provider.dart';
import 'package:sola/presentation/model/stats/daily_statistic.dart';
import 'package:sola/presentation/providers/participation/participation_service.dart';

class DailyStatisticProvider with ChangeNotifier, CountdownMixin {
  DailyStatisticView bus;
  late ICheckOut checkOut;
  late ICheckIn checkIn;
  DailyStatisticListProvider dailyStatisticListProvider;
  late IParticipation iParticipation;
  int index;

  DailyStatisticProvider({
    required this.index,
    required this.bus,
    required this.dailyStatisticListProvider,
  }) {
    _initCheckOut();
    _initCheckIn();
    _initParticipation();
    initializeCountdown(bus.nextActionEstimation);
    notifyListeners();
  }

  Future<void> _initCheckOut() async {
    checkOut = await ServiceCheck.getCheckOutService();
  }

  Future<void> _initCheckIn() async {
    checkIn = await ServiceCheck.getCheckInService();
  }

  Future<void> _initParticipation() async {
    iParticipation = await ServiceINJParticipation.getIParticipationInstance();
  }

  void demarrerOuTerminerTour(BuildContext context) {
    if (bus.statusCheck == StateList.enableDeparture) {
      demarrerTour(context);
    } else if (bus.statusCheck == StateList.enableArrivalDeclaration) {
      roundDeclarationRedirect(context);
    } else {
      terminerTour(context);
    }
  }

  void terminerTour(BuildContext context) async {
    BusState newBusState = await checkIn.arrival(
      bus.assignmentID,
      bus.busID,
      bus.busStateId,
      0,
      bus.lastChecking as int,
      bus.round,
    );
    _updateBusState(newBusState,context);
  }

  void demarrerTour(BuildContext context) async {
    BusState newBusState = await checkOut.departure(
      bus.assignmentID,
      bus.busID,
      bus.busStateId,
    );
    _updateBusState(newBusState,context);
  }

  void _updateBusState(BusState newBusState, BuildContext context) {
    Map<String, dynamic> map = ServiceBusState.toMap(newBusState);
    bus.assignmentID = map['id_affectation'];
    bus.statusCheck = map['etat_pointage'];
    bus.lastChecking = map['dernier_pointage'];
    dailyStatisticListProvider.refreshList(context);
  }

  void roundDeclarationRedirect(BuildContext context) {
    Navigator.pushNamed(context, '/declaration', arguments: bus);
  }

  void participationRedirect(BuildContext context) {
    Navigator.pushNamed(context, "/participation", arguments: this);
  }

  void updateParticipation(BuildContext context, String montant, String comments) async {
    await ParticipationService.save(iParticipation, bus, int.parse(montant), comments);
    bus.participationState= ParticipationVar.okParticipation ;
    notifyListeners();
    Navigator.pop(context);
  }

  void setAssignement(BuildContext context ,Assignment assignment){
    bus.assignmentID = assignment.id!;
    bus.copilotCompleteName= "${assignment.copilot?.firstName} ${assignment.copilot?.lastName}";
    bus.driverCompleteName ="${assignment.driver?.firstName} ${assignment.driver?.lastName}";
    bus.driverId= assignment.driver!.id;
    bus.copilotId=assignment.copilot!.id;
    notifyListeners();
    Navigator.pop(context);
    
  }
}
