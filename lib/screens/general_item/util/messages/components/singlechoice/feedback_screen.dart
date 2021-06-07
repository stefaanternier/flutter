import 'package:flutter/material.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_container.dart';

import '../../../../general_item.dart';
import '../themed_app_bar.dart';
import '../themed_card.dart';

class FeedbackScreen extends StatelessWidget {
  String result; //correct or wrong
  String buttonText; //correct or
  GeneralItem item;
  String feedback;
  Color overridePrimaryColor;
  Function buttonClick;
  GeneralItemViewModel giViewModel;

  FeedbackScreen(
      {this.result,
      this.buttonText,
      this.item,
      this.feedback,
      this.overridePrimaryColor,
      this.buttonClick,
      this.giViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ThemedAppBar(
          title: result == 'wrong' ? "Onjuist" : "Correct",
        ),
        body: ThemedContainer(
            imageId: result,
            item: item,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Opacity(
                    opacity: 0.9,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                        child: ThemedCard(
                            primaryColor: overridePrimaryColor,
                            buttonText: buttonText,
                            buttonClick: buttonClick,
                            feedback: feedback,
                            item: this.item,
                            giViewModel: this.giViewModel)))
              ],
            )));
  }
}
