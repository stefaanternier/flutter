import 'package:flutter/material.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/cards/feedback_themed_card.container.dart';
import 'package:youplay/ui/components/messages/feedback-screen/themed_container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class FeedbackScreen extends StatelessWidget {
  final String result; //correct or wrong
  final String buttonText; //correct or
  final GeneralItem item;
  final String feedback;
  final Color? overridePrimaryColor;
  final Function() buttonClick;

  FeedbackScreen({
    required this.result,
    required this.buttonText,
    required this.item,
    required this.feedback,
    this.overridePrimaryColor,
    required this.buttonClick,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ThemedAppbarContainer(
          title: result == 'wrong' ? "Onjuist" : "Juist",
        ),
        body: WebWrapper(
            child: ThemedContainer(
                feedbackKind: result,
                item: item,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Opacity(
                        opacity: 0.9,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                            child: FeedbackThemedCardContainer(
                              buttonText: buttonText,
                              buttonClick: buttonClick,
                              feedback: feedback,
                              item: this.item,
                            )))
                  ],
                ))));
  }
}
