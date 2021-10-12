import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';

import '../../../localizations.dart';

class LoginOrWidget extends StatelessWidget {
  const LoginOrWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
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
    );
  }
}
