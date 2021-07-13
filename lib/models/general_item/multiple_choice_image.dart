import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/dependency.dart';
import 'package:flutter/material.dart';

import '../game.dart';

class MultipleChoiceImageGeneralItem extends GeneralItem {
  List<ImageChoiceAnswer> answers = [];
  bool showFeedback = false;
  String text;

  MultipleChoiceImageGeneralItem({
    required int gameId,
    required int itemId,
    required bool deleted,
    required int lastModificationDate,
    required int sortKey,
    required String title,
    required String richText,
    required String description,
    required this.text,
    required this.showFeedback,
    required this.answers,
    Dependency? dependsOn,
    Dependency? disappearOn,
    Map<String, String>? fileReferences,
    Color? primaryColor,
    required bool showOnMap,
    required bool showInList,
    double? lat,
    double? lng,
  }) : super(
            type: ItemType.multiplechoiceimage,
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

  factory MultipleChoiceImageGeneralItem.fromJson(Map json) {
    var returnItem = MultipleChoiceImageGeneralItem(
        gameId: int.parse(json['gameId']),
        itemId: int.parse(json['id']),
        deleted: json['deleted'],
        lastModificationDate: int.parse(json['lastModificationDate']),
        sortKey: json['sortKey'] ?? 0,
        title: json['name'],
        richText: json['richText'] ?? '',
        description: (json['description'] ?? "").trim(),
        text: json['text']??'',
        showFeedback:
            json['showFeedback'] == null ? false : json['showFeedback'],
        answers: json['answers'] == null
            ? []
            : List<ImageChoiceAnswer>.generate(json['answers'].length,
                (i) => ImageChoiceAnswer.fromJson(json['answers'][i])),
        showOnMap: json['showOnMap'] ?? false,
        showInList: json['showInList'] == null ? true : json['showInList'],
        lat: json['lat'],
        lng: json['lng'],
        fileReferences: json['fileReferences'] != null
            ? new Map.fromIterable(json["fileReferences"],
                key: (item) => item['key'],
                value: (item) => item['fileReference'] ?? '')
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
    return returnItem;
  }

  String getIcon() {
    return 'fa.th';
  }
}

Color colorFromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

class ImageChoiceAnswer {
  bool isCorrect;
  String feedback;
  String id;

  ImageChoiceAnswer(
      {required this.isCorrect, required this.id, required this.feedback});

  ImageChoiceAnswer.fromJson(Map json)
      : isCorrect = json['isCorrect'],
        feedback = json['feedback'],
        id = json['id'];
}
