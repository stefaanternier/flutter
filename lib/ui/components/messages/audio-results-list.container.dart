import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

import 'audio-results-list.dart';

class AudioResultsListContainer extends StatelessWidget {
  const AudioResultsListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return AudioResultsList(
          audioResponses: vm.audioResponses,
          dismissAudio: vm.deleteAudio,
        );
      },
    );
  }
}

class _ViewModel {
  List<Response> audioResponses;
  Store<AppState> store;

  _ViewModel({required this.audioResponses, required this.store});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(audioResponses: [
      ...currentRunResponsesSelector(store.state),
      ...currentItemResponsesFromServerAsList(store.state)
    ], store: store);
  }

  deleteAudio(Response response) {
    if (response.responseId != null) {
      this.audioResponses = this
          .audioResponses
          .where((element) => element.responseId != response.responseId)
          .toList(growable: false);
      store
          .dispatch(DeleteResponseFromServer(responseId: response.responseId!));
    }
  }
}
