import 'dart:io';

abstract class FileImportService {
  Future<void> importFile(File file);

}