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
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:youplay/screens/util/utils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';

import '../../localizations.dart';

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
  CameraController _camera;

  bool _isDetecting = false;
  bool _actionTaken = false;
  bool _isProcessing = false;
  bool _navigatorTriggered = false;

  CameraLensDirection _direction = CameraLensDirection.back;

  @override
  void dispose() {
    _camera?.dispose();
    super.dispose();
  }

  void _initializeCamera() async {
    _camera = CameraController(
      await getCamera(_direction),
      ResolutionPreset.low,
    );
    await _camera.initialize();

    _camera.startImageStream((CameraImage image) {
      if (_isDetecting) return;

      _isDetecting = true;

      detect(image, FirebaseVision.instance.barcodeDetector().detectInImage).then(
        (dynamic result) {
          _scanResults = result;
          if (_scanResults.isNotEmpty) {
            Barcode r = _scanResults[0];

            if (canProcessQr(r.rawValue)) {
              if (_isProcessing) return;
              setState(() {
                if (!_isProcessing) {
                  _isProcessing = true;
                  _navigatorTriggered = true;
                  if (checkGameQR(r.rawValue)) {
                    triggerGameQr(r.rawValue, store);
                  } else if (checkAccountQR(r.rawValue)) {
                    triggerAccountQr(r.rawValue, store);
                  } else if (checkUrl(r.rawValue)) {
                    store.dispatch(new ParseLinkAction(link: r.rawValue));
                  } else {
                    _navigatorTriggered = false;
                  }
                }
              });
            }
            if (!_navigatorTriggered) {
              setState(() {
                _isProcessing = false;
              });
            }
          }
          if (!_navigatorTriggered) {
            setState(() {
              _isDetecting = false;
            });
          }
        },
      ).catchError(
        (_) {
          _isDetecting = false;
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Widget _buildResults() {
    if (_scanResults == null || _camera == null) {
      return Container(
        decoration: BoxDecoration(color: Colors.black),
      );
    }

    CustomPainter painter;

    final Size imageSize = Size(
      _camera.value.previewSize.height,
      _camera.value.previewSize.width,
    );

    painter = BarcodeDetectorPainter(imageSize, _scanResults);

    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buildImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        constraints: const BoxConstraints.expand(),
        child: _camera == null
            ? Center(
                child: Text(
                  AppLocalizations.of(context).translate('scan.initializecam'),
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 30.0,
                  ),
                ),
              )
//            : CameraPreview(_camera)
            : Stack(

                fit: StackFit.expand,
                children: [
                  // CameraPreview(_camera),
                  ClipRect(
                    child: size == null? Container(): Container(
                      child: Transform.scale(
                        scale: _camera.value.aspectRatio / size.aspectRatio,
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: _camera.value.aspectRatio,
                            child: CameraPreview(_camera),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                    child: Image.asset('graphics/generalItems/scanOverlay.png'),
                  )
                  // Container(
                  //     child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: <Widget>[],
                  // ))
                  // ,
                ],
              ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildImage(context);
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
}

void _showDialog(context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Alert Dialog title"),
        content: new Text("Alert Dialog body"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
