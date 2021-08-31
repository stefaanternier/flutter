import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/screens/util/extended_network_image.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../../general_item.dart';
import 'components/game_themes.viewmodel.dart';
import 'components/themed_app_bar.dart';

class GeneralItemWidget extends StatelessWidget {
  GeneralItem item;
  GeneralItemViewModel giViewModel;
  FloatingActionButton? floatingActionButton;
  Widget body;
  bool renderBackground;
  bool padding;
  bool elevation;

  GeneralItemWidget(
      {required this.item,
      required this.giViewModel,
      required this.body,
      // this.floatingActionButton,
      this.renderBackground = true,
      this.padding = true,
      this.elevation = true});

  String? getBackground() {
    if (item.fileReferences != null &&
        item.fileReferences!['background'] != null &&
        item.fileReferences!['background'] != '') {
      return item.fileReferences!['background'];
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ThemedAppBar(title: item.title, elevation: this.elevation),
        floatingActionButton: floatingActionButton,
        body: WebWrapper(
            child: new StoreConnector<AppState, GameThemesViewModel>(
                converter: (store) => GameThemesViewModel.fromStore(store),
                builder: (context, GameThemesViewModel themeModel) {
                  return Container(
                    padding: padding
                        ? (renderBackground
                            ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
                            : null)
                        : null,
                    decoration:
                        renderBackground //&& item.fileReferences != null
                            ? getBoxDecoration(getBackground() ??
                                themeModel.gameTheme?.backgroundPath)
                            : null,
                    child: body,
                  );
                })));
  }
}
