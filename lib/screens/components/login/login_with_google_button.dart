import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../localizations.dart';



class GoogleLoginButton extends RaisedButton {
  GoogleLoginButton(tapButton, context)
      : super(
            color: const Color(0xffdd4b39),
            splashColor: Theme.of(context).buttonColor,
            onPressed: () {
              tapButton();
            },
            child: Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                ),
                Expanded(
                    child: Text(
                      AppLocalizations.of(context).translate('login.loginWithGoogle'),
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ))
              ],
            ));
}
