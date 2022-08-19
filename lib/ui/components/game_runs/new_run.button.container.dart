import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/gameid_to_runs.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/gameid_to_runs.selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'game-runs-list.dart';
import 'new_run.button.dart';
import 'package:intl/intl.dart';

class NewRunButtonContainer extends StatelessWidget {
  final String? title;
  const NewRunButtonContainer({this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromStore(store),
        builder: (context, vm) {

          return NewRunButton(
            title: title,
            onPressed: vm.onPressed,
          );
        });
  }
}

class _ViewModel {
  final Function(BuildContext) onPressed;

  _ViewModel({
    required this.onPressed,

  });

  static _ViewModel fromStore(Store<AppState> store) {

    Game? game = gameSelector(store.state.currentGameState);

    return _ViewModel(
        onPressed: (BuildContext context){
          if (game != null) {
            store.dispatch(RequestNewRunAction(gameId: game.gameId,
                name: DateFormat( "EEEE dd/M", Localizations.localeOf(context).languageCode).format(DateTime.now())));
          }
        })
    ;
  }
}
