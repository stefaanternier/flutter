import 'package:flutter/material.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/dependency.dart';
import 'package:youplay/ui/components/messages_pages/multiple-choice.widget.container.dart';
import 'package:youplay/ui/components/messages_pages/single-choice.widget.container.dart';

import '../game.dart';

class SingleChoiceGeneralItem extends GeneralItem {
  List<ChoiceAnswer> answers = [];
  bool showFeedback;
  String text;

  SingleChoiceGeneralItem({
    required int gameId,
    required int itemId,
    required bool deleted,
    required int lastModificationDate,
    required int sortKey,
    required String title,
    required this.text,
    required this.showFeedback,
    required String richText,
    String? icon,
    required String description,
    required this.answers,
    Dependency? dependsOn,
    Dependency? disappearOn,
    Color? primaryColor,
    Map<String, String>? fileReferences,
    double? lat,
    double? lng,
    double? authoringX,
    double? authoringY,
    int? chapter,
    required bool showOnMap,
    required bool showInList,
  }) : super(
            type: ItemType.singlechoice,
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
            showOnMap: showOnMap,
            showInList: showInList,
            authoringX: authoringX,
            authoringY: authoringY,
            chapter: chapter,
            lat: lat,
            lng: lng);

  factory SingleChoiceGeneralItem.fromJson(Map json) {
    var returnItem = SingleChoiceGeneralItem(
        gameId: int.parse(json['gameId']),
        itemId: int.parse(json['id']),
        deleted: json['deleted'],
        lastModificationDate: int.parse(json['lastModificationDate']),
        sortKey: json['sortKey'] ?? 0,
        title: json['name'],
        text: json['text'] ?? '',
        showFeedback: json['showFeedback'] == null ? false : json['showFeedback'],
        richText: json['richText'] ?? '',
        icon: json['icon'],
        description: (json['description'] ?? "").trim(),
        answers: json['answers'] == null
            ? []
            : List<ChoiceAnswer>.generate(json['answers'].length, (i) => ChoiceAnswer.fromJson(json['answers'][i])),
        showOnMap: json['showOnMap'] ?? false,
        showInList: json['showInList'] == null ? true : json['showInList'],
        lat: json['lat'],
        lng: json['lng'],
        authoringX: json['customMapX'],
        authoringY: json['customMapY'],
        chapter: json['chapter'] == null ? null : int.parse(json['chapter']),
        fileReferences: json['fileReferences'] != null
            ? new Map.fromIterable(json["fileReferences"],
                key: (item) => item['key'], value: (item) => item['fileReference'] ?? '')
            : null,
        primaryColor: json['primaryColor'] != null ? colorFromHex(json['primaryColor']) : null,
        dependsOn: json['dependsOn'] != null ? Dependency.fromJson(json['dependsOn']) : null,
        disappearOn: json['disappearOn'] != null ? Dependency.fromJson(json['disappearOn']) : null);
    return returnItem;
  }

  String getIcon() {
    return icon ?? 'fa.list';
  }

  Widget buildPage() {
    return SingleChoiceWidgetContainer(item: this);
  }
}

class MultipleChoiceGeneralItem extends GeneralItem {
  List<ChoiceAnswer> answers = [];
  String text;
  bool showFeedback;

  MultipleChoiceGeneralItem({
    required int gameId,
    required int itemId,
    required bool deleted,
    required int lastModificationDate,
    required int sortKey,
    required String title,
    required String richText,
    String? icon,
    required String description,
    required this.text,
    required this.answers,
    required this.showFeedback,
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
  }) : super(
            type: ItemType.multiplechoice,
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
            showOnMap: showOnMap,
            showInList: showInList,
            authoringX: authoringX,
            authoringY: authoringY,
            chapter: chapter,
            lat: lat,
            lng: lng);

  factory MultipleChoiceGeneralItem.fromJson(Map json) {
    var returnItem = MultipleChoiceGeneralItem(
        gameId: int.parse(json['gameId']),
        itemId: int.parse(json['id']),
        deleted: json['deleted'],
        lastModificationDate: int.parse(json['lastModificationDate']),
        sortKey: json['sortKey'] ?? 0,
        title: json['name'],
        text: json['text'] ?? '',
        richText: json['richText'] ?? '',
        icon: json['icon'],
        description: (json['description'] ?? "").trim(),
        showFeedback: json['showFeedback'] == null ? false : json['showFeedback'],
        answers: json['answers'] == null
            ? []
            : List<ChoiceAnswer>.generate(json['answers'].length, (i) => ChoiceAnswer.fromJson(json['answers'][i])),
        showOnMap: json['showOnMap'] ?? false,
        showInList: json['showInList'] == null ? true : json['showInList'],
        lat: json['lat'],
        lng: json['lng'],
        authoringX: json['customMapX'],
        authoringY: json['customMapY'],
        chapter: json['chapter'] == null ? null : int.parse(json['chapter']),
        fileReferences: json['fileReferences'] != null
            ? new Map.fromIterable(json["fileReferences"],
                key: (item) => item['key'], value: (item) => item['fileReference'] ?? '')
            : null,
        primaryColor: json['primaryColor'] != null ? colorFromHex(json['primaryColor']) : null,
        dependsOn: json['dependsOn'] != null ? Dependency.fromJson(json['dependsOn']) : null,
        disappearOn: json['disappearOn'] != null ? Dependency.fromJson(json['disappearOn']) : null);
    return returnItem;
  }

  String getIcon() {
    return icon ?? 'fa.list';
  }

  Widget buildPage() {
    return MultipleChoiceWidgetContainer(item: this);
  }
}

class ChoiceAnswer {
  bool isCorrect;
  String answer;
  String feedback;
  String id;

  ChoiceAnswer({required this.isCorrect, required this.answer, required this.id, required this.feedback});

  ChoiceAnswer.fromJson(Map json)
      : isCorrect = json['isCorrect'],
        feedback = json['feedback'],
        id = json['id'],
        answer = json['answer'];
}
