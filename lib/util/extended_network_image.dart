import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';

BoxDecoration getBoxDecoration(String? path) {
  if (path != null) {
    if (path.startsWith('/')){
      return new BoxDecoration(
          image: new DecorationImage(
              fit: BoxFit.cover,
              image: ExtendedNetworkImageProvider(
                  '${AppConfig().storageUrl}${path}',
                  cache: true,
                  printError: true,
                  retries: 5,
                  timeRetry: Duration(seconds: 10))));
    }else {
      return new BoxDecoration(
          image: new DecorationImage(
              fit: BoxFit.cover,
              image:
              ExtendedNetworkImageProvider(
                  '${AppConfig().storageUrl}/${path}',
                  cache: true,

                  retries: 5,
                  timeRetry: Duration(seconds: 10)
              )

          ));
    }

  }
  return new BoxDecoration(
      image: new DecorationImage(
          fit: BoxFit.cover, image: new AssetImage('graphics/loading.gif')));
}

