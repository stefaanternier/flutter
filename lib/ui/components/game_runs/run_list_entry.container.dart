import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/selectors/selector.gametheme.dart';
import 'package:youplay/store/selectors/selector.generalitems.dart';
import 'package:youplay/store/state/app_state.dart';

import 'run_list_entry.dart';

class RunListEntryContainer extends StatelessWidget {
  final String title;
  final int lastModificationDate;
  final GestureTapCallback onTap;
  final Function(Run) deleteRun;
  final Run run;

  RunListEntryContainer({
    required this.onTap,
    required this.run,
    required this.deleteRun,
    required this.title,required  this.lastModificationDate,
    Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        return RunListEntry(
            onTap: onTap,
            run: run,
            deleteRun: deleteRun,
            title: title,
            lastModificationDate: lastModificationDate,
            color: vm.getPrimaryColor()
        );

      },
    );
  }
}

class _ViewModel {
  Color? itemPrimaryColor;
  Color? themePrimaryColor;

  _ViewModel({ this.itemPrimaryColor, this.themePrimaryColor});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      itemPrimaryColor: currentGeneralItemNew(store.state) == null ? null : currentGeneralItemNew(store.state)?.primaryColor,
      themePrimaryColor: currentGameThemeColor(store.state),
    );
  }

  Color getPrimaryColor() {
    return itemPrimaryColor?? themePrimaryColor ?? AppConfig().themeData!.primaryColor;
  }
}