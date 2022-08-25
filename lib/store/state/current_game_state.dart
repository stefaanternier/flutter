import 'dart:collection';

import 'package:youplay/models/game.dart';

class CurrentGameState {
  HashMap<int, GameFile> fileIdToGameFile = new HashMap();
  DateTime? lastSync;
  CurrentGameState();

  CurrentGameState.makeWithGame();


  CurrentGameState copyWith({items, runAmount, lastSync}) {
    CurrentGameState gs = new CurrentGameState();
    gs.fileIdToGameFile = this.fileIdToGameFile;
    gs.lastSync = lastSync ?? this.lastSync;
    return gs;
  }
}
