import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/selectors/selectors.organisation.dart';
import 'package:youplay/store/state/app_state.dart';

import 'app_bar_title.dart';


class OrganisationAppBarTitleContainer extends StatelessWidget {

  const OrganisationAppBarTitleContainer({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return OrganisationAppBarTitle(
          organisationName: vm.title,
        );
      },
    );
  }
}

class _ViewModel {
  final String title;

  _ViewModel({required this.title,});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        title: currentOrganisation(store.state)?.name ?? '',

    );
  }


  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _ViewModel && (other.title == title);
  }
  @override
  int get hashCode => title.hashCode ;
}
