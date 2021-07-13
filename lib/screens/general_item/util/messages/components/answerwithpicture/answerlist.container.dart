import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

import 'answerlist.dart';

class AnswerListContainer extends StatelessWidget {
  Function tapResponse;

  AnswerListContainer({required this.tapResponse});

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromStore(store),
        builder: (context, vm) {
          return vm.fromServer == null
              ? Container()
              : AnswerList(fromServer: vm.fromServer, tapResponse: tapResponse, deleteReponse: vm.deleteResponse,);
        });
  }
}

class _ViewModel {
  List<PictureResponse> pictureResponses;
  List<Response> fromServer;
  Function deleteResponse;

  _ViewModel({required this.pictureResponses, required this.fromServer,required  this.deleteResponse});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        pictureResponses: currentRunPictureResponsesSelector(store.state),
        fromServer: currentItemResponsesFromServerAsList(store.state),
        deleteResponse: (int responseId) {
          print ('todo delete ${responseId}');
          store.dispatch(DeleteResponseFromServer(responseId: responseId));
          store.dispatch(DeleteResponseFromLocalStore(responseId: responseId));

        });
  }
}
