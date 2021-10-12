import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youplay/actions/errors.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/api/StoreApi.dart';
import 'package:youplay/api/games.dart';
import 'package:youplay/api/runs.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/actions/game_library.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/app_state.dart';

final gameLibraryEpics = combineEpics<AppState>([
  new TypedEpic<AppState, LoadFeaturedGameAction>(_loadFeaturedGames),
  new TypedEpic<AppState, LoadRecentGamesAction>(_loadRecentGames),
  new TypedEpic<AppState, LoadOneFeaturedGameAction>(_loadOneFeaturedGames),
  new TypedEpic<AppState, ParseLinkAction>(_parseLinkAction),
]);
final testEpoic = new TypedEpic<AppState, dynamic>(_searchGames);

Stream<dynamic> _searchGames(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.whereType<SearchLibrary>().debounceTime(Duration(milliseconds: 500))
      // .where((action) => action.query.length > 2)
      .asyncExpand((action) {
    return (action.query.length <= 2)
        ? yieldEmpty(new LoadSearchedGameResultsAction(games: []))
        : yieldGameInfoAction(
            action, StoreApi.search(action.query), store, new LoadSearchedGameResultsAction(games: []));
  });
}

Stream<dynamic> _loadOneFeaturedGames(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is LoadOneFeaturedGameAction).asyncMap((action) =>
      StoreApi.game(action.game.gameId)
          .then((game) => game != null ? new LoadOneFeaturedGameResultAction(game: game, rank: action.game.rank) : null));
}

Stream<dynamic> _loadFeaturedGames(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is LoadFeaturedGameAction).asyncExpand((action) {
    return yieldGameInfoAction(
        action, StoreApi.featuredGames(), store, new LoadFeaturedGameResultsAction(games: []));
  });
}


Stream<dynamic> _loadRecentGames(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is LoadRecentGamesAction).asyncExpand((action) {
    return yieldGameInfoAction(
        action, StoreApi.recentGames(), store, new LoadRecentGameResultsAction(games: []));
  });


  // return actions.where((action) => action is LoadRecentGamesAction).asyncMap((action) {
  //   return StoreApi.recentGames()
  //       .then((games) => new LoadRecentGameResultsAction(games: games));
  // });
}

Stream<dynamic> yieldEmpty(dynamic partialResultsAction) async* {
  yield partialResultsAction;
}

Stream<dynamic> yieldGameInfoAction(action, Future<List<Game>> gameList, EpicStore<AppState> store,
    dynamic partialResultsAction) async* {
  // List<Game> list = await gameList;AppConfig().analytics.logSearch(searchTerm: '${action.query}');
  partialResultsAction.games = await gameList;
  // yield new LoadFeaturedGameResultsAction(games: list);
  // yield new LoadSearchedGameResultsAction(games: partialResultsAction.games);
  yield partialResultsAction;
  for (Game game in partialResultsAction.games) {
    if (store.state.gameLibrary.fullGames[game.gameId] == null)
      yield LoadOneFeaturedGameAction(game: game);
  }
}

Stream<dynamic> _parseLinkAction(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is ParseLinkAction).asyncExpand((action) {
    print("link is ${action.link}");
    String link = action.link as String;
    if (link.indexOf("/game/") != -1) {
      return yieldLinkExpandGame(link);
    }
    if (link.indexOf("/run/") != -1) {
      return yieldLinkExpandRun(link);
    }
    return yieldLinkExpand();
  });
}

Stream<dynamic> yieldLinkExpandRun(String link) async* {
  print("runId is ${link.substring(link.lastIndexOf('/run/') + 5).trim()}");
  int runId = int.parse(link.substring(link.lastIndexOf('/run/') + 5).trim());
  yield ResetRunsAndGoToRunLandingPage(runId: runId);
  dynamic runwithgame = await RunsApi.runWithGame(runId);
  if (runwithgame != null) {
    Game game = Game.fromJson(runwithgame['game']);
    print('game titel ${game.title}');
    GameTheme theme = await GamesApi.getTheme(game.theme);
    yield new LoadGameSuccessAction(game: game, gameTheme: theme);
    yield new LoadOneFeaturedRunAction(run: Run.fromJson(runwithgame));
    yield ApiRunsParticipateAction(game.gameId);
  }
}

Stream<dynamic> yieldLinkExpandGame(String link) async* {
  // link = link.substring(link.lastIndexOf('/game/')+6).trim();
  print("gameId is ${link.substring(link.lastIndexOf('/game/') + 6).trim()}");
  int gameId = int.parse(link.substring(link.lastIndexOf('/game/') + 6).trim());
  yield ResetRunsAndGoToLandingPage();
  dynamic game = await StoreApi.game(gameId);
  if (game is ApiResultError) {
    //todo
  } else {
    Game g = game as Game;
    GameTheme theme = await GamesApi.getTheme(game.theme);
    yield new LoadGameSuccessAction(game: g, gameTheme: theme);
    yield ApiRunsParticipateAction(gameId);
  }


}

Stream<dynamic> yieldLinkExpand() async* {
  // List<Game> list = await gameList;
  // yield new LoadFeaturedGameResultsAction(games: list);
  // for (Game game in list) {
  //   if (store.state.gameLibrary.fullGames[game.gameId] == null)
  //     yield LoadOneFeaturedGameAction(game: game);
}
