import 'dart:convert';

import 'package:sola/application/entity_helper/complete_participation/complete_participation_helper.dart';
import 'package:sola/application/entity_helper/complete_violation/complete_violation_helper.dart';
import 'package:sola/application/entity_helper/depense/depense_helper.dart';
import 'package:sola/domain/entity/complete_participation/complete_participation.dart';
import 'package:sola/domain/entity/complete_violation/complete_violation.dart';
import 'package:sola/domain/entity/depense/depense.dart';
import 'package:sola/domain/service/implementation/import_export/write_service.dart';
import 'package:sola/domain/service/interface/complete_participation/i_complete_participation.dart';
import 'package:sola/domain/service/interface/complete_violation/i_complete_violation.dart';
import 'package:sola/domain/service/interface/depense/i_depense.dart';
import 'package:sola/domain/service/interface/import_export/i_export_data.dart';
import 'package:sola/global/keys_export.dart';

class ExportData implements IExportData {

  WriteService writeService ;

  ICompleteParticipationService completeParticipationService ;
  ICompleteViolationService violationService;
  IDepense depenseService;



  ExportData({required this.writeService, required this.completeParticipationService, required this.violationService
              , required this.depenseService});

  String _exportMultipleToJson(
      List<List<Object>> data, 
      List<Map<String, dynamic> Function(Object objet)> toMapFunctions, 
      List<String> keys) {
    // Conversion de chaque liste d'objets en liste de maps
    List<List<Map<String, dynamic>>> jsonList = data.map((list) {
      return list.map((item) => toMapFunctions[data.indexOf(list)](item)).toList();
    }).toList();

    // Créer un Map avec les clés spécifiques
    Map<String, List<Map<String, dynamic>>> jsonMap = {};
    for (int i = 0; i < keys.length; i++) {
      jsonMap[keys[i]] = jsonList[i];
    }

    // Conversion en JSON
    String jsonString = jsonEncode(jsonMap);
    return jsonString;
  }

  Future<void> _exportToFile(
      List<List<Object>> data, 
      List<Map<String, dynamic> Function(Object objet)> toMapFunctions, 
      List<String> keys) async{
    await writeService.exportToFile(_exportMultipleToJson(data, toMapFunctions, keys));
  }

  @override
  Future<void> exportDatas() async {
    // Récupérer les données des services
    List<List<Object>> data = [
      await completeParticipationService.getAll(),
      await violationService.getAll(),
      await depenseService.getAll()
    ];

    // Définir les fonctions de conversion pour chaque type d'objet
    List<Map<String, dynamic> Function(Object objet)> toMapFunctions = [
      (objet) => CompleteParticipationHelper.toMap(objet as CompleteParticipation),
      (objet) => CompleteViolationHelper.toMap(objet as CompleteViolation),
      (objet) => DepenseHelper.toMap(objet as Depense)
    ];

    // Définir les clés pour le JSON
    List<String> keys = [KeysImportExport.completeParticipation, KeysImportExport.completeViolation, KeysImportExport.depense];

    // Exporter les données au format JSON
    await _exportToFile(data, toMapFunctions, keys);
    

  }

}