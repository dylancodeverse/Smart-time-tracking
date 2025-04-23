import 'dart:convert';
import 'dart:io';

import 'package:sola/application/data_init/service_init_db.dart';
import 'package:sola/application/entity_helper/assignement/complete_assignement_helper.dart';
import 'package:sola/application/entity_helper/violation/violation_helper.dart';
import 'package:sola/domain/entity/assignment/complete_assignement.dart';
import 'package:sola/domain/entity/violation/violation.dart';
import 'package:sola/domain/service/implementation/import_export/read_service.dart';
import 'package:sola/domain/service/interface/assignement/i_complete_assignement.dart';
import 'package:sola/domain/service/interface/import_export/i_import_data.dart';
import 'package:sola/domain/service/interface/violation/i_violation.dart';
import 'package:sola/global/keys_export.dart';

class ImportData implements IImportData {
  final ReadService readService;
  final ICompleteAssignement completeAssignementService;
  final IViolation violationService;

  ImportData({
    required this.readService,
    required this.completeAssignementService,
    required this.violationService,
  });

  @override
  Future<void> importDatas(File file) async {
    // Lire le contenu du fichier JSON
    final String jsonString = await readService.importFile(file);

    // Décoder le JSON en Map
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    // Recréer les objets CompleteAssignment
    final List<CompleteAssignment> assignments = (jsonMap[KeysImportExport.completeAssignmentsKey] as List)
        .map((item) => CompleteAssignmentHelper.fromMap(item))
        .toList();

    // Recréer les objets Violation
    final List<Violation> violations = (jsonMap[KeysImportExport.violationKey] as List)
        .map((item) => ViolationHelper.fromMap(item))
        .toList();

    // Enregistrer les données dans leurs services respectifs
    await completeAssignementService.saveAll(assignments);
    await violationService.saveAll(violations);
    await ServiceInitdb.synchronizeImportedData();

  }
}
