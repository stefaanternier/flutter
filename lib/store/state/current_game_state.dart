import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/models/general_item.dart';
import 'dart:collection';

class GamesState {
  Game game;
  GameTheme gameTheme;
  HashMap<int, GeneralItem> itemIdToGeneralItem = new HashMap();
  HashMap<int, GameFile> fileIdToGameFile = new HashMap();
  int amountOfRuns = -1;

  GamesState();

  GamesState.makeWithGame(Game g) : game = g;

  GamesState.fromJson(Map json) : game = Game.fromJson(json["game"]);

  dynamic toJson() => {
        'game': game.toJson(),
      };

  GamesState copyWith({game, items, gt, runAmount}) {
    GamesState gs = new GamesState();
    gs.game = game ?? this.game;
    gs.itemIdToGeneralItem = items ?? this.itemIdToGeneralItem;
    gs.fileIdToGameFile = this.fileIdToGameFile;
    gs.gameTheme = gt ?? this.gameTheme;
    gs.amountOfRuns = runAmount ?? this.amountOfRuns;
//    if (loading) {
//      gs.game.title = 'loading...';
//    }
    return gs;
  }
}
