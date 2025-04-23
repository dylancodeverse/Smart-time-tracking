import 'package:sola/application/injection_helper/assignement/inj_complete_assignement.dart';
import 'package:sola/application/injection_helper/violation/violation_datasource.dart';
import 'package:sola/domain/service/implementation/import_export/import_data.dart';
import 'package:sola/domain/service/implementation/import_export/read_service.dart';
import 'package:sola/domain/service/interface/import_export/i_import_data.dart';

class InjImportData {
  static Future<IImportData> getImportServiceInstance() async{
    return ImportData(readService: ReadService(), completeAssignementService: await InjCompleteAssignement.getCompleteAssignementServiceWithTableName(), 
    violationService: await ViolationDatasource.getViolationServiceIMPORT());
  }
}