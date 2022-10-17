import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/api/account.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

final FirebaseAuth _auth = FirebaseAuth.instance;

final authLoginAnonymousCredentialsEpic = combineEpics<AppState>([
  new TypedEpic<AppState, AnonymousLoginAction>(_anonymousLogin),
  new TypedEpic<AppState, EraseAnonAccount>(_eraseAnonAccount),
  new TypedEpic<AppState, EraseAnonAccountAndStartAgain>(_eraseAnonAccountAndStartAgain)
]);

Stream<dynamic> _anonymousLogin(
  Stream<AnonymousLoginAction> actions,
  EpicStore<AppState> store,
) {
  return actions.asyncMap((action) async {
    if (kIsWeb) {
      await _auth.setPersistence(Persistence.NONE);
    }
    return _auth
        .signInAnonymously()
        .then((UserCredential authResult) => authResult.user!.getIdToken().then((token) {
              if (action.onSucces != null) {
                action.onSucces!();
              }
              return new CustomLoginSucceededAction(
                  "anonymous", " ${authResult.user!.uid}", authResult.user!.uid, true);
            }))
        .catchError((error) {
      if (action.onError != null) {
        action.onError!();
      }
    });
  }) // .map((x) => x)
      ;
}

Stream<dynamic> _eraseAnonAccount(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is EraseAnonAccount).asyncMap((action) {
    return AccountApi.eraseAnonAcount().then((results) {
      return SignOutAction();
    });
  });
}

Stream<dynamic> _eraseAnonAccountAndStartAgain(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is EraseAnonAccountAndStartAgain).asyncMap((action) {
    return AccountApi.eraseAnonAcount().then((results) {
      return new SignOutActionAndRelogAnon();
    });
  });
}
