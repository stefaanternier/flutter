import 'dart:math';

import 'package:youplay/actions/actions.dart';
import 'package:youplay/actions/games.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/actions/ui.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/screens/util/navigation_drawer.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/actions/game_library.actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:youplay/screens/util/utils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';

import '../../localizations.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

Widget buildQRScanner(BuildContext context) {
  return new Scaffold(

      appBar: AppBar(
          centerTitle: true,
          title: AppConfig().appBarIcon != null ?  new Image(
        image: new AssetImage(
            AppConfig().appBarIcon),
        height: 32.0,
        width: 32.0,
      ):Text(AppLocalizations.of(context).translate('scan.scangameqr'))),
      drawer: ARLearnNavigationDrawer(),
      body: new StoreConnector<AppState, Store>(
          converter: (store) => store,
          builder: (context, store) {
            return new GameQRScreen(store);
          }));
}

class GameQRScreen extends StatefulWidget {
  final Store<AppState> store;

  GameQRScreen(this.store);

  @override
  GameQRState createState() => GameQRState(this.store);
}

class GameQRState extends State<GameQRScreen> {
  final Store<AppState> store;
  String debug = "-";

  GameQRState(this.store);

  List _scanResults;
  // CameraController _camera;

  bool _isDetecting = false;
  bool _actionTaken = false;
  bool _isProcessing = false;
  bool _navigatorTriggered = false;

  CameraLensDirection _direction = CameraLensDirection.back;




  @override
  void initState() {
    super.initState();

  }


  Widget _buildImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        constraints: const BoxConstraints.expand(),
        child: Text('test'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),

        ],
      ),
    );
  }

  bool canProcessQr(String rawValue) {
//    print("check if can process ${rawValue}");
    if (rawValue.contains('gameId=')) return true;
    if (rawValue.startsWith('account:')) return true;
    if (rawValue.startsWith('http://')) return true;
    if (rawValue.startsWith('https://')) return true;
    return false;
  }

  bool checkGameQR(rawValue) {
    return rawValue.contains('gameId');
  }

  bool checkUrl(rawValue) {
    return rawValue.startsWith('https://') || rawValue.startsWith('http://');
  }

  bool checkAccountQR(String rawValue) {
    return rawValue.startsWith('account:');
  }

  void triggerGameQr(String rawValue, Store<AppState> store) {
    String gameId = rawValue.substring(rawValue.indexOf('gameId') + 7);
//    print("game qr is ${gameId}");
    int gameIdInt = int.parse(gameId);
//    print("parsed qr is ${gameIdInt}");
    store.dispatch(LoadPublicGameRequestAction(gameIdInt));
    store.dispatch(ResetRunsAndGoToLandingPage());
    if (store.state.authentication.authenticated) {
      store.dispatch(ApiRunsParticipateAction(gameIdInt));
    }
  }

  void triggerAccountQr(String rawValue, Store<AppState> store) {
    List<String> tokens = rawValue.split(":");
    if (tokens.length == 3) {
      _actionTaken = true;
      String account = tokens[1];
      String password = tokens[2];

//      print("account info $account $password");
      store.dispatch(CustomAccountLoginAction(
          user: account,
          password: password,
          onError: () {
            final snackBar = SnackBar(content: Text("Error while login"));

            Scaffold.of(context).showSnackBar(snackBar);
            _actionTaken = false;
          },
          onWrongCredentials: () {
            final snackBar = SnackBar(content: Text("Fout! Wachtwoord of email incorrect"));

            Scaffold.of(context).showSnackBar(snackBar);
            setState(() {
              _actionTaken = false;
              _isProcessing = false;
            });
          },
          onSucces: () {
            store.dispatch(new SetPage(PageType.myGames));
          }));
    }
  }

//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Scan QR code game'),
//      ),
//      body: _buildImage(),
//    );
//  }





  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

Widget _buildQrView(BuildContext context) {
  // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
  // var scanArea = (MediaQuery.of(context).size.width < 400 ||
  //     MediaQuery.of(context).size.height < 400)
  //     ? 150.0
  //     : 300.0;

  var minArea = min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
  var scanArea = minArea / 4 * 3;
  // To ensure the Scanner view is properly sizes after rotation
  // we need to listen for Flutter SizeChanged notification and update controller
  return QRView(
    key: qrKey,
    onQRViewCreated: _onQRViewCreated,
    overlay: QrScannerOverlayShape(
        borderColor: AppConfig().themeData.primaryColor,
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

      print('result ${result.code}');

      if (canProcessQr(result.code)) {
        if (_isProcessing) return;
        setState(() {
          if (!_isProcessing) {
            _isProcessing = true;
            _navigatorTriggered = true;
            if (checkGameQR(result.code)) {
              triggerGameQr(result.code, store);
            } else if (checkAccountQR(result.code)) {
              triggerAccountQr(result.code, store);
            } else if (checkUrl(result.code)) {
              store.dispatch(new ParseLinkAction(link: result.code));
            } else {
              _navigatorTriggered = false;
            }
          }
        });
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
