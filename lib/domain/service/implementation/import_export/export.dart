import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

class ExportService {
  Future<void> exportToFile() async {
    try {
      final data = [
        {"id": 1, "nom": "Alice"},
        {"id": 2, "nom": "Bob"},
      ];

      final jsonString = jsonEncode(data);

      // ✅ Utilisation de file_picker pour choisir où sauvegarder le fichier
      String? outputPath = await  FilePicker.platform.saveFile(
        bytes: utf8.encode('Only Flutter'),
        fileName: 'only_flutter.txt',
      );

      if (outputPath != null) {
        final file = File(outputPath);
        await file.writeAsString(jsonString);
        print("Données exportées vers : $outputPath");
      } else {
        print("Export annulé.");
      }
    } catch (e) {
      print("Erreur d'export : $e");
      rethrow;
    }
  }
}
