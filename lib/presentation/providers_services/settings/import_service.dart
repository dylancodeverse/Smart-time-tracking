import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/domain/service/interface/import_export/i_import_data.dart';
import 'package:sola/presentation/providers_services/home/daily_statistic_list_provider.dart';

class ImportUIService extends ChangeNotifier{
  final IImportData importService;

  ImportUIService(this.importService);

  Future<void> importFromFile(File file, BuildContext context) async {
    await importService.importDatas(file);
    Provider.of<DailyStatisticListProvider>(context, listen: false).refreshList(context);
  }
}
