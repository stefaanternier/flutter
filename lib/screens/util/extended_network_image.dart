

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';

BoxDecoration getBoxDecoration(String path) {
  if (path != null){
    path = path.replaceAll(' ', '%20').replaceFirst('//', '/');
  }
  if (path == 'null'){
    print('path is null');
  }
  // print('path is $path');
  return new BoxDecoration(
      image: new DecorationImage(
          fit: BoxFit.cover,
          image: path == null? new AssetImage('graphics/loading.gif'): ExtendedNetworkImageProvider(
              '${AppConfig().storageUrl}${path}')

      ));
}





//todo
//game over box decoration testen

//old code
// decoration: new BoxDecoration(
//
//     image: new DecorationImage(
//         fit: BoxFit.cover,
//         image: buildImage(context, iconPath))),
// CachedNetworkImageProvider buildImage(BuildContext context, path) {
//   return new CachedNetworkImageProvider(
//     "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com$path",
//   );
// }
//or
// new BoxDecoration(
//     image:
// new DecorationImage(
//     fit: BoxFit.cover,
//     image: ExtendedNetworkImageProvider(
//         '${AppConfig().storageUrl}/featuredGames/backgrounds/${featuredGamesModel.games[i].gameId}.png')
//
// )
// ),