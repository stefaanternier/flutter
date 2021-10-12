import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item/video_question.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';

import 'video-question.list-entries.dart';


class VideoQuestionListEntriesContainer extends StatelessWidget {
  final Function(Response) tapRecording;

  const VideoQuestionListEntriesContainer({
    required this.tapRecording,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return VideoQuestionListEntries(
          responses: vm.videoResponses,
          deleteResponse: vm.deleteVideo,
          tapRecording: tapRecording,
        );
      },
    );
  }
}

class _ViewModel {
  List<Response> videoResponses;
  Store<AppState> store;

  _ViewModel({required this.videoResponses, required this.store});

  static _ViewModel fromStore(Store<AppState> store) {
    VideoQuestion item = currentGeneralItem(store.state) as VideoQuestion;
    return new _ViewModel(videoResponses: [
      ...currentRunResponsesSelector(store.state)
          .where((element) => element.item?.itemId == item.itemId)
          .toList(growable: false),
      ...currentItemResponsesFromServerAsList(store.state)
    ], store: store);
  }

  deleteVideo(Response response) {
    if (response.responseId != null) {
      this.videoResponses =
          this.videoResponses
              .where((element) => element.responseId != response.responseId).toList(growable: false);
      store.dispatch(DeleteResponseFromServer(responseId: response.responseId!));
    }
  }

  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _ViewModel && (other.videoResponses.length == videoResponses.length);
  }

  @override
  int get hashCode => videoResponses.hashCode;
}
