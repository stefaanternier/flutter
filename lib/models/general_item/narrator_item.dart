import 'dart:ui';

import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/dependency.dart';
import 'package:youplay/models/general_item/open_question.dart';

import '../game.dart';


class NarratorItem extends GeneralItem {
  String heading;

  NarratorItem({
    this.heading,
    int gameId,
    int itemId,
    bool deleted,
    int lastModificationDate,
    int sortKey,
    String title,
    String richText,
    String icon,
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
      type: ItemType.narrator,
      gameId: gameId,
      itemId: itemId,
      deleted: deleted,
      lastModificationDate: lastModificationDate,
      sortKey: sortKey,
      title: title,
      richText: richText,
      icon: icon,
      description: description,
      dependsOn: dependsOn,
      disappearOn: disappearOn,
      fileReferences: fileReferences,
      primaryColor: primaryColor,
      lat: lat,
      lng: lng,
      showOnMap: showOnMap,
      showInList: showInList,
      openQuestion: openQuestion);

  factory NarratorItem.fromJson(Map json) {
//    print("json map ${json}");
    return NarratorItem(
        gameId: int.parse(json['gameId']),
        itemId: int.parse(json['id']),
        deleted: json['deleted'],
        lastModificationDate: int.parse(json['lastModificationDate']),
        sortKey: json['sortKey'],
        title: json['name'],
        heading: json['heading'],
        richText: json['richText'],
        icon: json['icon'],
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
}


class PictureQuestion extends GeneralItem {
  PictureQuestion({int gameId,
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
      type: ItemType.picturequestion,
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

  factory PictureQuestion.fromJson(Map json) {
//    print("json map ${json}");
    return PictureQuestion(
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
    return 'fa.camera';
  }
}
Color colorFromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
