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
  Function? onSucces;
  Function? onError;

  AnonymousLoginAction({this.onSucces, this.onError});
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
