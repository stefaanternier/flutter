import 'package:flutter/material.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_container.dart';
import 'package:youplay/ui/components/cards/feedback_themed_card.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';
import '../themed_app_bar.dart';

class FeedbackScreen extends StatelessWidget {
  String result; //correct or wrong
  String buttonText; //correct or
  GeneralItem item;
  String feedback;
  Color? overridePrimaryColor;
  Function() buttonClick;
  // GeneralItemViewModel? giViewModel;

  FeedbackScreen(
      {required this.result,
      required this.buttonText,
      required this.item,
      required this.feedback,
      this.overridePrimaryColor,
      required this.buttonClick,
      // this.giViewModel
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ThemedAppBar(
          title: result == 'wrong' ? "Onjuist" : "Juist",
        ),
        body: WebWrapper(
            child: ThemedContainer(
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
                            child:
                            FeedbackThemedCardContainer(
                                buttonText: buttonText,
                                buttonClick: buttonClick,
                                feedback: feedback,
                                item: this.item,
                            )
                        ))
                  ],
                ))));
  }
}
