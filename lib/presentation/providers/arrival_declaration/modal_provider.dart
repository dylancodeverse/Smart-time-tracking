import 'package:flutter/material.dart';
import 'package:sola/domain/service/interface/violation/i_violation.dart';
import 'package:sola/presentation/UI/widgets/modal_object.dart';

class ModalProvider with ChangeNotifier {
  late List<ModalObject> objectInit=[];
  late String currentKey="" ;
  String modalButtonText ="";
  IViolation iViolation ;

  ModalProvider({required this.iViolation});

  void initDatas(String newKey){
    // mock
    if (currentKey!=newKey || objectInit==[]) {
      objectInit=
      [
        ModalObject(lib:'Excès de vitesse',),
        ModalObject(lib:'Non-respect du feu rouge',),
        ModalObject(lib:'Stationnement interdit',),
        ModalObject(lib:'Usage du téléphone au volant'),
      ];      
      currentKey= newKey;
    }
    setTextModalButton();
  }


  void setObjectIni(ModalObject modalObject){
    for (var i = 0; i < objectInit.length; i++) {
      if (objectInit[i].lib==modalObject.lib) {
        objectInit[i].isChecked = !objectInit[i].isChecked;
        setTextModalButton();
        return;
      }
    }    
  }


  void setTextModalButton() {
    List<String> list = [];
    for (ModalObject element in objectInit) {
      if (element.isChecked) {
        list.add(element.lib);
      }
    }

    if (list.isEmpty) {
      modalButtonText= "Sélectionner une violation ";
    }else{
      modalButtonText= list.join(", ");
    }
    notifyListeners();
  }

}