import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/screens/components/featured_games/featured_game_carrousel.dart';
import 'package:youplay/screens/components/my_game_list/list_seperation_text.dart';
// import 'package:youplay/screens/components/search_widget/recent_games_list.dart';

import 'package:youplay/ui/components/collection/collection_search.container.dart';
import 'package:youplay/ui/components/collection/search_result_list.dart';
import 'package:youplay/ui/components/collection/recent_games_list.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../../localizations.dart';

class FeaturedGamesPage extends StatelessWidget {
  final bool authenticated;

  FeaturedGamesPage({required this.authenticated});

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return new Scaffold(
      drawer: ARLearnNavigationDrawerContainer(),
      appBar: new AppBar(
          centerTitle: true,
          title: AppConfig().appBarIcon != null
              ? new Image(
                  image: new AssetImage(AppConfig().appBarIcon!),
                  height: 32.0,
                  width: 32.0,
                )
              : new Text(
                  AppLocalizations.of(context).translate('library.library'),
                  style: new TextStyle(color: Colors.white))),
      body: WebWrapper(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: CollectionSearchFieldContainer()),
              ListSeparationText(
                  text: AppLocalizations.of(context)
                      .translate('library.featured')),
              FeaturedGamesCarrousel(),
              ListSeparationText(
                  text: AppLocalizations.of(context)
                      .translate('library.allgames')),
              RecentGamesResultListContainer(),
              SearchResultListContainer(),
            ],
          ),
        ),
      ),
    );
    // });
  }
}
