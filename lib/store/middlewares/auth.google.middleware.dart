// import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:youplay/api/account.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/state/app_state.dart';

import '../actions/actions.collection.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

//todo apple signin
// AppleSignIn _appleSignIn = AppleSignIn();

//Epics

final authLoginGoogleEpic =
    new TypedEpic<AppState, GoogleLoginAction>(googleLogin);
final authLoginAppleEpic =
    new TypedEpic<AppState, AppleLoginAction>(appleLogin);
final authLogoutEpic = new TypedEpic<AppState, SignOutAction>(signOut);
final authReloginEpic = new TypedEpic<AppState, SignOutActionAndRelogAnon>(
    _signOutActionAndRelogAnon);

final loadAppleCredentials =
    new TypedEpic<AppState, AppleLoginSucceededAction>(loadCredentials);
final loadGoogleCredentials =
    new TypedEpic<AppState, GoogleLoginSucceededAction>(
        loadGoogleAccountDetails);

Stream<dynamic> loadCredentials(
  Stream<AppleLoginSucceededAction> actions,
  EpicStore<AppState> store,
) {
  return actions
      .where((action) => action is AppleLoginSucceededAction)
      .asyncMap((action) async {
    await AccountApi.accountDetails();
    return null;
  });
}

Stream<dynamic> loadGoogleAccountDetails(
  Stream<GoogleLoginSucceededAction> actions,
  EpicStore<AppState> store,
) {
  return actions
      .where((action) => action is GoogleLoginSucceededAction)
      .asyncMap((action) async {
    await AccountApi.accountDetails();
    return null;
  });
}

Stream<dynamic> googleLogin(
  Stream<GoogleLoginAction> actions,
  EpicStore<AppState> store,
) {
  return actions.asyncMap((action) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    if (googleAuth != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        action.onSucces();
        return new GoogleLoginSucceededAction(
            displayName: userCredential.user!.displayName ?? '',
            email: userCredential.user!.email ?? '',
          uid: userCredential.user!.uid,
        );
      }
    }
  });
}


Stream<dynamic> appleLogin(
  Stream<AppleLoginAction> actions,
  EpicStore<AppState> store,
) {
  return actions.asyncMap((action) async {
    try {
      // final AuthorizationResult result = await AppleSignIn.performRequests([
      //   AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      // ]);

      final AuthorizationCredentialAppleID result = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

final oAuthProvider = OAuthProvider('apple.com');
final credential = oAuthProvider.credential(
              idToken: result.identityToken,
              accessToken:
                  result.authorizationCode,
            );
            UserCredential userCredential =
                await FirebaseAuth.instance.signInWithCredential(credential);
            action.onSucces();
            return new AppleLoginSucceededAction(
              displayName: userCredential.user?.displayName ?? '',
                uid: userCredential.user?.uid ?? '',
                email: userCredential.user?.email??'');
      // result.
      // switch (result.status) {
      //   case AuthorizationStatus.authorized:
      //     try {
      //       print("successfull sign in");
      //       final AppleIdCredential appleIdCredential = result.credential;
      //       final oAuthProvider = OAuthProvider('apple.com');
      //       final credential = oAuthProvider.credential(
      //         idToken: String.fromCharCodes(appleIdCredential.identityToken),
      //         accessToken:
      //             String.fromCharCodes(appleIdCredential.authorizationCode),
      //       );
      //       UserCredential userCredential =
      //           await FirebaseAuth.instance.signInWithCredential(credential);
      //       return new AppleLoginSucceededAction(
      //           userCredential.user.displayName, userCredential.user.email);
      //
      //     } catch (e) {
      //       print("error");
      //     }
      //     break;
      //   case AuthorizationStatus.error:
      //     // do something
      //     action.onError("something went wrong");
      //     break;
      //
      //   case AuthorizationStatus.cancelled:
      //     action.onError("Inloggen afgebroken door gebruiker");
      //     break;
      // }
    } on SignInWithAppleAuthorizationException catch ( error) {
      print('errror is ${error}');
      if (error.code == AuthorizationErrorCode.canceled) {
        action.onError("Inloggen werd geannuleerd");
      }
      action.onError("Inloggen mislukt");
    } catch (error) {

      action.onError("Inloggen mislukt!");
    }
  });
}

Stream<dynamic> signOut(
  Stream<SignOutAction> actions,
  EpicStore<AppState> store,
) {
  return actions.asyncExpand((action) async* {
    await FirebaseAuth.instance.signOut();
    // .then((value) {
    //   print("sign out result ");
    // });
    // return null;
    yield LoadFeaturedGameRequest();
    yield LoadRecentGameRequest();
  });
}

Stream<dynamic> _signOutActionAndRelogAnon(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
      .where((action) => action is SignOutActionAndRelogAnon)
      .asyncMap(((action) async {
    return FirebaseAuth.instance.signOut().then((value) {
      return AnonymousLoginAction(); // no more actions to post to server
    });
  }));
}
