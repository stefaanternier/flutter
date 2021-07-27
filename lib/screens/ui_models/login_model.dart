//import 'package:youplay/actions/actions.dart';
import 'package:youplay/selectors/authentication_selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';

import '../../localizations.dart';

class LoginPageViewModel {
  bool authenticated;
  Function tapGoogleLogin;
  Function tapTwitterLogin;
  Function tapFacebookLogin;
  Function tapAppleLogin;
  Function tapAnonymousLogin;
  Function tapCustomLogin;
  Function resetPassword;
  Function tapCreateAccount;
  Function loadMyGames;

//  final Store<AppState> store;

  LoginPageViewModel(
      {required this.authenticated,
        required  this.tapGoogleLogin,
        required this.tapTwitterLogin,
        required this.tapFacebookLogin,
        required this.tapAppleLogin,
        required this.tapAnonymousLogin,
        required this.tapCustomLogin,
        required this.resetPassword,
        required this.tapCreateAccount,
        required this.loadMyGames});

  static LoginPageViewModel fromStore(Store<AppState> store, BuildContext context) {
    return LoginPageViewModel(
      authenticated: isAuthenticatedSelector(store.state),
      tapGoogleLogin: () {
        store.dispatch(GoogleLoginAction(onError: (e) {
          final snackBar = SnackBar(content: Text("Error while login"));

          Scaffold.of(context).showSnackBar(snackBar);
          print("show snackbar 2?");
        },
        onSucces: (){}));
      },
      tapCreateAccount: () {
        print('in viewmodel');
        store.dispatch(new SetPage(page: PageType.makeAccount));
      },
      tapTwitterLogin: () {
        store.dispatch(TwitterLoginAction());
      },
      tapAnonymousLogin: () {
        store.dispatch(AnonymousLoginAction());
      },
      tapAppleLogin: () {

        store.dispatch(AppleLoginAction(
          onError: (e) {
            final snackBar = SnackBar(content: Text(e));
            Scaffold.of(context).showSnackBar(snackBar);
          },
            onSucces: (){}
        ));
      },
      tapFacebookLogin: () {
        store.dispatch(FacebookLoginAction());
      },
      tapCustomLogin: (String email, String password) {
        store.dispatch(CustomAccountLoginAction(
          user: email.trim(),
          password: password.trim(),
          onSucces: (){},
          onError: (String code) {
            //final snackBar = SnackBar(content: Text("Error while login"));

            final snackBar = SnackBar(content: Text(AppLocalizations.of(context).translate('login.'+code)));
            Scaffold.of(context).showSnackBar(snackBar);
            print("show snackbar?");
          },
          onWrongCredentials: () {
            final snackBar = SnackBar(content: Text("Fout! Wachtwoord of email incorrect"));

            Scaffold.of(context).showSnackBar(snackBar);
          },
        ));
      },
      resetPassword: (String email) {
        store.dispatch(ResetPassword(email: email));
      },
      loadMyGames: () {
        store.dispatch(new SetPage(page: PageType.myGames));
      },
    );
  }
}
