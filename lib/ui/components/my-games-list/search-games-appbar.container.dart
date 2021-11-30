import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/actions/all_games.actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/my-games-list/search-games-appbar.dart';

class SearchGamesAppbarContainer extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  bool elevation = true;
  SearchGamesAppbarContainer({Key? key, this.elevation = true}) : preferredSize = Size.fromHeight(50.0), super(key: key);


  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        return SearchGamesAppbar(
          submitQuery: vm.submitQuery,
          // isSearching: true
        );
      },
    );
  }
}

class _ViewModel {
  Function(String?) submitQuery;

  _ViewModel({ required this.submitQuery});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      submitQuery: (String? query)=> store.dispatch(SetGameQuery(query: query)),
    );
  }

}