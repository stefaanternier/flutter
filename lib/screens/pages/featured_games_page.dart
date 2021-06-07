import 'package:youplay/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:youplay/screens/components/featured_games/featured_game_card.dart';
import 'package:youplay/screens/components/featured_games/featured_game_carrousel.dart';
import 'package:youplay/screens/components/my_game_list/list_seperation_text.dart';
import 'package:youplay/screens/components/search_widget/recent_games_list.dart';
import 'package:youplay/screens/components/search_widget/search.dart';
import 'package:youplay/screens/components/search_widget/search_result_list.dart';
import 'package:youplay/screens/ui_models/featured_games_model.dart';
import 'package:youplay/screens/util/navigation_drawer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/store/state/app_state.dart';
import '../../localizations.dart';

class FeaturedGamesPage extends StatelessWidget {
  final bool authenticated;

  FeaturedGamesPage({this.authenticated});

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
          return new Scaffold(
            drawer: ARLearnNavigationDrawer(),
            appBar: new AppBar(
                centerTitle: true,
                title: AppConfig().appBarIcon != null ?  new Image(
                  image: new AssetImage(
                      AppConfig().appBarIcon),
                  height: 32.0,
                  width: 32.0,
                ):new Text(AppLocalizations.of(context).translate('library.library'),
                    style: new TextStyle(color: Colors.white))),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      child: SearchBar()),
                  ListSeparationText(text: AppLocalizations.of(context).translate('library.featured')),
                  FeaturedGamesCarrousel(),
                  ListSeparationText(text: AppLocalizations.of(context).translate('library.allgames')),
                  RecentGamesResultList(),
                  SearchResultList(),

                ],
              ),
            ),
          );
        // });
  }
}
