import 'package:flutter/material.dart';
import 'package:sola/presentation/UI/widgets/modal_object.dart';

class ModalProvider with ChangeNotifier {
  List<ModalObject> objectInit;

  ModalProvider({required this.objectInit});

  setObjectInit(ModalObject modalObject){
    for (var i = 0; i < objectInit.length; i++) {
      if (objectInit[i].lib== modalObject.lib) {
        objectInit[i].isChecked= !objectInit[i].isChecked;
        return ;
      }
    }
  }

}