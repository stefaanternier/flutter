import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';

import '../../../localizations.dart';

class LoginAction extends StatefulWidget {

  final Function(String) resetPassword;
  final Function() tapCreateAccount;
  final Function() keyboardIsShown;
  final Function() keyboardIsHidden;
  const LoginAction({
    required this.resetPassword,
    required this.tapCreateAccount,
    required this.keyboardIsShown,
    required this.keyboardIsHidden,
    Key? key}) : super(key: key);

  @override
  State<LoginAction> createState() => _LoginActionState();
}

class _LoginActionState extends State<LoginAction> {
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      // FittedBox(
      // fit: BoxFit.contain,
      // child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width /2)   - 35,
            child: TextButton(
                child: Text(
                  AppLocalizations.of(context).translate('login.forgot_password'),
                  style:  new TextStyle(color:  AppConfig().themeData!.primaryColor),
                  overflow: TextOverflow.ellipsis,
                ),

                onPressed: () {
                  widget.keyboardIsShown();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(AppLocalizations.of(context).translate('login.recoverPw')),
                        content: TextField(
                          controller: _textFieldController,
                          decoration: InputDecoration(hintText: AppLocalizations.of(context).translate('login.emailAddress')),
                          // onChanged: setEmail,
                        ),
                        actions: [
                          TextButton(
                            child: Text(AppLocalizations.of(context).translate('library.cancel')),
                            onPressed: () {
                              widget.keyboardIsHidden();
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(AppLocalizations.of(context).translate('login.ok'),
                                style:  new TextStyle(color:  AppConfig().themeData!.primaryColor)),
                            onPressed: () {
                              widget.keyboardIsHidden();
                              widget.resetPassword(_textFieldController.value.text);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }),
          ),
          Container(
            width: (MediaQuery.of(context).size.width /2)   -35,
            child: TextButton(
              child: Text('account aanmaken',
                overflow: TextOverflow.ellipsis,
                style:  new TextStyle(color:  AppConfig().themeData!.primaryColor),),
              onPressed: widget.tapCreateAccount,
            ),
          )
        ],
      // ),
    );
  }
}
