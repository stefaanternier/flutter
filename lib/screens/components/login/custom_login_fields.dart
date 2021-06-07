import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';

import '../../../localizations.dart';

class CustomLoginFields extends StatefulWidget {
  String lang;
  Function onPressed;
  Function changePw;
  Function changeEmail;

  CustomLoginFields({this.lang, this.onPressed, this.changeEmail, this.changePw});

  @override
  _CustomLoginFieldsState createState() => _CustomLoginFieldsState();
}

class _CustomLoginFieldsState extends State<CustomLoginFields> {
  TextEditingController emailController;
  TextEditingController passwdController;

  @override
  void initState() {
    emailController =
        TextEditingController(text: AppConfig().loginConfig[widget.lang].defaultLoginName);
    passwdController =
        TextEditingController(text: AppConfig().loginConfig[widget.lang].defaultLoginPassword);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//                            padding: new EdgeInsets.all(10.0),
        child: new Form(
            // key: widget.formKey,

            child: new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          // Use email input type for emails.
          decoration: new InputDecoration(
              hintText: 'you@example.com',
              labelText: AppLocalizations.of(context).translate('login.emailAddress')),
          onTap: () {
            widget.onPressed(true);
          },
          onEditingComplete: () {
            widget.onPressed(false);
            FocusScope.of(context).unfocus();
          },
          onChanged: (String text) {
            widget.changeEmail(text);
          },
        ),
        new TextFormField(
          controller: passwdController,
          obscureText: true,
          // Use secure text for passwords.
          decoration: new InputDecoration(
              hintText: AppLocalizations.of(context).translate('login.password'),
              labelText: AppLocalizations.of(context).translate('login.password')),
          onChanged: (String text) {
            widget.changePw(text);
          },
          onTap: () {
            widget.onPressed(true);
          },
          onEditingComplete: () {
            widget.onPressed(false);
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    )));
  }
}
