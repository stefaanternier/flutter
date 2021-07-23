import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/ui/components/nav/user_account_header.container.dart';

import '../../../localizations.dart';

class ARLearnNavigationDrawer extends StatelessWidget {
  bool showCurrentGame;
  String? currentGameTitle;
  Function(PageType) tapPage;
  Function() tapExit;
  bool isAnon;
  bool isAuthenticated;

  ARLearnNavigationDrawer(
      {required this.showCurrentGame,
      this.currentGameTitle,
      required this.tapPage,
      required this.tapExit,
      required this.isAnon,
      required this.isAuthenticated,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountHeaderContainer(),
          if (showCurrentGame)
            ListTile(
                leading: Icon(Icons.gamepad),
                title: Text('${currentGameTitle}'),
                onTap: () {
                  tapPage(PageType.game);
                }),
          if (showCurrentGame) Divider(),
          if (!isAnon)
            ListTile(
              leading: Icon(Icons.person),
              title:
                  Text(AppLocalizations.of(context).translate('games.myGames')),
              onTap: () {
                tapPage(PageType.myGames);
              },
            ),
          ListTile(
            leading: Icon(Icons.list),
            title:
                Text(AppLocalizations.of(context).translate('library.library')),
            onTap: () {
              tapPage(PageType.featured);
            },
          ),
          if (!UniversalPlatform.isWeb)
            ListTile(
              leading: Icon(FontAwesomeIcons.qrcode),
              title: Text(AppLocalizations.of(context).translate('scan.scan')),
              onTap: () {
                tapPage(PageType.scanGame);
              },
            ),
          Divider(),
          if (isAuthenticated)
            ListTile(
              leading: Icon(Icons.logout),
              title: isAnon
                  ? Text(AppLocalizations.of(context)
                      .translate('login.anonlogout'))
                  : Text(
                      AppLocalizations.of(context).translate('login.logout')),
              onTap: tapExit,
            ),
          if (!isAuthenticated)
            ListTile(
              leading: Icon(Icons.login),
              title:
                  Text(AppLocalizations.of(context).translate('login.login')),
              onTap: () {
                tapPage(PageType.login);
              },
            ),
        ],
      ),
    );
  }
}
