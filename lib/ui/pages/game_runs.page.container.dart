import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/actions/actions.games.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'game_runs.page.dart';

class GameRunsPageContainer extends StatelessWidget {
  final Game game;

  const GameRunsPageContainer({required this.game, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, game),
      distinct: true,
      builder: (context, vm) {
        return GameRunsPage(init: vm.init);
        // init: (){},

      },
    );
  }
}

class _ViewModel {
  Function() init;

  _ViewModel({required this.init});

  static _ViewModel fromStore(Store<AppState> store, Game game) {
    return _ViewModel(
      init: () {
        store.dispatch(SetCurrentGameAction(currentGame: game.gameId));
        store.dispatch(LoadGameRequest(gameId: '${game.gameId}'));
        store.dispatch(ApiRunsParticipateAction(game.gameId));
        print('first view is ${game.firstView}');
        store.dispatch(SetMessageViewAction(messageView: game.firstView));

        store.dispatch(SetPage(page: PageType.gameWithRuns, gameId: game.gameId));
      },
    );
  }

// bool operator ==(Object other) {
//   if (identical(this, other)) {
//     return true;
//   }
//   return other is _ViewModel && (other.item?.itemId == item?.itemId);
// }
//
// @override
// int get hashCode => item?.itemId ?? -1;

}
