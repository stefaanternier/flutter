import 'package:flutter/material.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/ui/components/buttons/cust_raised_button.dart';
import 'package:youplay/ui/components/icon/game_icon.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../../config/app_config.dart';
import '../../localizations.dart';

class RunLandingPageJoin extends StatelessWidget {
  final Run run;
  final Game game;

  final Function() join;

  const RunLandingPageJoin({
    required this.game,
    required this.run,
    required this.join,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ARLearnNavigationDrawerContainer(),
      appBar: new AppBar(
          centerTitle: true,
          title: new Image(
            image: new AssetImage(AppConfig().appBarIcon!),
            height: 32.0,
            width: 32.0,
          )
      ),
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
                    GameIconContainer(game: game, height: 150),
                    Text(
                      "${game.title.toUpperCase()}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
                    ),
                    Container(

                      child: Text(

                        "${game.description}",
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
                      visible: (game.description.trim() == ""),
                      child: Container(
                          child: Text("Laat ons snel aan slag gaan met `${run.title}`",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFFA0ABB5),
                                fontSize: 20.0,
                              ))),
                    ),
                    CustomRaisedButton(
                      title: "MEEDOEN",
                      onPressed: join,
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
