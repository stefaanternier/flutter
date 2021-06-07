import 'dart:math';

import 'package:camera/camera.dart';

// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/models/general_item/scan_tag.dart';
import 'package:youplay/screens/general_item/general_item.dart';
import 'package:youplay/screens/util/utils.dart';

import 'components/themed_app_bar.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanTagWidget extends StatefulWidget {
  ScanTagGeneralItem item;
  GeneralItemViewModel giViewModel;

  ScanTagWidget({this.item, this.giViewModel});

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
//              alignment: const Alignment(-0.5, 0),
              children: <Widget>[
                new ItemQRScreen(widget.giViewModel),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                //   child: Image.asset('graphics/generalItems/scanOverlay.png'),
                // )
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
                      children: <Widget>[
//                        Container(
//                            padding: const EdgeInsets.all(10),
//                            child: Text(
//                              "${widget.item.title}",
//                              style: TextStyle(
//                                fontSize: 24,
//                                fontWeight: FontWeight.bold,
//                              ),
//                            )),
//                        Container(
//                            padding: const EdgeInsets.all(10),
//                            child: Text(
//                              "${widget.item.richText}",
//                              style: TextStyle(
//                                  fontSize: (24 /
//                                      3 *
//                                      MediaQuery.of(context).devicePixelRatio)),
//                            )),
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }
}

class ItemQRScreen extends StatefulWidget {
  GeneralItemViewModel giViewModel;

  ItemQRScreen(this.giViewModel);

  @override
  ItemQRState createState() => ItemQRState();
}

class ItemQRState extends State<ItemQRScreen> {
  ItemQRState();

  // bool _isDetecting = false;
  // bool _actionTaken = false;
  // CameraLensDirection _direction = CameraLensDirection.back;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context))
        ],
      ),
    );
  }

  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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

  bool _actionTaken = false;

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;

        print('result2 ${result.code} ${_actionTaken}');
        if (!_actionTaken) {
          new Future.delayed(const Duration(milliseconds: 100), () {
            if (!widget.giViewModel.continueToNextItemWithTag(scanData.code)) {
              new Future.delayed(const Duration(milliseconds: 200), () {
                if (!widget.giViewModel
                    .continueToNextItemWithTag(scanData.code)) {
                  Navigator.pop(context);
                }
              });
            }
          });

          widget.giViewModel.onDispatch(QrScannerAction(
              generalItemId: widget.giViewModel.item.itemId,
              runId: widget.giViewModel.run.runId,
              qrCode: scanData.code));

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
