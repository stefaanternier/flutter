// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/screens/components/button/cust_raised_button.dart';
import 'package:youplay/screens/components/login/login_screen.dart';
import 'package:youplay/screens/pages/run_landing_page.viewmodel.dart';
import 'package:youplay/screens/util/navigation_drawer.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../localizations.dart';

class RunLandingPage extends StatefulWidget {
  @override
  _RunLandingPageState createState() => _RunLandingPageState();
}

class _RunLandingPageState extends State<RunLandingPage> {
  bool showLogin = false;
  bool clickedJoinRun = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: ARLearnNavigationDrawer(),
        appBar: new AppBar(
            centerTitle: true, title: new Text('', style: new TextStyle(color: Colors.white))),
        body: new StoreConnector<AppState, RunLandingPageViewModel>(
            distinct: true,
            converter: (store) => RunLandingPageViewModel.fromStore(store, context),
            builder: (context, gameLandingPageModel) =>
                _switchState(context, gameLandingPageModel)));
  }

  _switchState(BuildContext context, RunLandingPageViewModel gameLandingPageModel) {
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
    if (!gameLandingPageModel.isAuth) {
      return _notAuthenticatedLoginNecessary(context, gameLandingPageModel);
    }
    return _isAuthenticated(context, gameLandingPageModel);
  }

  Widget _notAuthenticatedLoginNecessary(
      BuildContext context, RunLandingPageViewModel gameLandingPageModel) {
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
            onPressed: () {
              setState(() {
                showLogin = true;
              });
            },
          ),
        ],
      ),
    );
  }

  _isAuthenticated(BuildContext context, RunLandingPageViewModel gameLandingPageModel) {
    print ('${gameLandingPageModel.run}');

    // if (gameLandingPageModel.amountOfRuns == 0 ||
    //     (gameLandingPageModel.game?.privateMode && gameLandingPageModel.isAnon)) {
    //   return _firstPlay(context, gameLandingPageModel);
    // }



    if (gameLandingPageModel.run != null && gameLandingPageModel.runs != null && gameLandingPageModel.runs.length != 0) {
      gameLandingPageModel.runs.forEach((element) {
        if (gameLandingPageModel.run != null) {
          if (gameLandingPageModel.run!.runId == element.runId) {
            gameLandingPageModel.toRunPage();
          }
        }

      });
    }
    if (gameLandingPageModel.amountOfRuns == -1 ||clickedJoinRun) {
      return _waitingroom(context, gameLandingPageModel);
    }
    //
    // gameLandingPageModel.toRunsPage();
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
            Container(
                  child: Visibility(
                    visible: (gameLandingPageModel.game?.description.trim() == ""),
                    child: Text(
                "Je bent ingelogd maar niet geregistreerd voor deze groep. Klik op meedoen",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color(0xFFA0ABB5),
                    fontSize: 20.0,
                ),
              ),
                  )),
              CustomRaisedButton(
                title: "MEEDOEN",
                onPressed: () {
                  setState(() {
                    gameLandingPageModel.joinRun();
                    clickedJoinRun = true;
                    gameLandingPageModel.toRunPage();
                  });
                },
              ),
            ],
          ),
      ),
    );
  }

  buildGameIcon(BuildContext context, RunLandingPageViewModel gameLandingPageModel) {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: Container()
      // child: Image(
      //     height: 68, image: buildImage(context, '${gameLandingPageModel.gameTheme?.iconPath}')),
    );
  }

  // CachedNetworkImageProvider buildImage(BuildContext context, path) {
  //   print("loading img from $path");
  //   print("https://storage.googleapis.com/${AppConfig().projectID}.appspot.com$path");
  //   return new CachedNetworkImageProvider(
  //     "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com$path",
  //   );
  // }

  buildGameTitle(BuildContext context, RunLandingPageViewModel gameLandingPageModel) {
    return Text(
      "${gameLandingPageModel.game?.title.toUpperCase()}",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
    );
  }

  _waitingroom(BuildContext context, RunLandingPageViewModel gameLandingPageModel) {
    return Padding(
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

  _showLogin(BuildContext context, RunLandingPageViewModel gameLandingPageModel) {
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
