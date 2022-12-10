import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../config/app_config.dart';

class GameQRScanner extends StatefulWidget {
  final Function(String) scanQr;
  const GameQRScanner({required this.scanQr, Key? key}) : super(key: key);

  @override
  State<GameQRScanner> createState() => _GameQRScannerState();
}

class _GameQRScannerState extends State<GameQRScanner> {

  late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
              children: <Widget>[Expanded(flex: 4, child: _buildQrView(context))],
            );
  }

  Widget _buildQrView(BuildContext context) {
    var minArea = min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    var scanArea = minArea / 4 * 3;
    return QRView(
      key: GlobalKey(debugLabel: 'QR'),
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        // borderColor: widget.giViewModel.getPrimaryColor(),
          borderRadius: 15,
          borderLength: 35,
          borderWidth: 45,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    print('created');
    controller.scannedDataStream.distinct((c1, c2) => c1.code == c2.code).listen((scanData) {
      if (scanData.code != null) {
        this.widget.scanQr(scanData.code!);
      }
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  @override
  void dispose() {
    print('dispose controller');
    controller.dispose();
    super.dispose();
  }

  // @override
  // Widget buildOld(BuildContext context) {
  //   var minArea = min(
  //       MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
  //   var scanArea = minArea / 4 * 3;
  //
  //   return Stack(
  //     children: [
  //       MobileScanner(
  //           allowDuplicates: false,
  //           onDetect: (barcode, args) {
  //             if (barcode.rawValue == null) {
  //               debugPrint('Failed to scan Barcode');
  //             } else {
  //               final String code = barcode.rawValue!;
  //               debugPrint('Barcode found! $code');
  //               this.widget.scanQr(code);
  //             }
  //           }),
  //       Container(
  //         decoration: new ShapeDecoration(shape: QrScannerOverlayShape(
  //             borderColor: AppConfig().themeData!.primaryColor,
  //             borderRadius: 15,
  //             borderLength: 35,
  //             borderWidth: 45,
  //             cutOutSize: scanArea
  //         )),
  //       )
  //     ],
  //   );
  // }
}
