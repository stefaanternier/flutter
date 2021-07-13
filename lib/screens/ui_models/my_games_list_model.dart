import 'package:youplay/actions/games.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/actions/ui.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/selectors/selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:redux/redux.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/all_games.selectors.dart';

class MyGamesListViewModel {
  List<Game> gameList;
  Function tapGame;

  MyGamesListViewModel({required this.gameList, required this.tapGame});

  static MyGamesListViewModel fromStore(Store<AppState> store) {
    return MyGamesListViewModel(
        gameList: allGames(store.state.allGamesState),
        tapGame: (int gameId) {
          return () {
            store.dispatch(SetCurrentGameAction(currentGame: gameId));
            store.dispatch(LoadGameRequestAction(gameId: gameId));
            store.dispatch(ApiRunsParticipateAction(gameId));
            store.dispatch(SetPage(PageType.gameWithRuns));
          };
        });
  }

//  loadGame(int gameId) {
////    this.store.dispatch(new ApiGameAction(6175770729775104));
//    this.store.dispatch(new ApiGameAction(gameId));
//  }

  MyGamesListViewModel filter(String query) {
    List<Game> _searchList = [];
    for (int i = 0; i < this.gameList.length; i++) {
      String name = this.gameList.elementAt(i).title;
      if (name != null && name.toLowerCase().contains(query.toLowerCase())) {
        _searchList.add(this.gameList.elementAt(i));
      }
    }
    return new MyGamesListViewModel(
      gameList: _searchList,
      tapGame: this.tapGame,
    );
  }
}
