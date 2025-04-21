
import 'package:flutter/material.dart';
import 'package:sola/domain/service/implementation/import_export/export.dart';

class ExportUIService extends ChangeNotifier{
  final ExportService exportService;

  ExportUIService(this.exportService);

  Future<void> export() async {
    await exportService.exportToFile();
  }
}
