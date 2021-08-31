import 'package:flutter/material.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/screens/components/button/cust_raised_button.dart';
import 'package:youplay/screens/components/login/login_screen.dart';
import 'package:youplay/ui/components/icon/game_icon.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../../localizations.dart';

class GameLandingLoginNecessaryPage extends StatelessWidget {
  Game game;
  Function() login;

  GameLandingLoginNecessaryPage({
    required this.game,
    required this.login, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ARLearnNavigationDrawerContainer(),
      appBar: new AppBar(
          centerTitle: true,
          title: new Text(
              AppLocalizations.of(context).translate('library.library'),
              style: new TextStyle(color: Colors.white))),
      body: WebWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GameIconContainer(game: game, height: 68),
                  Text(
                    "${game.title.toUpperCase()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
                  ),
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
                    onPressed: login,
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
