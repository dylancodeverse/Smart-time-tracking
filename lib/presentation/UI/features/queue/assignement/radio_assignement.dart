import 'package:flutter/material.dart';
import 'package:sola/domain/entity/assignement.dart';
import 'package:sola/domain/service/interface/assignement/i_assignement.dart';
import 'package:sola/presentation/UI/widgets/modal_object.dart';
import 'package:sola/presentation/model/stats/daily_statistic.dart';

class RadioAssignmentProvider with ChangeNotifier {
  late List<ModalObject> objectInit=[];
  late String currentKey="" ;
  String modalButtonText ="";
  late IAssignement iAssignment ;
  ModalObject? selectedItem;


Future<void> initDatas(DailyStatisticView view, IAssignement iAssignment) async {
  String newKey = view.busID;
  this.iAssignment = iAssignment;

  if (currentKey == "" || currentKey != newKey) {
    List<Assignment> lst = await iAssignment.getAllByBusId();
    objectInit = [];

    ModalObject? defaultItem;

    for (Assignment element in lst) {
      ModalObject x = ModalObject(
        lib: getLib(element),
        objectInit: element,
        isChecked: view.copilotId == element.copilot!.id && view.driverId == element.driver!.id,
      );
      objectInit.add(x);

      if (x.isChecked) {
        selectedItem = x;
      }

      // Stock un fallback au cas où aucun ne match
      defaultItem ??= x;
    }

    // Si rien ne match => prendre un par défaut
    selectedItem = selectedItem ?? defaultItem!;
    currentKey = newKey;
  }

  setTextModalButton();
}

  String getLib(Assignment assignation){
    return "Chaffeur: ${assignation.driver!.firstName}  et copilote ${assignation.copilot!.firstName} "; 
  }


  void setObjectIni(ModalObject modalObject){
    selectedItem = modalObject;
    notifyListeners();
  }


  void setTextModalButton() {
    modalButtonText = selectedItem?.lib ?? '';
    notifyListeners();
  }


}