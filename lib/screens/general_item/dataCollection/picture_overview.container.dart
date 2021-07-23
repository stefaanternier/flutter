import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/screens/general_item/dataCollection/picture_overview.dart';
import 'package:youplay/screens/general_item/util/messages/components/game_themes.viewmodel.dart';
import 'package:youplay/store/state/app_state.dart';

import '../general_item.dart';

class PictureOverviewContainer extends StatelessWidget {


  GeneralItemViewModel giViewModel;

  Function takePicture;
  PictureOverviewContainer({required this.giViewModel, required this.takePicture});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        if (giViewModel.item == null){
          return Container(child: Text('item loading...'));  //todo make message beautiful
        }
        return PictureOverview(item: giViewModel.item!, giViewModel: giViewModel,
            themeModel: vm.themeModel, takePicture: takePicture,);
      },
    );
  }
}

class _ViewModel {
  GameThemesViewModel themeModel;
  _ViewModel({required this.themeModel});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      themeModel: GameThemesViewModel.fromStore(store)
    );
  }
}
