// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/screens/util/extended_network_image.dart';
import 'package:youplay/store/state/app_state.dart';

import 'game_themes.viewmodel.dart';

//enum ThemedContainerBackgrounds { defaultBg, correctBg, wrongBg }

class ThemedContainer extends StatelessWidget {
  final Widget child;
  final String imageId;
  final GeneralItem item;

  ThemedContainer({this.child, this.imageId, this.item});

  // CachedNetworkImageProvider backgroundImage(BuildContext context, GameThemesViewModel themeModel) {
  //   if (item.fileReferences != null && item.fileReferences[imageId] != null) {
  //     return new CachedNetworkImageProvider(
  //         "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com${item.fileReferences[imageId].replaceFirst('//', '/')}",
  //         errorListener: () {});
  //   }
  //   return new CachedNetworkImageProvider(
  //       "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com${getPath(themeModel)}",
  //       errorListener: () {
  //     print('error retrieving');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, GameThemesViewModel>(
        converter: (store) => GameThemesViewModel.fromStore(store),
        builder: (context, GameThemesViewModel themeModel) {
          return Container(
            decoration: getBoxDecoration(getPath(themeModel)),
            // decoration: new BoxDecoration(
            //     image: new DecorationImage(fit: BoxFit.cover, image: backgroundImage(context, themeModel))),
            child: child,
          );
        });
  }

  String getPath(GameThemesViewModel themeModel) {
    if (item.fileReferences != null && item.fileReferences[imageId] != null) {
          return item.fileReferences[imageId];
    }
    if (this.imageId == 'wrong') {
      return  themeModel.gameTheme.wrongPath;
    }
    if (this.imageId == 'correct') {
      return  themeModel.gameTheme.correctPath;
    }
    return  themeModel.gameTheme.backgroundPath;
  }
}
