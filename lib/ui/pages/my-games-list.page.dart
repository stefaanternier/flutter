import 'package:flutter/material.dart';
import 'package:youplay/ui/components/misc/list_separation_text.dart';
import 'package:youplay/ui/components/my-games-list/my-games-list.container.dart';
import 'package:youplay/ui/components/my-games-list/search-games-appbar.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../../localizations.dart';

class MyGamesListPageNew extends StatelessWidget {
  static final MaterialPage materialPage =
      MaterialPage(key: ValueKey('MyGamesListPageNew'), child: MyGamesListPageNew());

  const MyGamesListPageNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: SearchGamesAppbarContainer(),
      drawer: ARLearnNavigationDrawerContainer(),
      body: WebWrapper(
        child: SingleChildScrollView(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListSeparationText(text: AppLocalizations.of(context).translate('games.myGames').toUpperCase()),
                MyGamesListContainer()
              ]),
        ),
      ),
    );
  }
}
