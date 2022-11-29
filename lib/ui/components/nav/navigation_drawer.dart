import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/models/organisation.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/ui/components/nav/user_account_header.container.dart';

import '../../../localizations.dart';

class ARLearnNavigationDrawer extends StatelessWidget {
  bool showCurrentGame;
  String? currentGameTitle;
  Function(PageType, String?) tapPage;
  Function() tapExit;
  Function() tapCollection;
  bool isAnon;
  bool isAuthenticated;
  Organisation? organisation;

  ARLearnNavigationDrawer({required this.showCurrentGame,
    this.currentGameTitle,
    required this.tapPage,
    required this.tapExit,
    required this.tapCollection,
    required this.isAnon,
    required this.isAuthenticated,
    this.organisation,
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
                  Scaffold.of(context).openEndDrawer();
                  tapPage(PageType.game, null);
                }),
          if (showCurrentGame) Divider(),
          if (!isAnon)
            ListTile(
              leading: Icon(Icons.person),
              title:
              Text(AppLocalizations.of(context).translate('games.myGames')),
              onTap: () {
                Scaffold.of(context).openEndDrawer();
                tapPage(PageType.myGames, null);
              },
            ),
          ListTile(
            leading: Icon(Icons.list),
            title:
            Text(AppLocalizations.of(context).translate('library.library')),
            onTap: () {
              Scaffold.of(context).openEndDrawer();
              tapCollection();
              tapPage(PageType.featured, null);
            },
          ),
          if (organisation != null)
            ListTile(
              leading: Icon(Icons.library_books),
              title:
              Text(organisation!.name),
              onTap: () {
                Scaffold.of(context).openEndDrawer();
                tapCollection();
                tapPage(PageType.organisationLandingPage, organisation!.id);
              },
            ),
          if (!UniversalPlatform.isWeb)
            ListTile(
              leading: Icon(FontAwesomeIcons.qrcode),
              title: Text(AppLocalizations.of(context).translate('scan.scan')),
              onTap: () {
                Scaffold.of(context).openEndDrawer();
                tapPage(PageType.scanGame, null);
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
                Scaffold.of(context).openEndDrawer();
                tapPage(PageType.login, null);
              },
            ),
        ],
      ),
    );
  }
}
