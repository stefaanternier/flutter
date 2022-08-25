import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/ui/components/collection/collection_search.dart';

class CollectionSearchFieldContainer extends StatelessWidget {
  const CollectionSearchFieldContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromStore(store),
        builder: (context, vm) {
          return CollectionSearchField(submitQuery: vm.submitQuery);
        });
  }
}

class _ViewModel {
  Function(String) submitQuery;

  _ViewModel({required this.submitQuery});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      submitQuery: (String query) {
        //todo reïmplement
        // store.dispatch(new SearchLibrary(query: query));
      },
    );
  }
}
