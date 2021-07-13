import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/actions/actions.dart';
import 'package:youplay/api/account.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/app_state.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final authLoginCustomCredentialsEpic =
    new TypedEpic<AppState, CustomAccountLoginAction>(customCredentialsLogin);
final createAccountEpic =
    new TypedEpic<AppState, CreateAccount>(_createAccount);
final resetPasswordEpic = new TypedEpic<AppState, ResetPassword>(_resetPassord);

Stream<dynamic> _createAccount(
  Stream<CreateAccount> actions,
  EpicStore<AppState> store,
) {
  return actions.asyncMap((action) => _auth
          .createUserWithEmailAndPassword(
              email: action.email, password: action.password)
          .then((value) {
        return AccountApi.initNewAccount(action.email, action.displayName)
            .then((value) => SetPage(PageType.login));
        // return CreateAccountResult();
      }).catchError((onError) => {print('todo erro ')}));
}

Stream<dynamic> _resetPassord(
    Stream<ResetPassword> actions, EpicStore<AppState> store) {
  return actions.asyncMap((action) =>
      _auth.sendPasswordResetEmail(email: action.email).then((value) {
        return SetPage(PageType.login);
      }).catchError((onError) => {print('todo erro ')}));
}

Stream<dynamic> customCredentialsLogin(
  Stream<CustomAccountLoginAction> actions,
  EpicStore<AppState> store,
) {
  return actions.asyncMap((action) => _auth
          .signInWithEmailAndPassword(
              email: action.user, password: action.password)
          .then((authResult) => authResult.user!.getIdToken().then((token) {
                if (action.onSucces != null) {
                  action.onSucces();
                }
                if (AppConfig().analytics != null) {
                  AppConfig()
                      .analytics!
                      .logLogin(loginMethod: "identities")
                      .then((value) => {
                            // print("login complete " )
                          });
                }

                return new CustomLoginSucceededAction(
                    authResult.user!.displayName,
                    authResult.user!.email,
                    authResult.user!.uid,
                    false);
              }))
          .catchError((error) {
        if (error.code == "ERROR_INVALID_EMAIL") {
          action.onWrongCredentials();
        } else if (error.code == "ERROR_WRONG_PASSWORD") {
          action.onWrongCredentials();
        } else {
          print("login error is ${error}");
          action.onError();
        }
      }));
}
