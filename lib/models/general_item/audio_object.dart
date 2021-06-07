import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/dependency.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../game.dart';

class AudioObjectGeneralItem extends GeneralItem {
  AudioObjectGeneralItem({
    int gameId,
    int itemId,
    bool deleted,
    int lastModificationDate,
    int sortKey,
    String title,
    String richText,
    String description,
    double lat,
    double lng,
    bool showOnMap,
    bool showInList,
    Dependency dependsOn,
    Dependency disappearOn,
    Map<String, String> fileReferences,
    Color primaryColor,
  }) : super(
      type: ItemType.audio,
      gameId: gameId,
      itemId: itemId,
      deleted: deleted,
      lastModificationDate: lastModificationDate,
      sortKey: sortKey,
      title: title,
      richText: richText,
      description: description,
      fileReferences: fileReferences,
      primaryColor: primaryColor,
      lat: lat,
      lng: lng,
      showOnMap: showOnMap,
      showInList:showInList,
      disappearOn: disappearOn,
      dependsOn: dependsOn);

  factory AudioObjectGeneralItem.fromJson(Map json) {
    var returnItem = AudioObjectGeneralItem(
        gameId: int.parse(json['gameId']),
        itemId: int.parse(json['id']),
        deleted: json['deleted'],
        lastModificationDate: int.parse(json['lastModificationDate']),
        sortKey: json['sortKey'],
        title: json['name'],
        richText: json['richText'],
        description: (json['description'] ?? "").trim(),
        showOnMap: json['showOnMap'],
        showInList: json['showInList'] == null? true: json['showInList'],
        fileReferences: json['fileReferences'] != null
            ? new Map.fromIterable(json["fileReferences"],
            key: (item) => item['key'],
            value: (item) => item['fileReference'])
            : {},
        primaryColor: json['primaryColor'] != null
            ? colorFromHex(json['primaryColor'])
            : null,
        lat: json['lat'] != null ? json['lat'] : null,
        lng: json['lng'] != null ? json['lng'] : null,
        dependsOn: json['dependsOn'] != null
            ? Dependency.fromJson(json['dependsOn'])
            : null,
        disappearOn: json['disappearOn'] != null
            ? Dependency.fromJson(json['disappearOn'])
            : null);
    if (returnItem.fileReferences['video'] == null) {
      returnItem.fileReferences['video'] =
      '/game/${returnItem.gameId}/generalItems/${returnItem.itemId}/video.mp4';
    }
    return returnItem;
  }

  String getIcon() {
    return 'fa.headphones';
  }
  bool get isSupported {
    return true;
  }
}

Color colorFromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
