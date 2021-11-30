import 'package:flutter/material.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';

import '../../localizations.dart';

class  GameLandingPublicPage extends StatelessWidget {
    Game game;
    GameLandingPublicPage({ required this.game, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ARLearnNavigationDrawerContainer(),
      appBar: new AppBar(
          centerTitle: true,
          title: new Text(AppLocalizations.of(context).translate('library.library'),
              style: new TextStyle(color: Colors.white))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text('public'),
            ),
          ),
        ],
      ),
    );
  }
}




