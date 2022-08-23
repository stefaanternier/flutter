import 'dart:collection';

import 'package:youplay/models/game.dart';

class CurrentGameState {
  // Game? game;
  HashMap<int, GameFile> fileIdToGameFile = new HashMap();
  int amountOfRuns = -1;
  DateTime? lastSync;
  CurrentGameState();

  CurrentGameState.makeWithGame();


  CurrentGameState copyWith({items, runAmount, lastSync}) {
    CurrentGameState gs = new CurrentGameState();
    gs.fileIdToGameFile = this.fileIdToGameFile;
    gs.amountOfRuns = runAmount ?? this.amountOfRuns;
    gs.lastSync = lastSync ?? this.lastSync;
    return gs;
  }
}
