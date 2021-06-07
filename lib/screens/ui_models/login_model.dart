//import 'package:youplay/actions/actions.dart';
import 'package:youplay/selectors/authentication_selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';

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
      {this.authenticated,
        this.tapGoogleLogin,
        this.tapTwitterLogin,
        this.tapFacebookLogin,
        this.tapAppleLogin,
        this.tapAnonymousLogin,
        this.tapCustomLogin,
        this.resetPassword,
        this.tapCreateAccount,
        this.loadMyGames});

  static LoginPageViewModel fromStore(Store<AppState> store, BuildContext context) {
    return LoginPageViewModel(
      authenticated: isAuthenticatedSelector(store.state),
      tapGoogleLogin: () {
        store.dispatch(GoogleLoginAction(onError: (e) {
          final snackBar = SnackBar(content: Text("Error while login"));

          Scaffold.of(context).showSnackBar(snackBar);
          print("show snackbar 2?");
        }));
      },
      tapCreateAccount: () {
        print('in viewmodel');
        store.dispatch(new SetPage(PageType.makeAccount));
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
          }
        ));
      },
      tapFacebookLogin: () {
        store.dispatch(FacebookLoginAction());
      },
      tapCustomLogin: (String email, String password) {
        store.dispatch(CustomAccountLoginAction(
          user: email.trim(),
          password: password.trim(),
          onError: () {
            final snackBar = SnackBar(content: Text("Error while login"));

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
        store.dispatch(new SetPage(PageType.myGames));
      },
    );
  }
}
