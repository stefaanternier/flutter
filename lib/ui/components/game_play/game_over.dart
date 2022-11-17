import 'package:flutter/material.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/buttons/cust_flat_button.dart';
import 'package:youplay/ui/components/buttons/cust_raised_button.dart';
import 'package:youplay/ui/components/game_runs/new_run.button.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';
import 'package:youplay/util/extended_network_image.dart';

import '../../../models/game.dart';

class GameOver extends StatefulWidget {
  final GameTheme? theme;
  final Game? game;
  final bool anon;
  final Function() startAgain;
  final Function toLibrary;

  GameOver(
      {this.theme,
        this.game,
      required this.anon,
      required this.startAgain,
      required this.toLibrary});

  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: ThemedAppbarContainer(title: widget.game?.gameOverHeading ??'Game Over', elevation: false),
      drawer: ARLearnNavigationDrawerContainer(),
      body: WebWrapper(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildGameIcon(context),
              buildGameTitle(context),
              Container(
                  child: Text(
                widget.game?.gameOverDescription ?? "Je hebt dit spel uitgespeeld.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFA0ABB5),
                  fontSize: 20.0,
                ),
              )),
              this.widget.anon
                  ? Center(
                      child: CustomRaisedButton(
                        title: widget.game?.gameOverButton ?? "Start opnieuw",
//            icon: new Icon(Icons.play_circle_outline, color: Colors.white),
                        onPressed: this.widget.startAgain,
                      ),
                    )
                  : Container(),
              this.widget.anon
                  ? Center(
                      child: CustomFlatButton(
                        title: "Collectie",
                        onPressed: this.widget.toLibrary,
                      ),
                    )
                  : Container(),
              NewRunButtonContainer(title: widget.game?.gameOverButton ?? 'Speel opnieuw')
            ],
          ),
        ),
      ),
    );
    // return Container(
    //   child:Text("game over")
    // );
  }

  buildGameIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: SizedBox(
        width: 150,
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            decoration: getBoxDecoration('${widget.theme?.iconPath}'),
          ),
        ),
      ),
    );
  }

  buildGameTitle(BuildContext context) {
    return Text(
      widget.game?.gameOverHeading ?? "Game over",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
    );
  }
}
