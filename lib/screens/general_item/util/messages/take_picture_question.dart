// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/localizations.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/screens/components/button/cust_flat_button.dart';
import 'package:youplay/screens/components/button/cust_raised_button.dart';
import 'package:youplay/screens/general_item/dataCollection/picture_overview.container.dart';
import 'package:youplay/screens/general_item/dataCollection/picture_preview-file.container.dart';
import 'package:youplay/screens/general_item/dataCollection/take_picture.dart';
import 'package:youplay/screens/general_item/general_item.dart';

enum PictureQuestionStates { overview, takePicture, annotateMetadata }


class NarratorWithPicture extends StatefulWidget {
  GeneralItem item;
  GeneralItemViewModel giViewModel;

  NarratorWithPicture({required this.item, required  this.giViewModel});

  @override
  _NarratorWithPictureState createState() => new _NarratorWithPictureState();
}

class _NarratorWithPictureState extends State<NarratorWithPicture> {
  // bool _pictureOverviewMode = true;
  PictureQuestionStates currentState = PictureQuestionStates.overview;

  Response? currentResponse;
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    switch (currentState) {
      case PictureQuestionStates.overview:
        return PictureOverviewContainer(giViewModel: widget.giViewModel, takePicture: (){
          setState(() {
            currentState = PictureQuestionStates.takePicture;
          });
        },);

      case PictureQuestionStates.takePicture:
        return TakePictureWidget(
          giViewModel: widget.giViewModel,
          run: widget.giViewModel.run,
          generalItem: widget.giViewModel.item,
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
        if (widget.giViewModel.item != null && widget.giViewModel.run?.runId != null && imagePath != null) {
          return PictureFilePreviewContainer(
            giViewModel: widget.giViewModel,
            imagePath: imagePath!,
            run: widget.giViewModel.run!,
            generalItem: widget.giViewModel.item!,
            finished: () {
              setState(() {
                currentState = PictureQuestionStates.overview;
              });
            },
          );
        }
    }
    return Container(child: Text('something went wrong...'));  //todo make message beautiful

  }
}
