import 'dart:math';

import 'package:camera/camera.dart';

// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item/scan_tag.dart';
import 'package:youplay/screens/general_item/general_item.dart';
import 'package:youplay/screens/util/utils.dart';

import 'components/themed_app_bar.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanTagWidget extends StatefulWidget {
  ScanTagGeneralItem item;
  GeneralItemViewModel giViewModel;

  ScanTagWidget({required this.item, required this.giViewModel});

  @override
  _ScanTagWidgetState createState() => new _ScanTagWidgetState();
}

class _ScanTagWidgetState extends State<ScanTagWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ThemedAppBar(title: widget.item.title, elevation: true),
        body: Stack(
          alignment: const Alignment(0, 0.9),
          children: [
            Stack(
              fit: StackFit.expand,
              children: <Widget>[
                new ItemQRScreen(giViewModel: widget.giViewModel),
              ],
            ),
            Opacity(
                opacity: 0.9,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[],
                    ),
                  ),
                )),
          ],
        ));
  }
}

class ItemQRScreen extends StatefulWidget {
  GeneralItemViewModel giViewModel;

  ItemQRScreen({required this.giViewModel});

  @override
  ItemQRState createState() => ItemQRState();
}

class ItemQRState extends State<ItemQRScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool _actionTaken = false;

  ItemQRState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[Expanded(flex: 4, child: _buildQrView(context))],
      ),
    );
  }



  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    //  print('w ${MediaQuery.of(context).size.width}  h ${MediaQuery.of(context).size.height}' );
    var minArea = min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    var scanArea = minArea / 4 * 3;
    // var scanArea = (MediaQuery.of(context).size.width < 400 ||
    //         MediaQuery.of(context).size.height < 400)
    //     ? 200.0
    //     : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: widget.giViewModel.getPrimaryColor(),
          borderRadius: 15,
          borderLength: 35,
          borderWidth: 45,
          cutOutSize: scanArea),
    );
  }



  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;

        if (!_actionTaken) {
          new Future.delayed(const Duration(milliseconds: 100), () {
            if (!widget.giViewModel.continueToNextItemWithTag(scanData.code)) {
              new Future.delayed(const Duration(milliseconds: 200), () {
                if (!widget.giViewModel.continueToNextItemWithTag(scanData.code)) {
                  Navigator.pop(context);
                }
              });
            }
          });
          if (widget.giViewModel.item != null && widget.giViewModel.run?.runId != null) {
            widget.giViewModel.onDispatch(QrScannerAction(
                generalItemId: widget.giViewModel.item!.itemId,
                runId: widget.giViewModel.run!.runId!,
                qrCode: scanData.code));
          }

          _actionTaken = true;
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
