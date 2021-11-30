import 'dart:collection';

import 'package:redux/redux.dart';

import 'package:youplay/models/response.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/current_run.action.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';
import 'package:youplay/store/state/run_state.dart';

import 'current_run.actions.reducer.dart';

final Reducer<RunState> currentRunReducer = combineReducers<RunState>([
  new TypedReducer<RunState, SetCurrentRunAction>(_setCurrentRunIdReducer),
  new TypedReducer<RunState, LocalAction>(addLocalAction),
  new TypedReducer<RunState, PictureResponseAction>(_addPictureResponse),
  new TypedReducer<RunState, AudioResponseAction>(_addAudioResponse),
  new TypedReducer<RunState, VideoResponseAction>(_addVideoResponse),
  new TypedReducer<RunState, TextResponseAction>(_addTextResponse),
  new TypedReducer<RunState, MultiplechoiceAction>(_addMultipleChoiceResponse),
  new TypedReducer<RunState, SyncResponsesServerToMobileComplete>(_addResponsesFromServer),
  new TypedReducer<RunState, SyncFileResponseComplete>(_addOneResponseFromServer),
  new TypedReducer<RunState, SyncActionComplete>(addOneActionFromServer),
  new TypedReducer<RunState, SyncARLearnActionsListServerToMobileComplete>(addActionsFromServer),
  new TypedReducer<RunState, EraseAnonAccountAndStartAgain>(resetActions),
  new TypedReducer<RunState, DeleteResponseFromLocalStore>(deleteResponseFromRun),
  new TypedReducer<RunState, DeleteResponseFromServer>(_deleteResponseFromServer),
]);
//SetCurrentRunAction

RunState _setCurrentRunIdReducer(RunState state, SetCurrentRunAction action) {
  if (state.run != null && state.run!.runId == action.run.runId) {
    return state;
  }
  return  RunState.init().copyWith(run: action.run, isSyncingActions: true);
}

RunState _addPictureResponse(RunState state, PictureResponseAction action) {
//  state.outgoingPictureResponses..add(action.pictureResponse);
  state.outgoingResponses..add(action.pictureResponse);
  return state.copyWith();
}

RunState _addAudioResponse(RunState state, AudioResponseAction action) {
  state.outgoingResponses..add(action.audioResponse);
  return state.copyWith();
}

RunState _addVideoResponse(RunState state, VideoResponseAction action) {
  state.outgoingResponses..add(action.videoResponse);
  return state.copyWith();
}

RunState _addTextResponse(RunState state, TextResponseAction action) {
  state.outgoingResponses..add(action.textResponse);
  return state.copyWith();
}

RunState _addMultipleChoiceResponse(RunState state, MultiplechoiceAction action) {
  state.outgoingResponses..add(action.mcResponse);
  return state.copyWith();
}

RunState _addResponsesFromServer(RunState state, SyncResponsesServerToMobileComplete action) {
  action.result.responses.forEach((response) {
    if (response.responseId != null) {
      state.responsesFromServer[response.responseId!] = response;
    }
  });
  return state.copyWith(respFromServer: HashMap<int, Response>.from(state.responsesFromServer));
}

RunState _addOneResponseFromServer(RunState state, SyncFileResponseComplete action) {
  if (action.responseFromServer.responseId != null) {
    state.responsesFromServer[action.responseFromServer.responseId!] = action.responseFromServer;
    // state.responsesFromServer = HashMap<int, Response>.from(state.responsesFromServer);
    return state.copyWith(respFromServer: state.responsesFromServer);
  }
  return state;

}

RunState deleteResponseFromRun(RunState state, DeleteResponseFromLocalStore action) {
  state.responsesFromServer.remove(action.responseId);
  state.deleteList = state.deleteList.where((element) => element != action.responseId).toList(growable: false);
  return state.copyWith();
}

RunState _deleteResponseFromServer(RunState state, DeleteResponseFromServer action) {
  return state.copyWith(toDeleteItem: action.responseId);
}
