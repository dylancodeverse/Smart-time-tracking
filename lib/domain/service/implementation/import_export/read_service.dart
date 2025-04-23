import 'dart:io';

import 'package:sola/domain/service/interface/import_export/import.dart';

class ReadService implements FileImportService{
  @override
  Future<String> importFile(File file) async {

    return await file.readAsString();

  }
}
