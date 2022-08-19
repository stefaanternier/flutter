import 'dart:collection';

import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/models/general_item.dart';

class GamesState {
  Game? game;
  HashMap<int, GeneralItem> itemIdToGeneralItem = new HashMap();
  HashMap<int, GameFile> fileIdToGameFile = new HashMap();
  int amountOfRuns = -1;
  DateTime? lastSync;
  GamesState();

  GamesState.makeWithGame(Game g) : game = g;

  GamesState.fromJson(Map json) : game = Game.fromJson(json["game"]);

  dynamic toJson() => {
        'game': game?.toJson() ?? {},
      };

  GamesState copyWith({game, items, runAmount, lastSync}) {
    GamesState gs = new GamesState();
    gs.game = game ?? this.game;
    gs.itemIdToGeneralItem = items ?? this.itemIdToGeneralItem;
    gs.fileIdToGameFile = this.fileIdToGameFile;
    gs.amountOfRuns = runAmount ?? this.amountOfRuns;
    gs.lastSync = lastSync ?? this.lastSync;
    return gs;
  }
}
