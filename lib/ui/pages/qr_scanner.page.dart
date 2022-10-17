import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:redux/redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';

import '../../localizations.dart';

class GameQRScannerPage extends StatelessWidget {
  const GameQRScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: AppConfig().appBarIcon != null
                ? new Image(
                    image: new AssetImage(AppConfig().appBarIcon ?? ''),
                    height: 32.0,
                    width: 32.0,
                  )
                : Text(
                    AppLocalizations.of(context).translate('scan.scangameqr'))),
        drawer: ARLearnNavigationDrawerContainer(),
        body: new StoreConnector<AppState, Store<AppState>>(
            converter: (store) => store,
            builder: (context, store) {
              return new GameQRScreen(
                  store: store); //todo use model don't pass store as reference
            }));
  }
}

class GameQRScreen extends StatefulWidget {
  final Store<AppState> store;

  GameQRScreen({required this.store});

  @override
  GameQRState createState() =>
      GameQRState(store: this.store); //todo don't pass store as reference
}

class GameQRState extends State<GameQRScreen> {
  final Store<AppState> store;
  String debug = "-";

  GameQRState({required this.store});

  bool _isProcessing = false;

  CameraLensDirection _direction = CameraLensDirection.back;

  // Barcode? r;
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
    // FocusScope.of(context).unfocus();
    // SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  Widget _buildImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        constraints: const BoxConstraints.expand(), child: Text('test'));
  }

  @override
  Widget build(BuildContext context) {
    // if(controller != null && mounted) {
    //   controller.pauseCamera();
    //   controller.resumeCamera();
    // }
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
    return rawValue.contains('gameId') || rawValue.contains('game');
  }

  bool checkUrl(rawValue) {
    return rawValue.startsWith('https://') || rawValue.startsWith('http://');
  }

  bool checkAccountQR(String rawValue) {
    return rawValue.startsWith('account:');
  }

  void triggerGameQr(String rawValue, Store<AppState> store) {
    String gameId = rawValue.substring(rawValue.indexOf('game') + 5);
    if (rawValue.contains('gameId')) {
      gameId = rawValue.substring(rawValue.indexOf('gameId') + 7);
    }
    int gameIdInt = int.parse(gameId);
    // store.dispatch(LoadPublicGameRequestAction(gameId: gameIdInt));
    store.dispatch(SetPage(page: PageType.gameLandingPage, gameId: gameIdInt));
    if (store.state.authentication.authenticated) {
      // store.dispatch(ApiRunsParticipateActionOld(gameIdInt));
    }
  }

  void triggerAccountQr(String rawValue, Store<AppState> store) {
    List<String> tokens = rawValue.split(":");
    if (tokens.length == 3) {

      String account = tokens[1];
      String password = tokens[2];
      store.dispatch(CustomAccountLoginAction(
          user: account,
          password: password,
          onError: (String code) {
            final snackBar = SnackBar(content: Text(AppLocalizations.of(context).translate('login.'+code)));
            Scaffold.of(context).showSnackBar(snackBar);
          },
          onWrongCredentials: () {
            final snackBar =
                SnackBar(content: Text("Fout! Wachtwoord of email incorrect"));

            Scaffold.of(context).showSnackBar(snackBar);
            setState(() {

              _isProcessing = false;
            });
          },
          onSucces: () {
            store.dispatch(new SetPage(page: PageType.myGames));
          }));
    }
  }

  Widget _buildQrView(BuildContext context) {
    var minArea = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    var scanArea = minArea / 4 * 3;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: AppConfig().themeData!.primaryColor,
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
        Barcode r = scanData;

        print('result ${r.code}');


        if (r.code != null && canProcessQr(r.code!)) {
          if (_isProcessing) return;
          setState(() {
            if (!_isProcessing) {
              _isProcessing = true;

              if (checkGameQR(r.code!)) {
                triggerGameQr(r.code!, store);
              } else if (checkAccountQR(r.code!)) {
                triggerAccountQr(r.code!, store);
              } else if (checkUrl(r.code)) {
                // store.dispatch(new ParseLinkActionOld(link: r.code!));
              } else {

              }
            }
          });
        }
      });
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
