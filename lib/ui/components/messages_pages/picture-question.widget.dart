import 'package:flutter/material.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:youplay/ui/components/messages/picture-question/picture_overview.dart';
import 'package:youplay/screens/general_item/dataCollection/picture_preview-file.container.dart';
import 'package:youplay/screens/general_item/dataCollection/take_picture.dart';

enum PictureQuestionStates { overview, takePicture, annotateMetadata }

class PictureQuestionWidget extends StatefulWidget {
  final PictureQuestion item;

  PictureQuestionWidget({required this.item, Key? key}) : super(key: key);

  @override
  _PictureQuestionWidgetState createState() => _PictureQuestionWidgetState();
}

class _PictureQuestionWidgetState extends State<PictureQuestionWidget> {
  PictureQuestionStates currentState = PictureQuestionStates.overview;
  String? imagePath;

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
            item: widget.item);

      case PictureQuestionStates.takePicture:
        return TakePictureWidget(
          // giViewModel: widget.giViewModel,
          // run: widget.giViewModel.run,
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
