import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youplay/models/general_item/text_question.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/buttons/cust_flat_button.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/messages/text_question/text-question.list-entries.container.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';
import 'package:youplay/ui/components/next_button/next_button.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../chapter/chapter-widget.container.dart';

class TextQuestionList extends StatelessWidget {
  final TextQuestion item;
  final Function() tapProvideAnswer;

  TextQuestionList({required this.item, required this.tapProvideAnswer, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ThemedAppbarContainer(title: item.title, elevation: false),
        body: WebWrapper(
            child: MessageBackgroundWidgetContainer(
          darken: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RichTextTopContainer(),
              TextQuestionListEntriesContainer(item: item),
              Padding(
                padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 8),
                child: NextButtonContainer(item: item),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 28),
                child: CustomFlatButton(
                    title: "Nieuwe tekst", //todo vertaal
                    icon: FontAwesomeIcons.pen,
                    color: Colors.white,
                    onPressed: tapProvideAnswer),
              ),
            ],
          ),
        )));
  }
}
