import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  final void Function(String) onScan;

  const QRScannerPage({super.key, required this.onScan});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool _isScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scanner un QR Code")),
      body: MobileScanner(
        onDetect: (capture) {
          if (_isScanned) return; // éviter les détections multiples
          final code = capture.barcodes.first.rawValue;
          if (code != null) {
            _isScanned = true;
            widget.onScan(code);
            Navigator.pop(context); // retourner à la page précédente (ex: settings)
          }
        },
      ),
    );
  }
}
