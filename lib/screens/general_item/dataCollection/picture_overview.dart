import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/screens/components/button/cust_flat_button.dart';
import 'package:youplay/screens/components/button/cust_raised_button.dart';
import 'package:youplay/screens/general_item/util/messages/components/answerwithpicture/answerlist.container.dart';
import 'package:youplay/screens/general_item/util/messages/components/game_themes.viewmodel.dart';
import 'package:youplay/screens/general_item/util/messages/components/next_button.dart';
import 'package:youplay/screens/general_item/util/messages/generic_message.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';
import 'package:youplay/ui/components/next_button/next_button.container.dart';

import '../../../localizations.dart';
import '../general_item.dart';

class PictureOverview extends StatelessWidget {
  GeneralItem item;
  GeneralItemViewModel giViewModel;
  GameThemesViewModel themeModel;
  Function takePicture;

  PictureOverview(
      {required this.item, required this.giViewModel,required  this.themeModel,required  this.takePicture});

  @override
  Widget build(BuildContext context) {
    return GeneralItemWidget(
        item: item,
        giViewModel: giViewModel,
        padding: false,
        elevation: false,
        body: Container(
          color: Color.fromRGBO(0, 0, 0, 0.7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RichTextTopContainer(),
              Expanded(child: AnswerListContainer(
                tapResponse: (response) {

                },
              )),
              Padding(
                padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 8),
                child: NextButtonContainer(item: giViewModel.item!),
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
        ));
  }
}
