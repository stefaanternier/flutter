import 'package:youplay/screens/components/my_game_list/game_list_app_bar.dart';
import 'package:youplay/screens/components/my_game_list/game_list_tile.dart';
import 'package:youplay/screens/components/my_game_list/list_seperation_text.dart';
import 'package:youplay/screens/components/search_widget/game_info_list_tile.dart';
import 'package:youplay/screens/ui_models/my_games_list_model.dart';
import 'package:youplay/screens/util/navigation_drawer.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../localizations.dart';

class MyGamesListPage extends StatefulWidget {
  MyGamesListPage({Key key}) : super(key: key);

  @override
  _MyGamesState createState() => new _MyGamesState();
}

class _MyGamesState extends State<MyGamesListPage> {
  bool _IsSearching;
  final TextEditingController _searchQuery = new TextEditingController();
  String _searchText = "";

  _MyGamesState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, MyGamesListViewModel>(
        distinct: true,
        converter: (store) => MyGamesListViewModel.fromStore(store),
        builder: (context, myGamesView) => buildGameScreen(context, myGamesView));
  }

  Widget buildGameScreen(BuildContext context, MyGamesListViewModel gameListViewModel) {
    return new Scaffold(
      appBar: GameListAppBar(
          isSearching: this._IsSearching,
          searchQuery: _searchQuery,
          startSearching: () {
            setState(() {
              _IsSearching = true;
            });
          },
          stopSearching: () {
            setState(() {
              _IsSearching = false;
              _searchQuery.clear();
            });
          }).build(context),
      drawer: ARLearnNavigationDrawer(),
      body: SingleChildScrollView(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              ListSeparationText(text: AppLocalizations.of(context).translate('games.myGames').toUpperCase()),
              _buildMyGamesList(context, gameListViewModel)
            ]),
      ),
    );
  }

  Widget _buildMyGamesList(BuildContext context, MyGamesListViewModel gameListViewModel) {
    if (_IsSearching) {
      gameListViewModel = gameListViewModel.filter(_searchText);
    }

    return Column(
        children: List<GameInfoListTile>.generate(
            gameListViewModel.gameList.length,
                (i) => GameInfoListTile(game: gameListViewModel.gameList[i], openGame: (){
                  gameListViewModel.tapGame(gameListViewModel.gameList[i].gameId)();
                })
        ));


    // return ListView.separated(
    //   separatorBuilder: (context, index) => Divider(
    //     height: 2,
    //     color: Colors.black,
    //   ),
    //   itemBuilder: (BuildContext context, int index) =>
    //       GameInfoListTile(game: gameListViewModel.gameList[index], openGame: gameListViewModel.tapGame),
    //       // GameListTileOld(game: gameListViewModel.gameList[index], onTap: gameListViewModel.tapGame),
    //   itemCount: gameListViewModel.gameList.length,
    // );
  }
}
