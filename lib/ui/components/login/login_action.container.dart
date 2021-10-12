import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'login_action.dart';

class LoginActionContainer extends StatelessWidget {
  final Function() keyboardIsShown;
  final Function() keyboardIsHidden;

  const LoginActionContainer({required this.keyboardIsShown, required this.keyboardIsHidden, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return LoginAction(
          tapCreateAccount: vm.tapCreateAccount,
          resetPassword: vm.resetPassword,
          keyboardIsHidden: keyboardIsHidden,
          keyboardIsShown: keyboardIsShown,
        );
      },
    );
  }
}

class _ViewModel {
  Function(String) resetPassword;
  Function() tapCreateAccount;

  _ViewModel({required this.resetPassword, required this.tapCreateAccount});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(resetPassword: (String email) {
      print('resetting email ${email}');
      store.dispatch(ResetPassword(email: email));
    }, tapCreateAccount: () {
      store.dispatch(new SetPage(page: PageType.makeAccount));
    });
  }
}
