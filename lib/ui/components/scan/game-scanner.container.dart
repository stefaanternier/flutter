import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../../store/actions/actions.collection.dart';
import 'game-scanner.dart';

class GameQRScannerContainer extends StatelessWidget {
  const GameQRScannerContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        return GameQRScanner(
          scanQr: vm.scanQr,
        );
      },
    );
  }
}

class _ViewModel {
  Function(String) scanQr;

  _ViewModel({required this.scanQr});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      scanQr: (String code) {
        print('scanned qr ${code}');
        if (code != null && canProcessQr(code)) {
          store.dispatch(new ParseLinkAction(link: code));
        }
      },
    );
  }

  static bool canProcessQr(String rawValue) {
    if (rawValue.contains('gameId=')) return true;
    if (rawValue.startsWith('account:')) return true;
    if (rawValue.startsWith('http://')) return true;
    if (rawValue.startsWith('https://')) return true;
    return false;
  }
}
