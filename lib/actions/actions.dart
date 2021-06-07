import 'package:firebase_storage/firebase_storage.dart';

class SetLoadingFinished {

}


class ApiAccountDetailsAction{}

class AccountResultAction {
  dynamic account;

  AccountResultAction(this.account);
}

class InvalidCredentials {

}

class GoogleLoginSucceededAction {

  String displayName;
  String email;
  GoogleLoginSucceededAction(this.displayName, this.email);
}




class TwitterLoginSucceededAction {

  String displayName;
  String email;
  TwitterLoginSucceededAction( this.displayName, this.email);
}



class FacebookLoginSucceededAction {

  String displayName;
  String email;
  FacebookLoginSucceededAction( this.displayName, this.email);
}


class AppleLoginSucceededAction {

  String displayName;
  String email;
  AppleLoginSucceededAction(this.displayName, this.email);
}
class CustomLoginSucceededAction {

  String displayName;
  String email;
  String uid;
  bool anon ;
  CustomLoginSucceededAction(this.displayName, this.email, this.uid, this.anon);
}

class EraseAnonAccount{}
class EraseAnonAccountAndStartAgain{}

class SignOutAction{}
class SignOutActionAndRelogAnon{}

class SetFirebaseStorage {

  FirebaseStorage storage;

  SetFirebaseStorage({this.storage});
}
