

import 'package:flutter/material.dart';
import 'package:youplay/ui/components/collection/organisation_games_list.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/organisation/app_bar_title.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class OrganisationPage extends StatelessWidget {
  static final MaterialPage materialPage = MaterialPage(
    key: ValueKey('StrygooHome'),
    child: OrganisationPage(),
  );


  const OrganisationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
        drawer: ARLearnNavigationDrawerContainer(),
        appBar: AppBar(
          centerTitle: true,
          title: OrganisationAppBarTitleContainer(),
        ),
        body: WebWrapper(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [



                OrganisationGamesListContainer(),
              ],
            ),
          ),
        ),

    );
  }
}
