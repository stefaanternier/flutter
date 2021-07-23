import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/screens/general_item/dataCollection/picture_preview_file.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';
import 'package:youplay/store/state/app_state.dart';

import '../general_item.dart';

class PictureFilePreviewContainer extends StatelessWidget {
  String imagePath;
  Run run;
  GeneralItem generalItem;
  Function finished;
  GeneralItemViewModel giViewModel;

  PictureFilePreviewContainer(
      {required this.imagePath, required this.giViewModel,required  this.run, required this.generalItem, required this.finished});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) =>
          _ViewModel.fromStore(store, run, generalItem, imagePath, finished),
      builder: (context, vm) {
        return PictureFilePreview(
          imagePath: imagePath,
          giViewModel: giViewModel,
          submitPicture: vm.submitPicture,
        );
      },
    );
  }
}

class _ViewModel {
  final Function submitPicture;

  _ViewModel({required this.submitPicture});

  static _ViewModel fromStore(Store<AppState> store, Run run, GeneralItem item,
      String path, Function finished) {
    return _ViewModel(
      submitPicture: (String text) {
        if (run.runId!=null) {
          store.dispatch(LocalAction(
            action: "answer_given",
            generalItemId: item.itemId,
            runId: run.runId!,
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
