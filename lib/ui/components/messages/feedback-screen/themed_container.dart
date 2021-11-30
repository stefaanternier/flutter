import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/messages/feedback-screen/themed.dart';

class ThemedContainer extends StatelessWidget {
  final Widget child;
  final String feedbackKind;
  final GeneralItem item;

  ThemedContainer({required this.child, required this.feedbackKind, required this.item});

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, _ViewModel vm) {
          return Themed(backgroundPath: vm.getPath(feedbackKind), body: child);
        });
  }


}


class _ViewModel {
  GameTheme? gameTheme;

  _ViewModel({
    this.gameTheme});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      gameTheme: gameThemeSelector(store.state.currentGameState),
    );
  }

  String? getPath(String? feedbackKind) {
    if (feedbackKind == 'wrong') {
       return gameTheme?.wrongPath;
    }
    if (feedbackKind == 'correct') {
      return gameTheme?.correctPath;
    }
    return gameTheme?.backgroundPath;
  }
}