class LoginConfig {
  bool showDefaultLogin;
  String defaultLoginName;
  String defaultLoginPassword;

  LoginConfig(
      {bool showDefaultLogin,
      String defaultLoginName = '',
      String defaultLoginPassword = ''}) {
    this.showDefaultLogin = showDefaultLogin;
    this.defaultLoginName = defaultLoginName;
    this.defaultLoginPassword = defaultLoginPassword;
  }
}
