import 'package:sola/domain/service/implementation/import_export/write_service.dart';

class InjWriteFile {
  static WriteService getWriteService() {
    return WriteService();
  }
}