import 'package:flutter/material.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/ui/components/messages/picture-question/picture_overview.dart';
import 'package:youplay/ui/components/messages/picture-question/picture_preview-file.container.dart';
import 'package:youplay/ui/components/messages/picture-question/take_picture.dart';

import '../messages/picture-question/picture-question.play.widget.dart';

enum PictureQuestionStates { overview, takePicture, annotateMetadata, play }

class PictureQuestionWidget extends StatefulWidget {
  final PictureQuestion item;

  PictureQuestionWidget({required this.item, Key? key}) : super(key: key);

  @override
  _PictureQuestionWidgetState createState() => _PictureQuestionWidgetState();
}

class _PictureQuestionWidgetState extends State<PictureQuestionWidget> {
  PictureQuestionStates currentState = PictureQuestionStates.overview;
  String? imagePath;
  Response? currentResponse;

  @override
  Widget build(BuildContext context) {
    switch (currentState) {
      case PictureQuestionStates.overview:
        return PictureOverview(
            takePicture: () {
              setState(() {
                currentState = PictureQuestionStates.takePicture;
              });
            },
            tapPicture: (Response resp) {
              setState(() {
                currentResponse = resp;
                currentState = PictureQuestionStates.play;
              });
            },
            item: widget.item);

      case PictureQuestionStates.takePicture:
        return TakePictureWidget(
          generalItem: widget.item,
          cancelCallBack: () {
            setState(() {
              currentState = PictureQuestionStates.overview;
            });
          },
          pictureTaken: (String path) {
            setState(() {
              imagePath = path;
              currentState = PictureQuestionStates.annotateMetadata;
            });
          },
        );
      case PictureQuestionStates.play:
        return PictureQuestionPlayWidget(
          back: () {
            setState(() {
              currentState = PictureQuestionStates.overview;
            });
          },
          onDelete: () {},
          item: widget.item,
          response: currentResponse!,
        );

      case PictureQuestionStates.annotateMetadata:
          return PictureFilePreviewContainer(
            imagePath: imagePath!,
            generalItem: widget.item,
            finished: () {
              setState(() {
                currentState = PictureQuestionStates.overview;
              });
            },
          );

    }
  }
}
