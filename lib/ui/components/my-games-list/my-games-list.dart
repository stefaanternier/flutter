import 'package:flutter/material.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/ui/components/my-games-list/game_info_list_tile.dart';

class MyGamesList extends StatelessWidget {
  List<Game> gameList;
  Function(int) tapGame;

  MyGamesList({required this.gameList, required this.tapGame, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List<GameInfoListTile>.generate(
            gameList.length,
            (i) => GameInfoListTile(
                game: gameList[i],
                openGame: () {
                  tapGame(gameList[i].gameId)();
                })));
  }
}
