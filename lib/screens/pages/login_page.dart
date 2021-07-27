
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/screens/components/button/cust_flat_button.dart';
import 'package:youplay/screens/components/button/cust_raised_button.dart';
import 'package:youplay/screens/components/login/custom_login_fields.dart';
import 'package:youplay/screens/ui_models/login_model.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../../localizations.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        drawer: ARLearnNavigationDrawerContainer(),
        body: WebWrapper(child:_LoginScreenBody()));
  }
}

class _LoginScreenBody extends StatefulWidget {
  @override
  __LoginScreenBodyState createState() => __LoginScreenBodyState();
}

class __LoginScreenBodyState extends State<_LoginScreenBody> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _textFieldController = TextEditingController();

  bool hide = false;
  String email = '';
  String pw = '';

  Widget build(BuildContext context) {
    return new StoreConnector<AppState, LoginPageViewModel>(
        converter: (store) => LoginPageViewModel.fromStore(store, context),
        builder: (context, loginScreenViewModel) {


          Function pressCustomLogin = (email, pwd) {
            Navigator.of(context).pop();
          };

          CustomLoginFields fields = CustomLoginFields(
              onPressed: (h) {
                setState(() {
                  hide = h;
                });
              },
              changeEmail: (String e) {
                setState(() {
                  email = e;
                });
              },
              changePw: (String p) {
                setState(() {
                  pw = p;
                });
              },
              lang: Localizations
                  .localeOf(context)
                  .languageCode);
          CustomRaisedButton login = CustomRaisedButton(
              onPressed: () {
                loginScreenViewModel.tapCustomLogin(email, pw);
              },
              title: AppLocalizations.of(context).translate('login.login'));

          Row actions = Row(
            children: [
              FlatButton(
                  child: Text(
                      AppLocalizations.of(context).translate('login.forgot_password'),
                    style:  new TextStyle(color:  AppConfig().themeData!.primaryColor),

                  ),

                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(AppLocalizations.of(context).translate('login.recoverPw')),
                          content: TextField(
                            controller: _textFieldController,
                            decoration: InputDecoration(hintText: AppLocalizations.of(context).translate('login.emailAddress')),
                            onChanged: (String text) {
                              setState(() {
                                email = text;
                              });
                            },
                          ),
                          actions: [
                            FlatButton(
                              child: Text(AppLocalizations.of(context).translate('library.cancel')),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text(AppLocalizations.of(context).translate('login.ok'),
                                style:  new TextStyle(color:  AppConfig().themeData!.primaryColor)),
                              onPressed: () {
                                loginScreenViewModel.resetPassword(email);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }),
              FlatButton(
                child: Text('account aanmaken',
                  style:  new TextStyle(color:  AppConfig().themeData!.primaryColor),),
                onPressed: () {
                  loginScreenViewModel.tapCreateAccount();
                },
              )
            ],
          );

          if (loginScreenViewModel.authenticated) {
            loginScreenViewModel.loadMyGames();
          }
          return new Container(
            padding: EdgeInsets.all(32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: hide
                  ? [fields, login]
                  : [
                fields,
                FittedBox(fit: BoxFit.contain, child: actions),
                login,
                CustomFlatButton(
                  title: AppLocalizations.of(context).translate('login.loginWithGoogle'),
                  icon: FontAwesomeIcons.google,
                  onPressed: loginScreenViewModel.tapGoogleLogin,
                ),
                (UniversalPlatform.isIOS
                    ? CustomFlatButton(
                  color: Colors.black,
                  title: AppLocalizations.of(context).translate('login.loginWithApple'),
                  icon: FontAwesomeIcons.apple,
                  onPressed: loginScreenViewModel.tapAppleLogin,
                )
                    : Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                          height: 1.0,
                          width: 60.0,
                          color: AppConfig().themeData!.primaryColor),
                    ),
                    Text(AppLocalizations.of(context).translate('login.or'),
                        style: AppConfig().customTheme!.mcOptionTextStyle),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                          height: 1.0,
                          width: 60.0,
                          color: AppConfig().themeData!.primaryColor),
                    ),
                  ],
                ),
                CustomFlatButton(
                  onPressed: loginScreenViewModel.tapAnonymousLogin,
                  title: AppLocalizations.of(context).translate('login.loginWithDemo'),
                )
              ],
              // children: getLoginButtons(context, loginScreenViewModel)
            ),
          );
        });
  }
}
