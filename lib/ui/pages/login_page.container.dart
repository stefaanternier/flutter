import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'login_page.dart';

class LoginPageContainer extends StatelessWidget {
  static final MaterialPage materialPage =
      const MaterialPage(key: ValueKey('LoginPageContainer'), child: LoginPageContainer());

  const LoginPageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        return LoginPage(loginSuccessful: vm.loginSuccessful, anonLoginSuccessful: vm.anonLoginSuccessful);
      },
    );
  }
}

class _ViewModel {
  Function() loginSuccessful;
  final Function() anonLoginSuccessful;

  _ViewModel({
    required this.loginSuccessful,
    required this.anonLoginSuccessful,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      loginSuccessful: () {
        store.dispatch(new SetPage(page: PageType.myGames));
      },
      anonLoginSuccessful: () {
        store.dispatch(new SetPage(page: PageType.featured));
      },
    );
  }
}
