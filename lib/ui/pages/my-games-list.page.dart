import 'package:youplay/screens/components/my_game_list/game_list_app_bar.dart';
import 'package:youplay/screens/components/my_game_list/game_list_tile.dart';
import 'package:youplay/screens/components/my_game_list/list_seperation_text.dart';
import 'package:youplay/ui/components/my-games-list/game_info_list_tile.dart';
import 'package:youplay/screens/ui_models/my_games_list_model.dart';
import 'package:youplay/ui/components/my-games-list/my-games-list.container.dart';
import 'package:youplay/ui/components/my-games-list/search-games-appbar.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../../localizations.dart';

class MyGamesListPageNew extends StatelessWidget {
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
                ListSeparationText(
                    text: AppLocalizations.of(context).translate('games.myGames').toUpperCase()
                ),
                MyGamesListContainer()
              ]),
        ),
      ),
    );
  }
}
