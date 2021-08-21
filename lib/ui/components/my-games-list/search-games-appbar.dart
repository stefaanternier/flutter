import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';

import '../../../localizations.dart';

class SearchGamesAppbar extends StatefulWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  Function(String?) submitQuery;

  SearchGamesAppbar({
        required this.submitQuery,
      Key? key})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  _SearchGamesAppbarState createState() => _SearchGamesAppbarState();
}

class _SearchGamesAppbarState extends State<SearchGamesAppbar> {
  TextEditingController searchQuery = new TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    if (!isSearching) {
      return new AppBar(
          centerTitle: true,
          title: AppConfig().appBarIcon != null
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
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
            ),
          ]);
    }
    return new AppBar(
        centerTitle: true,
        title: new TextField(
          controller: searchQuery,
          onChanged: widget.submitQuery,
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
            onPressed: () {
              setState(() {
                isSearching = false;
                widget.submitQuery(null);
              });
            },
          ),
        ]);
  }
}
