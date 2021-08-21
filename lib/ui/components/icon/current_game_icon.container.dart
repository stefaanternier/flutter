import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/selectors/game_theme.selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/icon/game_icon.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.dart';

import 'game_icon.container.dart';


class CurrentGameIconContainer extends StatelessWidget {
  double height;

  CurrentGameIconContainer({this.height = 59, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        return GameIconContainer(
          game: vm.game,
          height: height,
        );
      },
    );
  }
}


class _ViewModel {
  Game? game;

  _ViewModel({this.game});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      game: gameSelector(store.state.currentGameState),
    );
  }
}
