import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../localizations.dart';



class AnonymousLoginButton extends RaisedButton {
  AnonymousLoginButton(tapButton, context)
      : super(
      color: const Color(0xffdd4b39),
      splashColor: Theme.of(context).buttonColor,
      onPressed: () {
        tapButton();
      },
      child: Row(
        children: <Widget>[
          Icon(
            FontAwesomeIcons.eyeSlash,
            color: Colors.white,
          ),
          Expanded(
              child: Text(
                AppLocalizations.of(context).translate('login.loginWithAnonymous'),
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ))
        ],
      ));
}
