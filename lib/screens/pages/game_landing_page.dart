import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:youplay/screens/components/button/cust_flat_button.dart';
import 'package:youplay/screens/components/button/cust_raised_button.dart';
import 'package:youplay/screens/components/login/login_screen.dart';
import 'package:youplay/screens/components/login/login_with_demo_account_button.dart';
import 'package:youplay/screens/util/extended_network_image.dart';
import 'package:youplay/screens/util/navigation_drawer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/store/state/app_state.dart';
import '../../localizations.dart';
import 'game_landing_page.viewmodel.dart';

class GameLandingPage extends StatefulWidget {
  @override
  _GameLandingPageState createState() => _GameLandingPageState();
}

class _GameLandingPageState extends State<GameLandingPage> {
  bool showLogin = false;
  bool tapActivated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: ARLearnNavigationDrawer(),
        appBar: new AppBar(
            centerTitle: true,
            title: new Text(AppLocalizations.of(context).translate('library.library'),
                style: new TextStyle(color: Colors.white))),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: StoreConnector<AppState, GameLandingPageViewModel>(
                    distinct: true,
                    converter: (store) => GameLandingPageViewModel.fromStore(store, context),
                    builder: (context, gameLandingPageModel) =>
                        _switchState(context, gameLandingPageModel)),
            ),
          ],
        ),
        );
  }

  _switchState(BuildContext context, GameLandingPageViewModel gameLandingPageModel) {
    if (showLogin) {
      return _showLogin(context, gameLandingPageModel);
    }
    if (gameLandingPageModel.game == null) {
      return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
            Container(
                child: Text(
              "Spel laden ...",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFA0ABB5),
                fontSize: 20.0,
              ),
            ))
          ]));
//      return Text("loading game...");
    }
    if (!gameLandingPageModel.isAuth ||
        (!(gameLandingPageModel.game?.privateMode??false) && gameLandingPageModel.isAnon)) {
      return _notAuthenticated(context, gameLandingPageModel);
    }
    return _isAuthenticated(context, gameLandingPageModel);
  }

  Widget _notAuthenticated(BuildContext context, GameLandingPageViewModel gameLandingPageModel) {
    if (gameLandingPageModel.game?.privateMode??false) {
      // return _waitingroom(context, gameLandingPageModel);
      // if (!tapActivated) {
      //   gameLandingPageModel.tapPlayAnonymously();
      //   setState(() {
      //     tapActivated = true;
      //   });
      // }
      return _notAuthenticatedPlayAnon(context, gameLandingPageModel);
    }
    print("private mode is ${gameLandingPageModel.game?.privateMode}");
    return _notAuthenticatedLoginNecessary(context, gameLandingPageModel);
  }

  Widget _notAuthenticatedPlayAnon(
      BuildContext context, GameLandingPageViewModel gameLandingPageModel) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildGameIcon(context, gameLandingPageModel),
          buildGameTitle(context, gameLandingPageModel),
          Container(
              child: Text(
            "Let op, je speelt dit spel anoniem. Dat betekent dat er geen spelstatus wordt bijgehouden.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFFA0ABB5),
              fontSize: 20.0,
            ),
          )),
          CustomRaisedButton(
            title: "SPEEL ANONIEM",
//            icon: new Icon(Icons.play_circle_outline, color: Colors.white),
            onPressed: () {
              gameLandingPageModel.tapPlayAnonymously();
            },
          ),
          CustomFlatButton(
            title: "INLOGGEN",
            onPressed: () {
              //TODO..
              setState(() {
                showLogin = true;
              });
//              gameLandingPageModel.tapCustomLogin();
            },
          ),
//          Padding(
//            padding: const EdgeInsets.all(32),
//            child: DemoLoginButton(gameLandingPageModel.tapCustomLogin, context),
//          ),
//          Container(child: Text("Game info  ${gameLandingPageModel.game?.title}")),
//          Container(child: Text("Private play  ${gameLandingPageModel.game?.privateMode}")),
        ],
      ),
    );
  }

  Widget _notAuthenticatedLoginNecessary(
      BuildContext context, GameLandingPageViewModel gameLandingPageModel) {
    print("in _notAuthenticatedLoginNecessary");
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildGameIcon(context, gameLandingPageModel),
          buildGameTitle(context, gameLandingPageModel),
          Container(
              child: Text(
            "Om dit spel te spelen moet je inloggen",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFFA0ABB5),
              fontSize: 20.0,
            ),
          )),

          CustomRaisedButton(
            title: "INLOGGEN",
//            icon: new Icon(Icons.play_circle_outline, color: Colors.white),
            onPressed: () {
//              gameLandingPageModel.tapPlayAnonymously();
              setState(() {
                showLogin = true;
              });
            },
          ),
//          Padding(
//            padding: const EdgeInsets.all(32),
//            child: DemoLoginButton(gameLandingPageModel.tapCustomLogin, context),
//          ),
//          Container(child: Text("Game info  ${gameLandingPageModel.game?.title}")),
//          Container(child: Text("Private play  ${gameLandingPageModel.game?.privateMode}")),
        ],
      ),
    );
  }

  _isAuthenticated(BuildContext context, GameLandingPageViewModel gameLandingPageModel) {
    if (gameLandingPageModel.amountOfRuns == 0 ||
        ((gameLandingPageModel.game?.privateMode??false) && gameLandingPageModel.isAnon)) {
      return _firstPlay(context, gameLandingPageModel);
    }
    if (gameLandingPageModel.amountOfRuns == -1) {
      return _waitingroom(context, gameLandingPageModel);
    }

    gameLandingPageModel.toRunsPage();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildGameIcon(context, gameLandingPageModel),
            buildGameTitle(context, gameLandingPageModel),
            Container(
                child: Text(
              "Even wachten, we laden de groep(en) voor dit spel...",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFA0ABB5),
                fontSize: 20.0,
              ),
            )),
//            Container(
//                child: Text(
//                    "you are authenticated, wait for sync with server ${gameLandingPageModel.isAuth}")),
//            Container(child: Text("Anon is ${gameLandingPageModel.isAnon}")),
//            Container(child: Text("Aantal runs is ${gameLandingPageModel.amountOfRuns}")),
//            Container(
//                child: Text(
//                    "Volgende stap is dus de runs tonen en de gebruiker 1 van die runs laten verder spelen")),
          ],
        ),
      ),
    );
  }

  _waitingroom(BuildContext context, GameLandingPageViewModel gameLandingPageModel) {
    return

        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildGameIcon(context, gameLandingPageModel),
              buildGameTitle(context, gameLandingPageModel),
              Container(
                  child: Text(
                "Speldata ophalen...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFA0ABB5),
                  fontSize: 20.0,
                ),
              )),
            ],
          ),

    );
  }


  _firstPlay(BuildContext context, GameLandingPageViewModel gameLandingPageModel) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildGameIcon(context, gameLandingPageModel),
          buildGameTitle(context, gameLandingPageModel),

          Container(

            child: Text(

              "${gameLandingPageModel.game?.description}",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 10,

              style: TextStyle(
                color: const Color(0xFFA0ABB5),
                fontSize: 20.0,
              ),
            ),
          ),

          Visibility(
            visible: (gameLandingPageModel.game?.description.trim() == ""),
            child: Container(
                child: Text("Laat ons snel aan slag gaan met `${gameLandingPageModel.game?.title??''}`",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFA0ABB5),
                      fontSize: 20.0,
                    ))),
          ),
          CustomRaisedButton(
            title: "START HET SPEL  ",
//            icon: new Icon(Icons.play_circle_outline, color: Colors.white),
            onPressed: () {
              gameLandingPageModel.createRunAndStart();
            },
          ),
//          RaisedButton.icon(
//              onPressed: () {
//                gameLandingPageModel.createRunAndStart();
//              },
//              icon: new Icon(Icons.play_circle_outline, color: Colors.white),
//              label: Text("Maak een run")),
        ],
      ),
    );
  }

  buildGameIcon(BuildContext context, GameLandingPageViewModel gameLandingPageModel) {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: SizedBox(
        width: 68,
        height: 68,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            decoration: getBoxDecoration(gameLandingPageModel.gameTheme?.iconPath),
            // decoration: new BoxDecoration(
            //     image: new DecorationImage(
            //         fit: BoxFit.cover,
            //         image: buildImage(context, '${gameLandingPageModel.gameTheme?.iconPath}'))),
            // child: Image(
            //     height: 68, image: buildImage(context, '${gameLandingPageModel.gameTheme?.iconPath}')),
          ),
        ),
      ),
    );
  }

  buildGameTitle(BuildContext context, GameLandingPageViewModel gameLandingPageModel) {
    return Text(
      "${gameLandingPageModel.game?.title.toUpperCase()}",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
    );
  }

  _showLogin(BuildContext context, GameLandingPageViewModel gameLandingPageModel) {
    return LoginScreen(
        lang: Localizations.localeOf(context).languageCode,
        onSuccess: () {
          setState(() {
            this.showLogin = false;
            gameLandingPageModel.loadRuns();
          });
        });
  }
}

//
