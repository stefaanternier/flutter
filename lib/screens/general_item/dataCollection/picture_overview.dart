import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/screens/components/button/cust_flat_button.dart';
import 'package:youplay/screens/components/button/cust_raised_button.dart';
import 'package:youplay/screens/general_item/util/messages/components/answerwithpicture/answerlist.container.dart';
import 'package:youplay/screens/general_item/util/messages/components/game_themes.viewmodel.dart';
import 'package:youplay/screens/general_item/util/messages/components/next_button.dart';
import 'package:youplay/screens/general_item/util/messages/generic_message.dart';

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
              Visibility(
                visible: giViewModel.item?.richText != null,
                child: Container(
                    // color: this.widget.giViewModel.getPrimaryColor(),
                    color: themeModel.getPrimaryColor(),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "${giViewModel.item?.richText??''}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    )),
              ),
              Expanded(child: AnswerListContainer(
                tapResponse: (response) {

                },
              )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 8),
                  child: NextButton(
                      buttonText: item.description != ""
                          ? item.description
                          : AppLocalizations.of(context)
                          .translate('screen.proceed'),
                      overridePrimaryColor: themeModel.getPrimaryColor(),
                      customButton: CustomRaisedButton(
                        useThemeColor: true,
                        title: AppLocalizations.of(context)
                            .translate('screen.proceed'),
                        // icon: new Icon(Icons.play_circle_outline, color: Colors.white),
                        primaryColor: themeModel.getPrimaryColor(),
                        onPressed: () {
                          giViewModel.continueToNextItem(context);
                        },
                      ),
                      giViewModel: giViewModel)),
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
