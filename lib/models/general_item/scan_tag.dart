import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/dependency.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScanTagGeneralItem extends GeneralItem {

  ScanTagGeneralItem({
    int gameId,
    int itemId,
    bool deleted,
    int lastModificationDate,
    int sortKey,
    String title,
    String richText,
    double lat,
    double lng,
    Dependency dependsOn,
    Dependency disappearOn,
    bool showOnMap,
    bool showInList,
  }) : super(type: ItemType.scanTag,
      gameId: gameId,
      itemId: itemId,

      deleted:deleted,
      lastModificationDate: lastModificationDate,
      sortKey:sortKey,
      title:title,
      richText:richText,
      dependsOn: dependsOn,
      disappearOn: disappearOn,
      showOnMap: showOnMap,
      showInList:showInList,
    lat:lat,
    lng:lng

  );

  factory ScanTagGeneralItem.fromJson(Map json) {
    var returnItem = ScanTagGeneralItem(
        gameId: int.parse(json['gameId']),
        itemId: int.parse(json['id']),
        deleted: json['deleted'],
        lastModificationDate: int.parse(json['lastModificationDate']),
        sortKey: json['sortKey'],
        title: json['name'],
        richText: json['richText'],
        lat: json['lat'] != null?json['lat']:null,
        lng: json['lng'] != null?json['lng']:null,
        showOnMap: json['showOnMap'],
        showInList: json['showInList'] == null? true: json['showInList'],
        dependsOn: json['dependsOn'] != null
            ? Dependency.fromJson(json['dependsOn'])
            : null,
        disappearOn: json['disappearOn'] != null
            ? Dependency.fromJson(json['disappearOn'])
            : null);
    return returnItem;
  }

  bool get isSupported {
    return !UniversalPlatform.isWeb;
  }

  String getIcon(){
    
    return 'fa.qrcode';
  }
}
