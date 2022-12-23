import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/ui/components/collection/featured_game_carrousel.container.dart';
import 'package:youplay/ui/components/collection/my_runs_carrousel.dart';
import 'package:youplay/ui/components/collection/organisation_carrousel.container.dart';
import 'package:youplay/ui/components/collection/recent_games_list.container.dart';
import 'package:youplay/ui/components/collection/search_result_list.dart';
import 'package:youplay/ui/components/misc/list_separation_text.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../../localizations.dart';

class FeaturedGamesPage extends StatefulWidget {
  static final MaterialPage materialAuthPage =
      const MaterialPage(key: ValueKey('FeaturedGamesPage'), child: FeaturedGamesPage(authenticated: true));

  final bool authenticated;

  const FeaturedGamesPage({required this.authenticated});

  @override
  State<FeaturedGamesPage> createState() => _FeaturedGamesPageState();
}

class _FeaturedGamesPageState extends State<FeaturedGamesPage> {
  bool contentVisible = true;

  Timer? hideContent;

  @override
  initState() {
    super.initState();

    hideContent = Timer(Duration(milliseconds: 800), () {
      setState(() {
        contentVisible = true;
      });
    });
  }

  @override
  void dispose() {
    if (hideContent != null) {
      hideContent!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      drawer: ARLearnNavigationDrawerContainer(),
      appBar: AppBar(
        centerTitle: true,
        title: Hero(
          tag: 'redSquare',
          child: new Image(
            image: new AssetImage(AppConfig().appBarIcon!),
            height: 32.0,
            width: 32.0,
          ),
        ),
      ),
      body: //Container()
          Visibility(
        visible: contentVisible,
        child: WebWrapper(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListSeparationText(text: AppLocalizations.of(context).translate('library.featured')),
                FeaturedGamesCarrouselContainer(),
                OrganisationCarrouselContainer(),
                MyGamesCarrouselContainer(),

                // ListSeparationText(text: AppLocalizations.of(context).translate('library.allgames')),
                // RecentGamesResultListContainer(),
                // SearchResultListContainer(),
              ],
            ),
          ),
        ),
      ),
    );

    // });
  }
}
