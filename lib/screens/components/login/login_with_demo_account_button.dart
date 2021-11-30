import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youplay/config/app_config.dart';

import '../../../localizations.dart';

class DemoLoginButton extends RaisedButton {
//  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  DemoLoginButton(tapButton, context)
      : super(
      color: const Color(0xffb2076a),
      splashColor: Theme.of(context).buttonColor,
      onPressed: () {
        var lang = Localizations.localeOf(context).languageCode;
        final emailController = TextEditingController(text:AppConfig().loginConfig![lang].defaultLoginName);
        final passwdController = TextEditingController(text:AppConfig().loginConfig![lang].defaultLoginPassword);

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content:  new Container(
//                            padding: new EdgeInsets.all(10.0),
                    child:  new Form(
//                      key: _formKey,

                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          new TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress, // Use email input type for emails.
                              decoration: new InputDecoration(
                                  hintText: 'you@example.com',
                                  labelText: AppLocalizations.of(context).translate('login.emailAddress')
                              )
                          ),
                          new TextFormField(
                              controller: passwdController,
                              obscureText: true, // Use secure text for passwords.
                              decoration: new InputDecoration(
                                  hintText: AppLocalizations.of(context).translate('login.password'),
                                  labelText: AppLocalizations.of(context).translate('login.password')
                              )
                          ),
                        ],
                      ),
                    )
                ),


                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text(AppLocalizations.of(context).translate('login.close')),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new RaisedButton(
//                    color: Theme.of(context).accentColor,
//                    splashColor: Colors.red,?
                    child: new Text(
                      AppLocalizations.of(context).translate('login.login'),
                      style: new TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: ()  {

                      tapButton(emailController.text, passwdController.text);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
        //loginScreenViewModel.tapCustomLogin();

      },
      child: Row(
        children: <Widget>[
          Icon(
            FontAwesomeIcons.book,
            color: Colors.white,
          ),
          Expanded(
              child: Text(
                AppLocalizations.of(context).translate('login.loginWithDemo'),
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ))
        ],
      )
  );
}
