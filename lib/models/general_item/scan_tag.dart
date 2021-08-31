import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/dependency.dart';
import 'package:youplay/ui/components/messages_pages/scan-tag.widget.container.dart';

class ScanTagGeneralItem extends GeneralItem {

  ScanTagGeneralItem({
    required int gameId,
    required int itemId,
    required bool deleted,
    required int lastModificationDate,
    required int sortKey,
    required String title,
    required String richText,
     double? lat,
     double? lng,
    Dependency? dependsOn,
    Dependency? disappearOn,
    required bool showOnMap,
    required bool showInList,
  }) : super(type: ItemType.scanTag,
      gameId: gameId,
      itemId: itemId,
      description: '',
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
        sortKey: json['sortKey']??0,
        title: json['name'],
        richText: json['richText']??'',
        lat: json['lat'],
        lng: json['lng'],
        showOnMap: json['showOnMap']??false,
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

  Widget buildPage() {
    return  ScanTagWidgetContainer();

  }
}
