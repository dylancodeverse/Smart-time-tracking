import 'dart:io';

abstract class IImportData {
  Future<void> importDatas(File file);                            
}