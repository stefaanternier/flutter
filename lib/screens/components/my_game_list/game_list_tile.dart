
import 'package:youplay/models/game.dart';
import 'package:flutter/material.dart';

class GameListTileOld extends StatelessWidget {
  final Game game;
  final Function onTap;

  GameListTileOld({this.game, this.onTap});

  @override
  Widget build(BuildContext context) {
    DateTime lastModDate = DateTime.fromMillisecondsSinceEpoch(game.lastModificationDate);

    return Container(
        child: new ListTile(
          onTap: this.onTap(game.gameId),
//      leading:
//      new Image(
//          fit: BoxFit.cover,
//          height: 50.0,
//          width: 50.0,
//          image:
//          new CachedNetworkImageProvider(
//            "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/game/${game.gameId}/icon.png",
//          )),
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Flexible(
                  child: new Text(
                    "${game.title}",
                    overflow: TextOverflow.ellipsis,
                  )),
            ],
          ),
          subtitle: new Container(
            child: new Text(
              "${lastModDate.toString()}",
            ),
          ),
        ));
  }
}
