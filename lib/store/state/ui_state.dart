
import 'package:youplay/models/game.dart';

enum PageType {
  splash,
  featured,
  game, //shoudl be gameListView
  // gameMapView,
  // gameBoardView,
  gameItem,
  gameLandingPage,
  runLandingPage,
  // gameStartWithMap,
  gameWithRuns,
  myGames,
  scanGame,
  // library,
  login,
  makeAccount,
  intro,
  introAfterSplash,
  // dev1,
  // dev2
}

class UiState {
  // HashMap<int, GameUiState> gameIdToGame;
  int? pageId;

  int currentGameId;
  int? currentItemId;
  PageType currentPage = PageType.splash;
  int theme;
  int error;
  int currentView;
  //1 = board
  //2 = list
  //3 = map

  UiState({
    this.currentGameId = -1,
    this.currentItemId,
    this.currentPage = PageType.splash,
    this.theme = 0,
    this.error = -1,
    this.pageId,
    this.currentView = 0
  });

  factory UiState.initState()  {
    return new UiState();
  }

  setCurrentGame(int gameId) {
    this.currentGameId = gameId;
  }

  setCurrentItem(int itemId) {
    this.currentItemId = itemId;
  }

  UiState copyWith({
    int? newCurrentGame,
    int? newItemId,
    PageType? newPage,
    int? newTheme,
    int? newError,
    int? newPageId,
    int? newView
  }) {

    if (newPageId != null) {
      print('page id in uistate is $newPageId');
    }
    return new UiState(
        currentGameId: newCurrentGame ?? this.currentGameId,
        currentItemId: newItemId ?? this.currentItemId,
        currentPage: newPage ?? this.currentPage,
        theme: newTheme ?? this.theme,
        error: newError ?? this.error,
        pageId: newPageId ?? this.pageId,
        currentView: newView ?? this.currentView
        );
  }


  UiState toggle({
    required Game game
  }) {
    return new UiState(
        currentGameId: this.currentGameId,
        currentItemId:  this.currentItemId,
        currentPage:  this.currentPage,
        theme:  this.theme,
        error:  this.error,
        pageId:  this.pageId,
        currentView: game.nextView(this.currentView)
    );
  }
}


enum MessageView {
  listView,
  metafoorView,
  mapView
}

class GameUiState {
  MessageView messagesView;

  GameUiState({this.messagesView = MessageView.metafoorView});
}
