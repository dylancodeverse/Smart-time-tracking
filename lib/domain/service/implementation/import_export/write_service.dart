import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:sola/domain/service/interface/import_export/export.dart';

class WriteService implements IWriteService {
  @override
  Future<void> exportToFile(String content) async {
    // Utilisation de file_picker pour choisir où sauvegarder le fichier
    String? outputPath = await  FilePicker.platform.saveFile(
      bytes: utf8.encode(content),
      fileName:  '${DateTime.now()}.txt',
    );
    if (outputPath != null) {
      final file = File(outputPath);
      await file.writeAsString(content);
    } 
  }
}
