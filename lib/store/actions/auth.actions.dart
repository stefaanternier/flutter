import 'package:firebase_storage/firebase_storage.dart';

class GoogleLoginAction {
  Function onError;
  Function onSucces;

  GoogleLoginAction({required this.onError, required this.onSucces});
}

class AppleLoginAction {
  Function onError;
  Function onSucces;

  AppleLoginAction({required this.onError, required this.onSucces});
}

class AnonymousLoginAction {
  Function()? onSucces;
  Function? onError;

  AnonymousLoginAction({this.onSucces, this.onError});
}

class TwitterLoginAction {}

class FacebookLoginAction {}

class CustomAccountLoginAction {
  String user;

  String password;

  Function(String) onError;
  Function onWrongCredentials;
  Function onSucces;

  CustomAccountLoginAction(
      {required this.user,
      required this.password,
      required this.onError,
      required this.onWrongCredentials,
      required this.onSucces});
}

class CreateAccount {
  String email;
  String password;
  String displayName;

  CreateAccount({required this.email, required this.password, required this.displayName});
}

class CreateAccountResult {
  CreateAccountResult();
}

class ResetPassword {
  String email;

  ResetPassword({required this.email});
}



class SetLoadingFinished {}

class ApiAccountDetailsAction {}

class AccountResultAction {
  dynamic account;

  AccountResultAction(this.account);
}

class InvalidCredentials {}

class GoogleLoginSucceededAction {
  String displayName;
  String email;
  final String uid;

  GoogleLoginSucceededAction(
      {required this.displayName, required this.email, required this.uid});
}

class TwitterLoginSucceededAction {
  String displayName;
  String email;

  TwitterLoginSucceededAction(this.displayName, this.email);
}

class FacebookLoginSucceededAction {
  String displayName;
  String email;

  FacebookLoginSucceededAction(this.displayName, this.email);
}

class AppleLoginSucceededAction {
  String displayName;
  String email;
  final String uid;
  AppleLoginSucceededAction(
      {required this.displayName, required this.email, required this.uid});
}

class CustomLoginSucceededAction {
  final String? displayName;
  final String? email;
  final String uid;
  final bool anon;

  CustomLoginSucceededAction(this.displayName, this.email, this.uid, this.anon);
}

class EraseAnonAccount {}

class EraseAnonAccountAndStartAgain {}

class SignOutAction {}

class SignOutActionAndRelogAnon {}

class SetFirebaseStorage {
  FirebaseStorage storage;

  SetFirebaseStorage({required this.storage});
}