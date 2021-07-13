import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';

BoxDecoration getBoxDecoration(String? path) {
  if (path != null) {
    path = path.replaceAll(' ', '%20').replaceFirst('//', '/');
    return new BoxDecoration(
        image: new DecorationImage(
            fit: BoxFit.cover,
            image: ExtendedNetworkImageProvider(
                '${AppConfig().storageUrl}${path}')));
  }

  print('path is null');
  return new BoxDecoration(
      image: new DecorationImage(
          fit: BoxFit.cover, image: new AssetImage('graphics/loading.gif')));
}
