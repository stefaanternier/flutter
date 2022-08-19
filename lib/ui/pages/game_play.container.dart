import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/actions/locations.actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/current_run.location.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/selector.gametheme.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/game_play/game_over.container.dart';
import 'package:youplay/ui/pages/game_play.dart';

class GamePlayContainer extends StatelessWidget {
  const GamePlayContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        if (vm.finished) {
          return GameOverContainer();
        }
        return GamePlay(
          // maxView: vm.listType ==1,
          color: vm.color,
          title: vm.game?.title ?? '',
        );
      },
    );
  }
}

class _ViewModel {
  Color color;
  Game? game;
  bool finished;
  // int listType;

  _ViewModel({
    // required this.listType,
    required this.color, required this.game, required this.finished});

  static _ViewModel fromStore(Store<AppState> store) {
    if(gameLocationTriggers(store.state).length > 0) {
      store.dispatch(new StartListeningForLocation());
    }
    // int lt = store.state.uiState.currentView;
    // print('current view is ${lt}');
    return _ViewModel(
      // listType: lt,
      game: gameSelector(store.state.currentGameState),
      color: currentGameThemeColor(store.state),
      finished: gameHasFinished(store.state),
    );
  }

  bool operator ==(Object other) {
    _ViewModel otherViewModel = other as _ViewModel;
    return (otherViewModel.color == color) &&
        (otherViewModel.game?.gameId == game?.gameId) &&
        // (otherViewModel.listType == listType) &&
        (otherViewModel.finished == finished);
  }

  @override
  int get hashCode => (game?.gameId ?? -1) * (color.value) * (finished ? 1 : 2);
}
