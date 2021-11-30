import 'package:flutter/material.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/dependency.dart';
import 'package:youplay/ui/components/messages_pages/video-player.widget.container.dart';

class VideoObjectGeneralItem extends GeneralItem {
  VideoObjectGeneralItem({
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
    double? authoringX,
    double? authoringY,
    required bool showOnMap,
    required bool showInList,
    Dependency? dependsOn,
    Dependency? disappearOn,
    Map<String, String>? fileReferences,
    Color? primaryColor,
  }) : super(
            type: ItemType.video,
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
            authoringX: authoringX,
            authoringY: authoringY,
            showOnMap: showOnMap,
            showInList: showInList,
            disappearOn: disappearOn,
            dependsOn: dependsOn);

  factory VideoObjectGeneralItem.fromJson(Map json) {
    VideoObjectGeneralItem returnItem = VideoObjectGeneralItem(
        gameId: int.parse(json['gameId']),
        itemId: int.parse(json['id']),
        deleted: json['deleted'],
        lastModificationDate: int.parse(json['lastModificationDate']),
        sortKey: json['sortKey'] ?? 0,
        title: json['name'],
        richText: json['richText'] ?? '',
        description: (json['description'] ?? "").trim(),
        showOnMap: json['showOnMap'] ?? false,
        showInList: json['showInList'] == null ? true : json['showInList'],
        fileReferences: json['fileReferences'] != null
            ? new Map.fromIterable(json["fileReferences"],
                key: (item) => item['key'], value: (item) => item['fileReference'] ?? '')
            : {},
        primaryColor: json['primaryColor'] != null ? colorFromHex(json['primaryColor']) : null,
        lat: json['lat'],
        lng: json['lng'],
        authoringX: json['customMapX'],
        authoringY: json['customMapY'],
        dependsOn: json['dependsOn'] != null ? Dependency.fromJson(json['dependsOn']) : null,
        disappearOn: json['disappearOn'] != null ? Dependency.fromJson(json['disappearOn']) : null);
    // if (returnItem.fileReferences != null) {
    //   if (returnItem.fileReferences!['video'] == null) {
    //     returnItem.fileReferences!['video'] = '/game/${returnItem.gameId}/generalItems/${returnItem.itemId}/video.mp4';
    //   }
    // }
    return returnItem;
  }

  String getIcon() {
    return 'fa.film';
  }

  Widget buildPage() {
    return VideoPlayerWidgetContainer();
  }
}

Color colorFromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
