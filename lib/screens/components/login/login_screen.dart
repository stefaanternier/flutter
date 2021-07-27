import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/screens/components/button/cust_flat_button.dart';
import 'package:youplay/screens/components/button/cust_raised_button.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../../localizations.dart';

class LoginScreen extends StatefulWidget {
  String lang;
  Function onSuccess;

  LoginScreen({required this.lang, required this.onSuccess});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwdController;

  @override
  void initState() {
    emailController = TextEditingController(
        text: AppConfig().loginConfig![widget.lang]?.defaultLoginName ??
            AppConfig().loginConfig!['nl']?.defaultLoginName ??
            '');
    passwdController = TextEditingController(
        text:
            AppConfig().loginConfig![widget.lang]?.defaultLoginPassword ??
                AppConfig().loginConfig!['nl']?.defaultLoginPassword ??
                '');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                // Use email input type for emails.
                decoration: new InputDecoration(
                    hintText: 'you@example.com',
                    labelText: AppLocalizations.of(context)
                        .translate('login.emailAddress'))),
            SizedBox(height: 20),
            new TextFormField(
                controller: passwdController,
                obscureText: true, // Use secure text for passwords.
                decoration: new InputDecoration(
                    hintText: AppLocalizations.of(context)
                        .translate('login.password'),
                    labelText: AppLocalizations.of(context)
                        .translate('login.password'))),
            SizedBox(height: 20),
            new StoreConnector<AppState, dynamic>(
                distinct: true,
                converter: (store) => store,
                builder: (context, store) => CustomRaisedButton(
                      title: "INLOGGEN",

//            icon: new Icon(Icons.play_circle_outline, color: Colors.white),
                      onPressed: () {
                        store.dispatch(CustomAccountLoginAction(
                            user: emailController.text,
                            password: passwdController.text,
                            onError: (String code) {
                              // final snackBar =
                              //     SnackBar(content: Text("Error while login"));
                              final snackBar = SnackBar(content: Text(AppLocalizations.of(context).translate('login.'+code)));

                              Scaffold.of(context).showSnackBar(snackBar);
                              print("show snackbar?");
                            },
                            onWrongCredentials: () {
                              final snackBar = SnackBar(
                                  content: Text(
                                      "Fout! Wachtwoord of email incorrect"));

                              Scaffold.of(context).showSnackBar(snackBar);
                            },
                            onSucces: () {
                              widget.onSuccess();
                            }));
                      },
                    )),
            SizedBox(height: 20),
            new StoreConnector<AppState, dynamic>(
                distinct: true,
                converter: (store) => store,
                builder: (context, store) => CustomFlatButton(
                      title: AppLocalizations.of(context)
                          .translate('login.loginWithGoogle'),
                      icon: FontAwesomeIcons.google,
                      onPressed: () {
                        store.dispatch(GoogleLoginAction(onSucces: () {
                          widget.onSuccess();
                        }, onError: () {
                          final snackBar = SnackBar(
                              content: Text("Inloggen werd afgebroken"));

                          Scaffold.of(context).showSnackBar(snackBar);
                        }));
                      },
                    )),
            SizedBox(height: 20),
            (UniversalPlatform.isIOS
                ? new StoreConnector<AppState, dynamic>(
                    distinct: true,
                    converter: (store) => store,
                    builder: (context, store) => CustomFlatButton(
                          title: AppLocalizations.of(context)
                              .translate('login.loginWithApple'),
                          icon: FontAwesomeIcons.apple,
                          onPressed: () {
                            store.dispatch(AppleLoginAction(onSucces: () {
                              widget.onSuccess();
                            }, onError: (e) {
                              final snackBar = SnackBar(content: Text(e));
                              Scaffold.of(context).showSnackBar(snackBar);
                            }));
                          },
                        ))
                : Container()),
          ],
        ),
      ),
    );
  }
}
