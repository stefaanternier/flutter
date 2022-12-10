import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/login/login_screen.dart';

import '../../../localizations.dart';

class LoginScreenContainer extends StatelessWidget {
  final Function() loginSuccessful;
  final Function() anonLoginSuccessful;
  final bool anonLogin;

  const LoginScreenContainer({
    required this.loginSuccessful,
    required this.anonLoginSuccessful,
    required this.anonLogin,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, context, loginSuccessful, anonLoginSuccessful),
      builder: (context, vm) {
        return LoginScreen(
          anonLogin: anonLogin,
          tapGoogleLogin: vm.tapGoogleLogin,
          tapAppleLogin: vm.tapAppleLogin,
          tapAnonymousLogin: vm.tapAnonymousLogin,
          tapCustomLogin: vm.tapCustomLogin,
          resetPassword: vm.resetPassword,
        );
      },
    );
  }
}

class _ViewModel {
  Function() tapGoogleLogin;
  Function() tapAppleLogin;
  Function() tapAnonymousLogin;
  Function(String, String) tapCustomLogin;
  Function(String) resetPassword;

  _ViewModel({
    required this.tapGoogleLogin,
    required this.tapAppleLogin,
    required this.tapAnonymousLogin,
    required this.tapCustomLogin,
    required this.resetPassword,
  });

  static _ViewModel fromStore(Store<AppState> store, BuildContext context,
      final Function() loginSuccessful, final Function() anonLoginSuccessful) {
    return _ViewModel(
      tapGoogleLogin: () {
        store.dispatch(GoogleLoginAction(
            onError: (e) {
              final snackBar = SnackBar(content: Text("Error while login"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            onSucces: loginSuccessful));
      },
      tapAppleLogin: () {
        store.dispatch(AppleLoginAction(
            onError: (e) {
              final snackBar = SnackBar(content: Text(e));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            onSucces: loginSuccessful)
        );
      },
      tapAnonymousLogin: () {
        store.dispatch(AnonymousLoginAction(
          onSucces: anonLoginSuccessful
        ));
      },
      tapCustomLogin: (String email, String password) {
        store.dispatch(CustomAccountLoginAction(
          user: email.trim(),
          password: password.trim(),
          onSucces: loginSuccessful,
          onError: (String code) {
            //final snackBar = SnackBar(content: Text("Error while login"));

            final snackBar = SnackBar(content: Text(AppLocalizations.of(context).translate('login.' + code)));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          onWrongCredentials: () {
            final snackBar = SnackBar(content: Text("Fout! Wachtwoord of email incorrect"));

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ));
      },
      resetPassword: (String email) {
        store.dispatch(ResetPassword(email: email));
      },
    );
  }
}
