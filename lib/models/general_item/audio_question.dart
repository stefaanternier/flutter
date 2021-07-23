
import 'package:flutter/rendering.dart';
import 'package:universal_platform/universal_platform.dart';

import '../general_item.dart';
import 'dependency.dart';
import 'narrator_item.dart';
import 'open_question.dart';

class AudioQuestion extends GeneralItem {
  AudioQuestion({
    required int gameId,
    required int itemId,
    required bool deleted,
    required int lastModificationDate,
    required int sortKey,
    required String title,
    required String richText,
    required String description,
    Dependency? dependsOn,
    Dependency? disappearOn,
    Map<String, String>? fileReferences,
    Color? primaryColor,
     double? lat,
     double? lng,
    required bool showOnMap,
    required bool showInList,
    OpenQuestion? openQuestion})
      : super(
      type: ItemType.audioquestion,
      gameId: gameId,
      itemId: itemId,
      deleted: deleted,
      lastModificationDate: lastModificationDate,
      sortKey: sortKey,
      title: title,
      richText: richText,
      description: description,
      dependsOn: dependsOn,
      disappearOn: disappearOn,
      fileReferences: fileReferences,
      primaryColor: primaryColor,
      lat: lat,
      lng: lng,
      showOnMap: showOnMap,
      showInList:showInList,
      openQuestion: openQuestion);

  factory AudioQuestion.fromJson(Map json) {
//    print("json map ${json}");
    return AudioQuestion(
        gameId: int.parse(json['gameId']),
        itemId: int.parse(json['id']),
        deleted: json['deleted'],
        lastModificationDate: int.parse(json['lastModificationDate']),
        sortKey: json['sortKey']??0,
        title: json['name'],
        richText: json['richText']??'',
        description: (json['description'] ?? "").trim(),
        lat: json['lat'] ,
        lng: json['lng'] ,
        showOnMap: json['showOnMap']??false,
        showInList: json['showInList'] == null? true: json['showInList'],
        openQuestion: json['openQuestion'] != null
            ? OpenQuestion.fromJson(json["openQuestion"])
            : null,
        fileReferences: json['fileReferences'] != null
            ? new Map.fromIterable(json["fileReferences"],
            key: (item) => item['key'],
            value: (item) => item['fileReference']??'')
            : {},
        primaryColor: json['primaryColor'] != null
            ? colorFromHex(json['primaryColor'])
            : null,
        dependsOn: json['dependsOn'] != null
            ? Dependency.fromJson(json['dependsOn'])
            : null,
        disappearOn: json['disappearOn'] != null
            ? Dependency.fromJson(json['disappearOn'])
            : null);
  }

  String getIcon() {
    return 'fa.microphoneAlt';
  }
  bool get isSupported {
    return !UniversalPlatform.isWeb;
  }

}
