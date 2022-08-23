import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/selector.games.dart';
import 'package:youplay/store/state/app_state.dart';

import 'game_icon.container.dart';

class CurrentGameIconContainer extends StatelessWidget {
  double height;

  CurrentGameIconContainer({this.height = 59, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromStore(store),
        builder: (context, vm) => GameIconContainer(
              game: vm.game,
              height: height,
            ));
  }
}

class _ViewModel {
  Game? game;

  _ViewModel({this.game});

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        game: currentGame(store.state),
      );
}
