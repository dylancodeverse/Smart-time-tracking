import 'package:sola/application/injection_helper/complete_participation/inj_complete_participation.dart';
import 'package:sola/application/injection_helper/complete_violation/inj_complete_violation.dart';
import 'package:sola/application/injection_helper/depense/inj_depense.dart';
import 'package:sola/application/injection_helper/write_file/inj_write_file.dart';
import 'package:sola/domain/service/implementation/import_export/export_data.dart';
import 'package:sola/domain/service/interface/import_export/i_export_data.dart';

class InjExportData {
  static Future<IExportData> exportData() async {
    return ExportData (
                        writeService: InjWriteFile.getWriteService(),
                        completeParticipationService: await InjCompleteParticipation.getCompleteParticipationInstance(), 
                        violationService: await InjCompleteViolation.getCompleteViolationInstance(),
                        depenseService: await InjDepense.getDepenseService()
                      );
  }
}