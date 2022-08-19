import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/ui/components/buttons/cust_flat_button.dart';
import 'package:youplay/ui/components/messages/picture-question/answerlist.container.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';
import 'package:youplay/ui/components/next_button/next_button.container.dart';

class PictureOverview extends StatelessWidget {
  final PictureQuestion item;
  Function takePicture;
  final Function(Response) tapPicture;

  PictureOverview(
      {required this.item,
      required this.takePicture,
        required this.tapPicture
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ThemedAppbarContainer(title: item.title, elevation: false),
      body: MessageBackgroundWidgetContainer(
        darken: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RichTextTopContainer(),
            Expanded(
                child: AnswerListContainer(
              tapResponse: this.tapPicture,
            )),
            Padding(
              padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 8),
              child: NextButtonContainer(item: item),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 28),
              child: CustomFlatButton(
                title: "Maak foto",
                icon: FontAwesomeIcons.cameraRetro,
                color: Colors.white,
                onPressed: takePicture,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
