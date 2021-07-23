import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';

import '../../../localizations.dart';

class GameListAppBar {
  bool isSearching;
  TextEditingController searchQuery;
  Function startSearching;
  Function stopSearching;

  GameListAppBar(
      {required this.isSearching,
      required this.searchQuery,
      required this.startSearching,
      required this.stopSearching});

  AppBar build(BuildContext context) {
    if (!isSearching) {
      return new AppBar(
          centerTitle: true,
          title: //Image.asset('graphics/icon/bibendocircleicon.png', fit: BoxFit.cover),
              AppConfig().appBarIcon != null
                  ? new Image(
                      image: new AssetImage(AppConfig().appBarIcon!),
                      height: 32.0,
                      width: 32.0,
                    )
                  : new Text(
                      AppLocalizations.of(context).translate('games.myGames'),
                      style: new TextStyle(color: Colors.white),
                    ),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: (){
                startSearching();
              },
            ),
          ]);
    }

    return new AppBar(
        centerTitle: true,
        title: new TextField(
          controller: searchQuery,
          style: new TextStyle(
            color: Colors.white,
          ),
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search, color: Colors.white),
              hintText: AppLocalizations.of(context).translate('games.search'),
              hintStyle: new TextStyle(color: Colors.white)),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: (){
              stopSearching();
            },
          ),
        ]);
  }
}
