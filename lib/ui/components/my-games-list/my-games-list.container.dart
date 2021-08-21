import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/all_games.selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'my-games-list.dart';

class MyGamesListContainer extends StatelessWidget {
  const MyGamesListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromStore(store),
        builder: (context, vm) {
          return MyGamesList(
            gameList: vm.gameList,
            tapGame: vm.tapGame,
          );
        });
  }
}

class _ViewModel {
  List<Game> gameList;
  Function(int) tapGame;

  _ViewModel({required this.gameList, required this.tapGame});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        gameList: allGames(store.state.allGamesState),
        tapGame: (int gameId) {
          return () {
            store.dispatch(SetCurrentGameAction(currentGame: gameId));
            store.dispatch(LoadGameRequestAction(gameId: gameId));
            store.dispatch(ApiRunsParticipateAction(gameId));
            store.dispatch(SetPage(page: PageType.gameWithRuns));
          };
        });
  }

  _ViewModel filter(String query) {
    List<Game> _searchList = [];
    for (int i = 0; i < this.gameList.length; i++) {
      String name = this.gameList.elementAt(i).title;
      if (name != null && name.toLowerCase().contains(query.toLowerCase())) {
        _searchList.add(this.gameList.elementAt(i));
      }
    }
    return new _ViewModel(
      gameList: _searchList,
      tapGame: this.tapGame,
    );
  }
}
