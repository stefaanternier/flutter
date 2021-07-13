// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/screens/components/button/cust_flat_button.dart';
import 'package:youplay/screens/components/button/cust_raised_button.dart';
import 'package:youplay/screens/util/extended_network_image.dart';

class GameOver extends StatefulWidget {
  GameTheme? theme;
  bool anon;
  Function startAgain;
  Function toLibrary;

  GameOver(
      {this.theme,
      required this.anon,
      required this.startAgain,
      required this.toLibrary});

  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildGameIcon(context),
          buildGameTitle(context),
          Container(
              child: Text(
            "Je hebt dit spel uitgespeeld.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFFA0ABB5),
              fontSize: 20.0,
            ),
          )),
          this.widget.anon
              ? Center(
                  child: CustomRaisedButton(
                    title: "Start opnieuw",
//            icon: new Icon(Icons.play_circle_outline, color: Colors.white),
                    onPressed: this.widget.startAgain,
                  ),
                )
              : Container(),
          this.widget.anon
              ? Center(
                  child: CustomFlatButton(
                    title: "Bibliotheek",
//            icon: new Icon(Icons.play_circle_outline, color: Colors.white),
                    onPressed: this.widget.toLibrary,
                  ),
                )
              : Container(),
        ],
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
        width: 68,
        height: 68,
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
      "Game over",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
    );
  }
}
