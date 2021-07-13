import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/store/actions/game_library.actions.dart';

import '../../../localizations.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController searchQuery = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, Store>(
        converter: (store) => store,
        builder: (context, store) {
          return new TextField(
            controller: searchQuery,
            onChanged: (val) {
              store.dispatch(new SearchLibrary(query:val));
            },
            style: new TextStyle(
              color: AppConfig().themeData!.primaryColor,
            ),
            decoration: new InputDecoration(
                prefixIcon: new Icon(Icons.search, color: AppConfig().themeData!.primaryColor),
                hintText: AppLocalizations.of(context).translate('games.search'),
                hintStyle: new TextStyle(color: Colors.white)),
          );
        });
  }
}
