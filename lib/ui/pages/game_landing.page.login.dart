import 'package:flutter/material.dart';
import 'package:youplay/screens/components/login/login_screen.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../../localizations.dart';

class GameLandingLoginPage extends StatelessWidget {
  Function() loginSucces;
  GameLandingLoginPage({
    required this.loginSucces,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ARLearnNavigationDrawerContainer(),
      appBar: new AppBar(
          centerTitle: true,
          title: new Text(AppLocalizations.of(context).translate('library.library'),
              style: new TextStyle(color: Colors.white))),
      body: WebWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: LoginScreen(
                  lang: Localizations.localeOf(context).languageCode,
                  onSuccess: loginSucces
                      // () {
                    // setState(() {
                    //   this.showLogin = false;
                    //   gameLandingPageModel.loadRuns();
                    // });
                  // }),
              )
            ),
          ],
        ),
      ),
    );
  }
}
