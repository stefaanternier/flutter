class GoogleLoginAction {
  Function onError;
  Function onSucces;

  GoogleLoginAction({this.onError, this.onSucces});
}

class AppleLoginAction {
  Function onError;
  Function onSucces;

  AppleLoginAction({this.onError, this.onSucces});
}

class AnonymousLoginAction {
  Function onSucces;
  Function onError;
}

class TwitterLoginAction {}

class FacebookLoginAction {}

class CustomAccountLoginAction {
  String user;

  String password;

  Function onError;
  Function onWrongCredentials;
  Function onSucces;

  CustomAccountLoginAction(
      {this.user, this.password, this.onError, this.onWrongCredentials, this.onSucces});
}

class CreateAccount {
  String email;
  String password;
  String displayName;

  CreateAccount({this.email, this.password, this.displayName});
}

class CreateAccountResult {
  CreateAccountResult();
}

class ResetPassword {
  String email;

  ResetPassword({this.email});
}
