import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:youplay/store/selectors/selector.generalitems.dart';
import 'package:youplay/store/state/app_state.dart';

import 'picture-question.widget.dart';

class PictureQuestionWidgetContainer extends StatelessWidget {
  final PictureQuestion item;
  const PictureQuestionWidgetContainer({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) =>_ViewModel.fromStore(store, item),
      distinct: true,
      builder: (context, vm) {
        return PictureQuestionWidget(
            item: vm.item
        );
      },
    );
  }
}

class _ViewModel {
  PictureQuestion item;

  _ViewModel({required this.item});

  static _ViewModel fromStore(Store<AppState> store, PictureQuestion item) {
    return _ViewModel(
      item: item,
    );
  }

  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _ViewModel && (other.item.itemId == item.itemId);
  }

  @override
  int get hashCode => item.itemId;
}
