import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/actions/actions.games.dart';
import 'package:youplay/store/actions/actions.generalitems.dart';
import 'package:youplay/store/actions/actions.runs.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import '../../../store/selectors/selector.games.dart';
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
  Function(Game) tapGame;

  _ViewModel({required this.gameList, required this.tapGame});

  static _ViewModel fromStore(Store<AppState> store) {


    return _ViewModel(
        gameList: myGames(store.state),
        tapGame: (Game game) {
          return () {
            store.dispatch(LoadGameRunsRequest(gameId: game.gameId));
            store.dispatch(LoadGameMessagesRequest(gameId: '${game.gameId}'));
            store.dispatch(LoadGameRequest(gameId: '${game.gameId}'));
            store.dispatch(SetPage(page: PageType.gameWithRuns, gameId: game.gameId));
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
