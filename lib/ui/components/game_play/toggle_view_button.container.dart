import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/ui/components/game_play/toggle_view_button.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.dart';

class ToggleViewButtonContainer extends StatelessWidget {
  const ToggleViewButtonContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return ToggleViewButton(
          view: vm.view,
          togglePress: vm.togglePress,
        );
      },
    );
  }
}

class _ViewModel {
  Function() togglePress;
  MessageView view;

  _ViewModel({required this.togglePress, required this.view});

  static _ViewModel fromStore(Store<AppState> store) {
    Game? game = gameSelector(store.state.currentGameState);

    return _ViewModel(
        view: store.state.uiState.currentView,
        togglePress: () {
      print('toggle press ${game?.title}');
      if (game != null) store.dispatch(ToggleMessageViewAction(game: game));
    });
  }
}
