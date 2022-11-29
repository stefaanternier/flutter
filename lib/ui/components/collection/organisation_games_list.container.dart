import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/actions/actions.collection.dart';
import 'package:youplay/store/selectors/selector.collection.dart';
import 'package:youplay/store/state/app_state.dart';

import '../my-games-list/game_info_list_tile.dart';

class OrganisationGamesListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (store) => _ViewModel.fromStore(store),
        builder: (context, vm) {
          return Column(
              children: List<GameInfoListTile>.generate(
                  vm.organisationGames.length,
                      (i) => GameInfoListTile(
                      game: vm.organisationGames[i],
                      openGame: ((index) => (() {
                        vm.openGame(vm.organisationGames[index]);
                      }))(i))));
        });
  }
}

class _ViewModel {
  List<Game> organisationGames;
  Function openGame;

  _ViewModel({
        required this.organisationGames,
        required this.openGame});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        organisationGames: organisationGamesSelector(store.state),
        openGame: (Game g) {
          store.dispatch(new ParseLinkAction(link: 'game/${g.gameId}'));
        });
  }
}
