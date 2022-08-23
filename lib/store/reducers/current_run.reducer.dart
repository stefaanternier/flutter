import 'dart:collection';

import 'package:redux/redux.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/current_run.action.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';
import 'package:youplay/store/state/run_state.dart';

import 'current_run.actions.reducer.dart';

final Reducer<CurrentRunState> currentRunReducer = combineReducers<CurrentRunState>([
  new TypedReducer<CurrentRunState, SetCurrentRunAction>(_setCurrentRunIdReducer),
  new TypedReducer<CurrentRunState, LocalAction>(addLocalAction),
  new TypedReducer<CurrentRunState, PictureResponseAction>(_addPictureResponse),
  new TypedReducer<CurrentRunState, AudioResponseAction>(_addAudioResponse),
  new TypedReducer<CurrentRunState, VideoResponseAction>(_addVideoResponse),
  new TypedReducer<CurrentRunState, TextResponseAction>(_addTextResponse),
  new TypedReducer<CurrentRunState, MultiplechoiceAction>(_addMultipleChoiceResponse),
  new TypedReducer<CurrentRunState, SyncResponsesServerToMobileComplete>(_addResponsesFromServer),
  new TypedReducer<CurrentRunState, SyncFileResponseComplete>(_addOneResponseFromServer),
  new TypedReducer<CurrentRunState, SyncActionComplete>(addOneActionFromServer),
  new TypedReducer<CurrentRunState, SyncARLearnActionsListServerToMobileComplete>(addActionsFromServer),
  new TypedReducer<CurrentRunState, EraseAnonAccountAndStartAgain>(resetActions),
  new TypedReducer<CurrentRunState, DeleteResponseFromLocalStore>(deleteResponseFromRun),
  new TypedReducer<CurrentRunState, DeleteResponseFromServer>(_deleteResponseFromServer),
]);
//SetCurrentRunAction

CurrentRunState _setCurrentRunIdReducer(CurrentRunState state, SetCurrentRunAction action) {
  if (state.run != null && state.run!.runId == action.run.runId) {
    return state;
  }
  return  CurrentRunState.init().copyWith(run: action.run, isSyncingActions: true);
}

CurrentRunState _addPictureResponse(CurrentRunState state, PictureResponseAction action) {
//  state.outgoingPictureResponses..add(action.pictureResponse);
  state.outgoingResponses..add(action.pictureResponse);
  return state.copyWith();
}

CurrentRunState _addAudioResponse(CurrentRunState state, AudioResponseAction action) {
  state.outgoingResponses..add(action.audioResponse);
  return state.copyWith();
}

CurrentRunState _addVideoResponse(CurrentRunState state, VideoResponseAction action) {
  state.outgoingResponses..add(action.videoResponse);
  return state.copyWith();
}

CurrentRunState _addTextResponse(CurrentRunState state, TextResponseAction action) {
  state.outgoingResponses..add(action.textResponse);
  return state.copyWith();
}

CurrentRunState _addMultipleChoiceResponse(CurrentRunState state, MultiplechoiceAction action) {
  state.outgoingResponses..add(action.mcResponse);
  return state.copyWith();
}

CurrentRunState _addResponsesFromServer(CurrentRunState state, SyncResponsesServerToMobileComplete action) {
  action.result.responses.forEach((response) {
    if (response.responseId != null) {
      state.responsesFromServer[response.responseId!] = response;
    }
  });
  return state.copyWith(respFromServer: HashMap<int, Response>.from(state.responsesFromServer));
}

CurrentRunState _addOneResponseFromServer(CurrentRunState state, SyncFileResponseComplete action) {
  if (action.responseFromServer.responseId != null) {
    state.responsesFromServer[action.responseFromServer.responseId!] = action.responseFromServer;
    // state.responsesFromServer = HashMap<int, Response>.from(state.responsesFromServer);
    return state.copyWith(respFromServer: state.responsesFromServer);
  }
  return state;

}

CurrentRunState deleteResponseFromRun(CurrentRunState state, DeleteResponseFromLocalStore action) {
  state.responsesFromServer.remove(action.responseId);
  state.deleteList = state.deleteList.where((element) => element != action.responseId).toList(growable: false);
  return state.copyWith();
}

CurrentRunState _deleteResponseFromServer(CurrentRunState state, DeleteResponseFromServer action) {
  return state.copyWith(toDeleteItem: action.responseId);
}
