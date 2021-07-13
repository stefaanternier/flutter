import 'package:youplay/models/models.dart';
import 'package:youplay/state/authentication_state.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/actions.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authenticationReducer = combineReducers<AuthenticationState>([
  new TypedReducer<AuthenticationState, GoogleLoginSucceededAction>(
      _setGoogleIdToken),
  // new TypedReducer<AuthenticationState, TwitterLoginSucceededAction>(
  //     _setTwitterIdToken),
  new TypedReducer<AuthenticationState, FacebookLoginSucceededAction>(
      _setFacebookIdToken),
  new TypedReducer<AuthenticationState, AppleLoginSucceededAction>(
      _setAppleIdToken),
  new TypedReducer<AuthenticationState, CustomLoginSucceededAction>(
      _setCustomLoginIdToken),
  new TypedReducer<AuthenticationState, SignOutAction>(_logout),
]);

AuthenticationState _setGoogleIdToken(
    AuthenticationState auth, GoogleLoginSucceededAction action) {
  return new AuthenticationState(
      userId: action.uid,
      authenticated: true,
      email: action.email,
      name: action.displayName,
      anon: false);
}

AuthenticationState _setAppleIdToken(
    AuthenticationState auth, AppleLoginSucceededAction action) {
  return new AuthenticationState(
      userId: auth.userId,
      authenticated: true,
      email: action.email == null ? '' : action.email,
      name: action.displayName,
      anon: false);
}

// AuthenticationState _setTwitterIdToken(
//     AuthenticationState auth, TwitterLoginSucceededAction action) {
//   return new AuthenticationState(
//       authenticated: true,
//       email: action.email == null ? '' : action.email,
//       name: action.displayName,
//       anon: false);
// }

AuthenticationState _setFacebookIdToken(
    AuthenticationState auth, FacebookLoginSucceededAction action) {
  return new AuthenticationState(
      authenticated: true,
      userId: auth.userId,
      email: action.email == null ? '' : action.email,
      name: action.displayName,
      anon: false);
}

AuthenticationState _setCustomLoginIdToken(
    AuthenticationState auth, CustomLoginSucceededAction action) {
  return new AuthenticationState(
      userId: action.uid,
      authenticated: true,
      email: action.email ?? '',
      name: action.displayName ?? '',
      anon: action.anon);
}

AuthenticationState _logout(AuthenticationState auth, SignOutAction logout) {
  return new AuthenticationState(
      authenticated: false, userId: '', email: '', name: '');
}
