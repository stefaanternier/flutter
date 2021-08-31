import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/dependency.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youplay/ui/components/messages_pages/audio-player.widget.container.dart';

import '../game.dart';

class AudioObjectGeneralItem extends GeneralItem {
  AudioObjectGeneralItem({
    required int gameId,
    required int itemId,
    required bool deleted,
    required int lastModificationDate,
    required int sortKey,
    required String title,
    required String richText,
    required String description,
     double? lat,
     double? lng,
    required bool showOnMap,
    required bool showInList,
    Dependency? dependsOn,
    Dependency? disappearOn,
    Map<String, String>? fileReferences,
    Color? primaryColor,
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
    AudioObjectGeneralItem returnItem = AudioObjectGeneralItem(
        gameId: int.parse(json['gameId']),
        itemId: int.parse(json['id']),
        deleted: json['deleted'],
        lastModificationDate: int.parse(json['lastModificationDate']),
        sortKey: json['sortKey']??0,
        title: json['name'],
        richText: json['richText']??'',
        description: (json['description'] ?? "").trim(),
        showOnMap: json['showOnMap']??false,
        showInList: json['showInList'] == null? true: json['showInList'],
        fileReferences: json['fileReferences'] != null
            ? new Map.fromIterable(json["fileReferences"],
            key: (item) => item['key'],
            value: (item) => item['fileReference']??'')
            : {},
        primaryColor: json['primaryColor'] != null
            ? colorFromHex(json['primaryColor'])
            : null,
        lat: json['lat'] ,
        lng: json['lng'] ,
        dependsOn: json['dependsOn'] != null
            ? Dependency.fromJson(json['dependsOn'])
            : null,
        disappearOn: json['disappearOn'] != null
            ? Dependency.fromJson(json['disappearOn'])
            : null);

    if (returnItem.fileReferences != null) {
      if (returnItem.fileReferences!['video'] == null) {
        returnItem.fileReferences!['video'] =
        '/game/${returnItem.gameId}/generalItems/${returnItem.itemId}/video.mp4';
      }
    }

    return returnItem;
  }

  String getIcon() {
    return 'fa.headphones';
  }
  bool get isSupported {
    return true;
  }

  Widget buildPage() {
    return AudioPlayerWidgetContainer();
  }
}

Color colorFromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
