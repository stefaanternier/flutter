import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/screens/general_item/dataCollection/picture_preview_file.dart';
import 'package:youplay/store/actions/current_run.action.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

class PictureFilePreviewContainer extends StatelessWidget {
 final String imagePath;
 final GeneralItem generalItem;
 final Function finished;
  // GeneralItemViewModel giViewModel;

  PictureFilePreviewContainer(
      {required this.imagePath,
        // required this.giViewModel,
        required this.generalItem, required this.finished});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) =>
          _ViewModel.fromStore(store, generalItem, imagePath, finished),
      builder: (context, vm) {
        return PictureFilePreview(
          item: generalItem as PictureQuestion,
          imagePath: imagePath,
          // giViewModel: giViewModel,
          submitPicture: vm.submitPicture,
        );
      },
    );
  }
}

class _ViewModel {
  final Function submitPicture;

  _ViewModel({required this.submitPicture});

  static _ViewModel fromStore(Store<AppState> store, GeneralItem item,
      String path, Function finished) {
    Run? run = currentRunSelector(store.state.currentRunState);
    return _ViewModel(
      submitPicture: (String text) {
        if (run?.runId!=null) {
          store.dispatch(LocalAction(
            action: "answer_given",
            generalItemId: item.itemId,
            runId: run!.runId!,
          ));
          store.dispatch(PictureResponseAction(
              pictureResponse:
              PictureResponse(item: item, path: path, run: run, text: text)));
          store.dispatch(SyncFileResponse(runId: run.runId!));
          finished();
        }


      },
    );
  }
}
