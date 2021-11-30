import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/nav/user_account_header.dart';


class UserAccountHeaderContainer extends StatelessWidget {
  const UserAccountHeaderContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return UserAccountHeader(
          email: vm.email,
          name: vm.name,
          accountPicture: vm.accountPicture
        );
      },
    );
  }
}

class _ViewModel {
  String name;
  String email;
  String accountPicture;

  _ViewModel({
    required this.name,
    required this.email,
    required this.accountPicture});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        name: store.state.authentication.name, //authenticationState.name == null ? "" : authenticationState.name,
        email: store.state.authentication.email,
        accountPicture: store.state.authentication.pictureUrl);
  }
}
