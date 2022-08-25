import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/actions/actions.collection.dart';
import 'package:youplay/store/selectors/selector.collection.dart';
import 'package:youplay/store/state/app_state.dart';

import '../my-games-list/game_info_list_tile.dart';

class RecentGamesResultListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter =
        DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
    return new StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (store) => _ViewModel.fromStore(store),
        builder: (context, vm) {
          return Column(
              children: List<GameInfoListTile>.generate(
                  vm.games.length,
                  (i) => GameInfoListTile(
                      game: vm.games[i],
                      openGame: ((index) => (() {
                            vm.openGame(vm.games[index]);
                          }))(i))));
        });
  }
}

class _ViewModel {
  List<Game> searchGames;
  List<Game> recentGames;
  Function openGame;

  List<Game> get games {
    if (searchGames != null && searchGames.length != 0) return [];
    return recentGames;
  }

  _ViewModel(
      {required this.searchGames,
      required this.recentGames,
      required this.openGame});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        searchGames: [],//searchedGamesSelector(store.state),
        recentGames: recentGamesSelector(store.state), //.gameLibrary.recentGames,
        openGame: (Game g) {
          store.dispatch(new ParseLinkAction(link: 'game/${g.gameId}'));
          // store.dispatch(
          //     new SetPage(page: PageType.gameLandingPage, gameId: g.gameId));
        });
  }
}
