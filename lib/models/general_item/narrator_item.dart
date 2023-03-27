import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/dependency.dart';
import 'package:youplay/models/general_item/open_question.dart';
import 'package:youplay/ui/components/messages_pages/narrator.widget.container.dart';
import 'package:youplay/ui/components/messages_pages/narrator.widget.dart';
import 'package:youplay/ui/components/messages_pages/picture-question.widget.container.dart';
import 'package:youplay/ui/components/messages_pages/picture-question.widget.dart';

class NarratorItem extends GeneralItem {
  String? heading;

  NarratorItem(
      {this.heading,
      required int gameId,
      required int itemId,
      required bool deleted,
      required int lastModificationDate,
      required int sortKey,
      required String title,
      required String richText,
      String? icon,
      required String description,
      Dependency? dependsOn,
      Dependency? disappearOn,
      Map<String, String>? fileReferences,
      Color? primaryColor,
      double? lat,
      double? lng,
      double? authoringX,
      double? authoringY,
      double? relX,
      double? relY,
      int? chapter,
      required bool showOnMap,
      required bool showInList,
      OpenQuestion? openQuestion})
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
            authoringX: authoringX,
            authoringY: authoringY,
            relX: relX,
            relY: relY,
            chapter: chapter,
            showOnMap: showOnMap,
            showInList: showInList,
            openQuestion: openQuestion);

  factory NarratorItem.fromJson(Map json) {
//    print("json map ${json}");
    return NarratorItem(
        gameId: int.parse(json['gameId']),
        itemId: int.parse(json['id']),
        deleted: json['deleted'] ?? false,
        lastModificationDate: int.parse(json['lastModificationDate']),
        sortKey: json['sortKey'] ?? 0,
        title: json['name'] ?? '',
        heading: json['heading'],
        richText: json['richText'] ?? '',
        icon: json['icon'],
        description: (json['description'] ?? "").trim(),
        lat: json['lat'],
        lng: json['lng'],
        authoringX: json['customMapX'],
        authoringY: json['customMapY'],
        relX: json['relX'],
        relY: json['relY'],
        chapter: json['chapter'] == null ? null: int.parse(json['chapter']),
        showOnMap: json['showOnMap'] ?? true,
        showInList: json['showInList'] == null ? true : json['showInList'],
        openQuestion: json['openQuestion'] != null ? OpenQuestion.fromJson(json["openQuestion"]) : null,
        fileReferences: json['fileReferences'] != null
            ? new Map.fromIterable(json["fileReferences"],
                key: (item) => item['key'], value: (item) => item['fileReference'] ?? '')
            : {},
        primaryColor: json['primaryColor'] != null ? colorFromHex(json['primaryColor']) : null,
        dependsOn: json['dependsOn'] != null ? Dependency.fromJson(json['dependsOn']) : null,
        disappearOn: json['disappearOn'] != null ? Dependency.fromJson(json['disappearOn']) : null);
  }

  Widget buildPage() {
    return NarratorWidget(item: this);
  }
}

class PictureQuestion extends GeneralItem {
  PictureQuestion(
      {required int gameId,
      required int itemId,
      required bool deleted,
      required int lastModificationDate,
      required int sortKey,
      required String title,
      required String richText,
      String? icon,
      required String description,
      Dependency? dependsOn,
      Dependency? disappearOn,
      Map<String, String>? fileReferences,
      Color? primaryColor,
      double? lat,
      double? lng,
      double? authoringX,
      double? authoringY,
        int? chapter,
      required bool showOnMap,
      required bool showInList,
      OpenQuestion? openQuestion})
      : super(
            type: ItemType.picturequestion,
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
            authoringX: authoringX,
            authoringY: authoringY,
      chapter: chapter,
            showOnMap: showOnMap,
            showInList: showInList,
            openQuestion: openQuestion);

  factory PictureQuestion.fromJson(Map json) {
//    print("json map ${json}");
    return PictureQuestion(
        gameId: int.parse(json['gameId']),
        itemId: int.parse(json['id']),
        deleted: json['deleted'],
        lastModificationDate: int.parse(json['lastModificationDate']),
        sortKey: json['sortKey'] ?? 0,
        title: json['name'],
        richText: json['richText'] ?? '',
        icon: json['icon'],
        description: (json['description'] ?? "").trim(),
        lat: json['lat'],
        lng: json['lng'] != null ? json['lng'] : null,
        authoringX: json['customMapX'],
        authoringY: json['customMapY'],
        chapter: json['chapter'] == null ? null: int.parse(json['chapter']),
        showOnMap: json['showOnMap'] ?? false,
        showInList: json['showInList'] == null ? true : json['showInList'],
        openQuestion: json['openQuestion'] != null ? OpenQuestion.fromJson(json["openQuestion"]) : null,
        fileReferences: json['fileReferences'] != null
            ? new Map.fromIterable(json["fileReferences"],
                key: (item) => item['key'], value: (item) => item['fileReference'] ?? '')
            : {},
        primaryColor: json['primaryColor'] != null ? colorFromHex(json['primaryColor']) : null,
        dependsOn: json['dependsOn'] != null ? Dependency.fromJson(json['dependsOn']) : null,
        disappearOn: json['disappearOn'] != null ? Dependency.fromJson(json['disappearOn']) : null);
  }

  String getIcon() {
    return icon ?? 'fa.camera';
  }

  bool get isSupported {
    return !UniversalPlatform.isWeb;
  }

  Widget buildPage() {
    return PictureQuestionWidget(item: this);
  }
}

Color colorFromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
