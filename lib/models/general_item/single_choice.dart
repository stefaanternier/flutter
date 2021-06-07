import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/dependency.dart';
import 'package:flutter/material.dart';

import '../game.dart';

class SingleChoiceGeneralItem extends GeneralItem {
  List<ChoiceAnswer> answers = [];
  bool showFeedback;
  String text;

  SingleChoiceGeneralItem({
    int gameId,
    int itemId,
    bool deleted,
    int lastModificationDate,
    int sortKey,
    String title,
    this.text,
    this.showFeedback,
    String richText,
    String description,
    this.answers,
    Dependency dependsOn,
    Dependency disappearOn,
    Color primaryColor,
    Map<String, String> fileReferences,
    double lat,
    double lng,
    bool showOnMap,
    bool showInList,
  }) : super(
            type: ItemType.singlechoice,
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
            showOnMap: showOnMap,
            showInList: showInList,
            lat: lat,
            lng: lng);

  factory SingleChoiceGeneralItem.fromJson(Map json) {
    var returnItem = SingleChoiceGeneralItem(
        gameId: int.parse(json['gameId']),
        itemId: int.parse(json['id']),
        deleted: json['deleted'],
        lastModificationDate: int.parse(json['lastModificationDate']),
        sortKey: json['sortKey'],
        title: json['name'],
        text: json['text'],
        showFeedback: json['showFeedback'] == null ? false : json['showFeedback'],
        richText: json['richText'],
        description: (json['description'] ?? "").trim(),
        answers: json['answers'] == null
            ? []
            : List<ChoiceAnswer>.generate(
                json['answers'].length, (i) => ChoiceAnswer.fromJson(json['answers'][i])),
        showOnMap: json['showOnMap'],
        showInList: json['showInList'] == null ? true : json['showInList'],
        lat: json['lat'] != null ? json['lat'] : null,
        lng: json['lng'] != null ? json['lng'] : null,
        fileReferences: json['fileReferences'] != null
            ? new Map.fromIterable(json["fileReferences"],
                key: (item) => item['key'], value: (item) => item['fileReference'])
            : null,
        primaryColor: json['primaryColor'] != null ? colorFromHex(json['primaryColor']) : null,
        dependsOn: json['dependsOn'] != null ? Dependency.fromJson(json['dependsOn']) : null,
        disappearOn: json['disappearOn'] != null ? Dependency.fromJson(json['disappearOn']) : null);
    return returnItem;
  }

  String getIcon() {
    return 'fa.list';
  }
}

class MultipleChoiceGeneralItem extends GeneralItem {
  List<ChoiceAnswer> answers = [];
  String text;
  bool showFeedback;

  MultipleChoiceGeneralItem({
    int gameId,
    int itemId,
    bool deleted,
    int lastModificationDate,
    int sortKey,
    String title,
    String richText,
    String description,
    this.text,
    this.answers,
    this.showFeedback,
    Dependency dependsOn,
    Dependency disappearOn,
    Map<String, String> fileReferences,
    Color primaryColor,
    double lat,
    double lng,
    bool showOnMap,
    bool showInList,
  }) : super(
            type: ItemType.multiplechoice,
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
            showOnMap: showOnMap,
            showInList: showInList,
            lat: lat,
            lng: lng);

  factory MultipleChoiceGeneralItem.fromJson(Map json) {
    var returnItem = MultipleChoiceGeneralItem(
        gameId: int.parse(json['gameId']),
        itemId: int.parse(json['id']),
        deleted: json['deleted'],
        lastModificationDate: int.parse(json['lastModificationDate']),
        sortKey: json['sortKey'],
        title: json['name'],
        text: json['text'],
        richText: json['richText'],
        description: (json['description'] ?? "").trim(),
        showFeedback: json['showFeedback'] == null ? false : json['showFeedback'],
        answers: json['answers'] == null
            ? []
            : List<ChoiceAnswer>.generate(
                json['answers'].length, (i) => ChoiceAnswer.fromJson(json['answers'][i])),
        showOnMap: json['showOnMap'],
        showInList: json['showInList'] == null ? true : json['showInList'],
        lat: json['lat'] != null ? json['lat'] : null,
        lng: json['lng'] != null ? json['lng'] : null,
        fileReferences: json['fileReferences'] != null
            ? new Map.fromIterable(json["fileReferences"],
                key: (item) => item['key'], value: (item) => item['fileReference'])
            : null,
        primaryColor: json['primaryColor'] != null ? colorFromHex(json['primaryColor']) : null,
        dependsOn: json['dependsOn'] != null ? Dependency.fromJson(json['dependsOn']) : null,
        disappearOn: json['disappearOn'] != null ? Dependency.fromJson(json['disappearOn']) : null);
    return returnItem;
  }

  String getIcon() {
    return 'fa.list';
  }
}

class ChoiceAnswer {
  bool isCorrect;
  String answer;
  String feedback;
  String id;

  ChoiceAnswer({this.isCorrect, this.answer, this.id, this.feedback});

  ChoiceAnswer.fromJson(Map json)
      : isCorrect = json['isCorrect'],
        feedback = json['feedback'],
        id = json['id'],
        answer = json['answer'];
}
