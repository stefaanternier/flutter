import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/game_play/game_over.container.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.dart';
import 'package:youplay/ui/pages/game_play.dart';


class GamePlayContainer extends StatelessWidget {
  const GamePlayContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        if (vm.finished) {
          return GameOverContainer();
        }
        return GamePlay(
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

  _ViewModel({
    required this.color,
    required this.game,
    required this.finished});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        game: gameSelector(store.state.currentGameState),
        color: gameColor(store.state),
        finished: gameHasFinished(store.state),
    );
  }
}
