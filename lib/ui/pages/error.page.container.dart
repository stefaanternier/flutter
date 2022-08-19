import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/actions/errors.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'error.page.dart';


class ErrorPageContainer extends StatelessWidget {
  const ErrorPageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: false,
      builder: (context, vm) {

          return ErrorPage(
              onPressed: vm.click,
              text: vm.message);

      },
    );
  }
}

class _ViewModel {
  Function() click;
  final String  message;

  _ViewModel({required this.click,required this.message,});

  static _ViewModel fromStore(Store<AppState> store) {
    String message = '';
    switch (store.state.uiState.error) {
      case ApiResultError.RUNDOESNOTEXIST:
        message = 'Deze groep werd niet gevonden.';

    }
    return _ViewModel(
      message: message,
      click: () {
        store.dispatch(SetPage(page: PageType.featured));
      },
    );
  }

}
