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
  late ModalObject selectedItem;


  void initDatas(DailyStatisticView view, IAssignement iAssignment) async{
    String newKey = view.busID ;
    this.iAssignment= iAssignment;
    if (currentKey=="" || currentKey !=newKey) {
      List<Assignment> lst= await iAssignment.getAllByBusId() ;
      objectInit=[];
      for (Assignment element in lst) {
        ModalObject x= ModalObject(lib: getLib(element), objectInit: element,isChecked: view.copilotId== element.copilot!.id && view.driverId == element.driver!.id );
        objectInit.add(x);          
        if(view.copilotId== element.copilot!.id && view.driverId == element.driver!.id ){
          selectedItem= x;
        }
      }
      currentKey= newKey;
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
    modalButtonText= selectedItem.lib;
    notifyListeners();
  }


}