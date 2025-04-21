import 'dart:io';

class ImportService {
  Future<void> importFromFile(File file) async {
    try {
      final content = await file.readAsString();
      
      

      print("Fichier importé avec succès : $content");

    } catch (e) {
      print("Erreur lors de l'import : $e");
      rethrow;
    }
  }
}
