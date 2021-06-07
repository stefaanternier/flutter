import 'dart:collection';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youplay/models/general_item/audio_question.dart';
import 'package:youplay/models/general_item/multiple_choice_image.dart';
import 'package:youplay/models/general_item/open_question.dart';
import 'package:youplay/models/general_item/scan_tag.dart';
import 'package:youplay/models/general_item/single_choice.dart';
import 'package:youplay/models/general_item/single_choice_image.dart';
import 'package:youplay/models/general_item/video_object.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/models/general_item/dependency.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:flutter/material.dart';

import 'general_item/audio_object.dart';
import 'general_item/combination_lock.dart';
import 'general_item/open_url.dart';
import 'general_item/text_question.dart';
import 'general_item/video_question.dart';

enum ItemType {
  audio,
  video,
  narrator,
  openurl,
  scanTag,
  multiplechoice,
  singlechoice,
  singlechoiceimage,
  multiplechoiceimage,
  picturequestion,
  audioquestion,
  textquestion,
  videoquestion,
  combinationlock
}

class ItemTimes {
  GeneralItem generalItem;
  int appearTime;
  int disappearTime;

  ItemTimes({this.generalItem, this.appearTime, this.disappearTime});
}

class GeneralItemsVisibility {
  int runId;
  int generalItemId;
  int timeStamp;
  int status; //1==visible, 2==invisible

  GeneralItemsVisibility({this.runId, this.generalItemId, this.timeStamp, this.status});

  GeneralItemsVisibility.fromJson(Map json)
      : runId = int.parse("${json['runId']}"),
        generalItemId = int.parse("${json['generalItemId']}"),
        timeStamp = int.parse("${json['timeStamp']}"),
        status = int.parse("${json['status']}");
}

class GeneralItem {
  ItemType type;
  int gameId;
  bool deleted;
  int lastModificationDate;
  int itemId;
  int sortKey;
  String title;
  String richText;
  String description;
  String icon;
  Dependency dependsOn;
  Dependency disappearOn;
  Map<String, String> fileReferences;
  double lng;
  double lat;
  bool showOnMap;
  bool showInList;
  OpenQuestion openQuestion;
  Color primaryColor;

  GeneralItem(
      {this.type,
      this.gameId,
      this.deleted = false,
      this.lastModificationDate,
      this.itemId,
      this.sortKey,
      this.title,
      this.richText,
      this.description,
      this.dependsOn,
      this.disappearOn,
      this.fileReferences,
      this.primaryColor,
      this.lat,
      this.lng,
        this.icon,
      this.showOnMap,
      this.showInList,
      this.openQuestion});

  factory GeneralItem.fromJson(Map json) {
//    print("json is  $json");
//    print("json is  ${parseType(json['type'])}");
    switch (parseType(json['type'])) {
      case ItemType.narrator:
        return NarratorItem.fromJson(json);
        break;
      case ItemType.openurl:
        return OpenUrl.fromJson(json);
        break;
      case ItemType.audio:
        return AudioObjectGeneralItem.fromJson(json);
        break;
      case ItemType.video:
        return VideoObjectGeneralItem.fromJson(json);
      case ItemType.combinationlock:
        return CombinationLockGeneralItem.fromJson(json);
        case ItemType.singlechoice:
        return SingleChoiceGeneralItem.fromJson(json);
      case ItemType.multiplechoice:
        return MultipleChoiceGeneralItem.fromJson(json);
      case ItemType.scanTag:
        return ScanTagGeneralItem.fromJson(json);
        break;
      case ItemType.singlechoiceimage:
        return SingleChoiceImageGeneralItem.fromJson(json);
        break;
      case ItemType.multiplechoiceimage:
        return MultipleChoiceImageGeneralItem.fromJson(json);
        break;

      case ItemType.picturequestion:
        return PictureQuestion.fromJson(json);
        break;
      case ItemType.audioquestion:
        return AudioQuestion.fromJson(json);
        break;
      case ItemType.textquestion:
        return TextQuestion.fromJson(json);
        break;
      case ItemType.videoquestion:
        return VideoQuestion.fromJson(json);
        break;
    }
    return NarratorItem.fromJson(json);

    Color colorFromHex(String hexString) {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    }
  }

  static parseType(String type) {
    if (type == 'org.celstec.arlearn2.beans.generalItem.AudioObject') return ItemType.audio;
    if (type == 'org.celstec.arlearn2.beans.generalItem.VideoObject') return ItemType.video;
    if (type == 'org.celstec.arlearn2.beans.generalItem.ScanTag') return ItemType.scanTag;
    if (type == 'org.celstec.arlearn2.beans.generalItem.CombinationLock')
      return ItemType.combinationlock;
    if (type == 'org.celstec.arlearn2.beans.generalItem.SingleChoiceTest')
      return ItemType.singlechoice;
    if (type == 'org.celstec.arlearn2.beans.generalItem.MultipleChoiceTest')
      return ItemType.multiplechoice;
    if (type == 'org.celstec.arlearn2.beans.generalItem.SingleChoiceImageTest')
      return ItemType.singlechoiceimage;
    if (type == 'org.celstec.arlearn2.beans.generalItem.MultipleChoiceImageTest')
      return ItemType.multiplechoiceimage;
    if (type == 'org.celstec.arlearn2.beans.generalItem.PictureQuestion')
      return ItemType.picturequestion;
    if (type == 'org.celstec.arlearn2.beans.generalItem.AudioQuestion')
      return ItemType.audioquestion;
    if (type == 'org.celstec.arlearn2.beans.generalItem.TextQuestion')
      return ItemType.textquestion;
    if (type == 'org.celstec.arlearn2.beans.generalItem.VideoQuestion')
      return ItemType.videoquestion;
    if (type == 'org.celstec.arlearn2.beans.generalItem.OpenUrl')
      return ItemType.openurl;
    return ItemType.narrator;
  }

  toString() {
    return "[GI] ${this.type} - ${this.title}";
  }

  int visibleAt(HashMap<String, ARLearnAction> actions) {
    if (dependsOn == null) return 0;
    return dependsOn.evaluate(actions);
  }

  int disapperAt(HashMap<String, ARLearnAction> actions) {
    if (disappearOn == null) return -1;
    return disappearOn.evaluate(actions);
  }

  String getIcon() {
     return icon ?? 'fa.walking';
  }

  bool get isSupported {
    return true;
  }
}

class LocationTrigger {
  double lat;
  double lng;
  int radius;

  LocationTrigger({this.lat, this.lng, this.radius});
}

//
//{
//"type": "org.celstec.arlearn2.beans.generalItem.AudioObject",
//"gameId": "616042",
//"deleted": false,
//"lastModificationDate": "1428995525836",
//"id": "616044",
//"sortKey": 6,
//"scope": "user",
//"name": "Opdracht 5",
//"description": "Ga naar binnen, stel vast hoeveel zijden het oratorium hier heeft. Dit is gelijk aan het aantal kapellen en de voorhal; de kapellen zijn nu lokalen. \nEen plattegrond (tegenover de ingang) maakt duidelijk hoe de overgang van de zestien- naar achthoek wordt gemaakt: kijk net zo lang, totdat je dit door hebt. \nMaak een foto van een herkenbaar deel van de rondgang en spreek in vijftig woorden een beschrijving in, waarbij je alle natuurstenen elementen benoemt.",
//"dependsOn": {
//"type": "org.celstec.arlearn2.beans.dependencies.ActionDependency",
//"action": "read",
//"generalItemId": "627042",
//"scope": 0
//},
//"autoLaunch": false,
//"lng": 11.260144,
//"lat": 43.775301,
//"showCountDown": false,
//"richText": "Ga naar binnen, stel vast hoeveel zijden het oratorium hier heeft. Dit is gelijk aan het aantal kapellen en de voorhal; de kapellen zijn nu lokalen.&nbsp;<div><br></div><div>Een plattegrond (tegenover de ingang) maakt duidelijk hoe de overgang van de zestien- naar achthoek wordt gemaakt: kijk net zo lang, totdat je dit door hebt.&nbsp;</div><div><b><br></b><div><b>Maak een foto van een herkenbaar deel van de rondgang en spreek in vijftig woorden een beschrijving in, waarbij je alle natuurstenen elementen benoemt.</b></div></div>",
//"openQuestion": {
//"type": "org.celstec.arlearn2.beans.generalItem.OpenQuestion",
//"withAudio": true,
//"withText": false,
//"withValue": false,
//"withPicture": true,
//"withVideo": false,
//"textDescription": "",
//"valueDescription": ""
//},
//"audioFeed": "http://sharetec.celstec.org/arlearn/florence/2012/mp3/A5.mp3",
//"autoPlay": false,
//"message": false
//}
