import 'package:firebase_storage/firebase_storage.dart';

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
