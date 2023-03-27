import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/game_play/toggle_view_button.dart';

import '../../../store/selectors/selector.games.dart';

class ToggleViewButtonContainer extends StatelessWidget {
  const ToggleViewButtonContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        if (vm.nextView == vm.view) {
          return Container();
        }
        return ToggleViewButton(
          view: vm.view,
          nextView: vm.nextView,
          togglePress: vm.togglePress,
        );
      },
    );
  }
}

class _ViewModel {
  Function() togglePress;
  int view;
  int nextView;

  _ViewModel({required this.togglePress, required this.view, required this.nextView});

  static _ViewModel fromStore(Store<AppState> store) {
    Game? game = currentGame(store.state);
    int v = store.state.uiState.currentView;
    // print('current view is $v');
    if (game != null) {
      // print('next view is ${game.nextView(v)}');
    }
    return _ViewModel(
        view: v,
        nextView: game == null ? 2 : game.nextView(v),
        togglePress: () {
          if (game != null) store.dispatch(ToggleMessageViewAction(game: game));
        });
  }
}
