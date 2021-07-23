import 'dart:collection';

enum PageType {
  featured,
  game,
  gameLandingPage,
  runLandingPage,
  gameStartWithMap,
  gameWithRuns,
  myGames,
  scanGame,
  library,
  login,
  makeAccount,
  dev1,
  dev2
}

class UiState {
  HashMap<int, GameUiState> gameIdToGame;
  int currentGameId;

//  int currentRunId;
  int? currentItemId;

//  ItemUiState itemUiState;
  PageType currentPage = PageType.featured;
  int theme;
  int error;

  UiState({
    required this.gameIdToGame,
    this.currentGameId = -1,
//    this.currentRunId,
    this.currentItemId,
    this.currentPage = PageType.featured,
    this.theme = 0,
//    this.itemUiState = ItemUiState.itemView,
    this.error = -1,
//    this.buildContext
  });

  factory UiState.initState() => new UiState(gameIdToGame: new HashMap());

  setCurrentGame(int gameId) {
    this.currentGameId = gameId;
  }

  setCurrentItem(int itemId) {
    this.currentItemId = itemId;
  }
}


enum MessageView {
  mapView,
  listView,
  metafoorView
}

class GameUiState {
  MessageView messagesView;

  GameUiState({this.messagesView = MessageView.metafoorView});
}
