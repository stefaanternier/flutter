import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../config/app_config.dart';

class GameQRScanner extends StatelessWidget {
  final Function(String) scanQr;
  const GameQRScanner({required this.scanQr, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var minArea = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    var scanArea = minArea / 4 * 3;

    return Stack(
      children: [
        MobileScanner(
            allowDuplicates: false,
            onDetect: (barcode, args) {
              if (barcode.rawValue == null) {
                debugPrint('Failed to scan Barcode');
              } else {
                final String code = barcode.rawValue!;
                debugPrint('Barcode found! $code');
                this.scanQr(code);
              }
            }),
        Container(
          decoration: new ShapeDecoration(shape: QrScannerOverlayShape(
              borderColor: AppConfig().themeData!.primaryColor,
              borderRadius: 15,
              borderLength: 35,
              borderWidth: 45,
              cutOutSize: scanArea
          )),
        )
      ],
    );
  }
}
