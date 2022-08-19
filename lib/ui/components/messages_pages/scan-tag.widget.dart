import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:youplay/models/general_item/scan_tag.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class ScanTagWidget extends StatefulWidget {
  final ScanTagGeneralItem item;
  final Function(String) onResult;

  ScanTagWidget({required this.item, required this.onResult, Key? key}) : super(key: key);

  @override
  State<ScanTagWidget> createState() => _ScanTagWidgetState();
}

class _ScanTagWidgetState extends State<ScanTagWidget> {
  late QRViewController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ThemedAppbarContainer(title: widget.item.title, elevation: true),
        body: WebWrapper(
            child: Column(
          children: <Widget>[Expanded(flex: 4, child: _buildQrView(context))],
        )));
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
        widget.onResult(scanData.code!);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
