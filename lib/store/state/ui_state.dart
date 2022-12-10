
import 'package:youplay/models/game.dart';

enum PageType {
  splash,
  featured,
  game, //shoudl be gameListView
  // gameMapView,
  // gameBoardView,
  gameItem,
  gameLandingPage,
  gamePreLandingPage,
  organisationLandingPage,
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
  error,
  // dev1,
  // dev2
}

class UiState {
  // HashMap<int, GameUiState> gameIdToGame;
  int? pageId;
  int? gameId;
  int? runId;

  int? currentItemId;
  PageType currentPage = PageType.splash;
  int theme;
  int error;
  int currentView;
  //1 = board
  //2 = list
  //3 = map

  UiState({
    this.currentItemId,
    this.currentPage = PageType.splash,
    this.theme = 0,
    this.error = -1,
    this.pageId,
    this.gameId,
    this.runId,
    this.currentView = 0
  });

  factory UiState.initState()  {
    return new UiState();
  }


  setCurrentItem(int itemId) {
    this.currentItemId = itemId;
  }

  UiState copyWith({
    int? newItemId,
    PageType? newPage,
    int? newTheme,
    int? newError,
    int? newPageId,
    int? newView,
    int? newGameId,
    int? newRunId,
  }) {

    if (newPageId != null) {
      print('page id in uistate is $newPageId');
    }
    return new UiState(

        currentItemId: newItemId ?? this.currentItemId,
        currentPage: newPage ?? this.currentPage,
        theme: newTheme ?? this.theme,
        error: newError ?? this.error,
        pageId: newPageId ?? this.pageId,
        gameId: newGameId ?? this.gameId,
        runId: newRunId ?? this.runId,
        currentView: newView ?? this.currentView
        );
  }


  UiState toggle({
    required Game game
  }) {
    return new UiState(
        currentItemId:  this.currentItemId,
        currentPage:  this.currentPage,
        theme:  this.theme,
        error:  this.error,
        pageId:  this.pageId,
        gameId:  this.gameId,
        runId:  this.runId,
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
