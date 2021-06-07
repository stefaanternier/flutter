
import 'package:flutter/rendering.dart';

import '../general_item.dart';
import 'dependency.dart';
import 'narrator_item.dart';
import 'open_question.dart';

class TextQuestion extends GeneralItem {
  TextQuestion({int gameId,
    int itemId,
    bool deleted,
    int lastModificationDate,
    int sortKey,
    String title,
    String richText,
    String description,
    Dependency dependsOn,
    Dependency disappearOn,
    Map<String, String> fileReferences,
    Color primaryColor,
    double lat,
    double lng,
    bool showOnMap,
    bool showInList,
    OpenQuestion openQuestion})
      : super(
      type: ItemType.textquestion,
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

  factory TextQuestion.fromJson(Map json) {
    return TextQuestion(
        gameId: int.parse(json['gameId']),
        itemId: int.parse(json['id']),
        deleted: json['deleted'],
        lastModificationDate: int.parse(json['lastModificationDate']),
        sortKey: json['sortKey'],
        title: json['name'],
        richText: json['richText'],
        description: (json['description'] ?? "").trim(),
        lat: json['lat'] != null ? json['lat'] : null,
        lng: json['lng'] != null ? json['lng'] : null,
        showOnMap: json['showOnMap'],
        showInList: json['showInList'] == null? true: json['showInList'],
        openQuestion: json['openQuestion'] != null
            ? OpenQuestion.fromJson(json["openQuestion"])
            : null,
        fileReferences: json['fileReferences'] != null
            ? new Map.fromIterable(json["fileReferences"],
            key: (item) => item['key'],
            value: (item) => item['fileReference'])
            : null,
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
    return 'fa.edit';
  }
}
