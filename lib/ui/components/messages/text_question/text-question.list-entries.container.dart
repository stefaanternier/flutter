import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item/text_question.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/selector.generalitems.dart';
import 'package:youplay/store/state/app_state.dart';

import 'text-question.list-entries.dart';

class TextQuestionListEntriesContainer extends StatelessWidget {
  final TextQuestion item;
  const TextQuestionListEntriesContainer({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) =>_ViewModel.fromStore(store, item),
      distinct: true,
      builder: (context, vm) {
        return TextQuestionListEntries(
          responses: vm.textResponses,
          deleteResponse: vm.deleteText,
        );
      },
    );
  }
}

class _ViewModel {
  List<Response> textResponses;
  Store<AppState> store;

  _ViewModel({required this.textResponses, required this.store});

  static _ViewModel fromStore(Store<AppState> store, TextQuestion item) {

    return new _ViewModel(textResponses: [
      ...currentRunResponsesSelector(store.state)
          .where((element) => element.item?.itemId == item.itemId)
          .toList(growable: false),
      ...currentItemResponsesFromServerAsList(store.state)
    ], store: store);
  }

  deleteText(Response response) {
    if (response.responseId != null) {
      this.textResponses =
          this.textResponses.where((element) => element.responseId != response.responseId).toList(growable: false);
      store.dispatch(DeleteResponseFromServer(responseId: response.responseId!));
    }
  }

  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _ViewModel && (other.textResponses.length == textResponses.length);
  }

  @override
  int get hashCode => textResponses.hashCode;
}
