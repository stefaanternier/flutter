import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/ui/components/icon/game_icon.container.dart';

class GameInfoListTile extends StatelessWidget {

  Game game;

  Function openGame;
  GameInfoListTile({required this.game, required  this.openGame});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
    return ListTile(
      leading: GameIconContainer(game: game),
      title: Text('${game.title}'),
      subtitle: Text(
          '${formatter.format(DateTime.fromMillisecondsSinceEpoch(game.lastModificationDate))} '),
      onTap: () {
        this.openGame();
        //gameListModel.openGame(gameListModel.games[i]);
      },
      trailing: Icon(
        !game.privateMode ? Icons.lock : Icons.lock_open,
      ),
    );
  }
}
