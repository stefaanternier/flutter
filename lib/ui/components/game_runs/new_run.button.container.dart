import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/selectors/selector.games.dart';
import 'package:youplay/store/state/app_state.dart';

import 'new_run.button.dart';

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
    Game? game = currentGame(store.state);
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
