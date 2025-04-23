
import 'package:flutter/material.dart';
import 'package:sola/domain/service/interface/import_export/i_export_data.dart';

class ExportUIService extends ChangeNotifier{
  final IExportData exportService;

  ExportUIService(this.exportService);

  Future<void> export() async {
    await exportService.exportDatas();
  }
}
