import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/screens/components/button/cust_flat_button.dart';
import 'package:youplay/screens/components/button/cust_raised_button.dart';
import 'package:youplay/screens/components/login/custom_login_fields.dart';
import 'package:youplay/ui/components/login/login_action.container.dart';

import '../../../localizations.dart';
import 'login_or_widget.dart';

class LoginScreen extends StatefulWidget {
  Function() tapGoogleLogin;
  Function() tapAppleLogin;
  Function() tapAnonymousLogin;
  Function(String, String) tapCustomLogin;
  Function(String) resetPassword;
  final bool anonLogin;

  LoginScreen(
      {required this.tapGoogleLogin,
      required this.tapAppleLogin,
      required this.tapAnonymousLogin,
      required this.tapCustomLogin,
        required this.resetPassword,
        required this.anonLogin,
      Key? key})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool toggleCustomLogin = false;
  String email = '';
  String pw = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(32.0),
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomLoginFields(
                  onPressed: (h) {
                    setState(() {
                      toggleCustomLogin = h;
                    });
                  },
                  changeEmail: (String _email) {
                    setState(() {
                      email = _email;
                    });
                  },
                  changePw: (String _password) {
                    setState(() {
                      pw = _password;
                    });
                  },
                  lang: Localizations.localeOf(context).languageCode),
              if (!toggleCustomLogin) LoginActionContainer(
                keyboardIsShown: () {
                  setState(() {
                    toggleCustomLogin = true;
                  });

                },
                keyboardIsHidden: () {
                  setState(() {
                    toggleCustomLogin = false;
                  });
                }
              ),
              CustomRaisedButton(
                  onPressed: () {
                    widget.tapCustomLogin(email, pw);
                  },
                  title: AppLocalizations.of(context).translate('login.login')),
              if (!toggleCustomLogin)
                CustomFlatButton(
                  title: AppLocalizations.of(context).translate('login.loginWithGoogle'),
                  icon: FontAwesomeIcons.google,
                  onPressed: widget.tapGoogleLogin,
                ),
              if (!toggleCustomLogin && UniversalPlatform.isIOS)
                CustomFlatButton(
                  color: Colors.black,
                  title: AppLocalizations.of(context).translate('login.loginWithApple'),
                  icon: FontAwesomeIcons.apple,
                  onPressed: widget.tapAppleLogin,
                ),
              if (!toggleCustomLogin && widget.anonLogin) LoginOrWidget(),
              if (!toggleCustomLogin && widget.anonLogin)
                CustomFlatButton(
                  onPressed: widget.tapAnonymousLogin,
                  title: AppLocalizations.of(context).translate('login.loginWithDemo'),
                )
            ]));
  }
}
