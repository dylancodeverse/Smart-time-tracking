import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sola/domain/service/implementation/import_export/import.dart';

class ImportUIService extends ChangeNotifier{
  final ImportService importService;

  ImportUIService(this.importService);

  Future<void> importFromFile(File file) async {
    await importService.importFromFile(file);
  }
}
