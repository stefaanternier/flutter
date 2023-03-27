import 'package:flutter/material.dart';
import 'package:youplay/models/general_item/video_question.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/buttons/cust_flat_button.dart';
import 'package:youplay/ui/components/messages/chapter/chapter-widget.container.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/messages/video-question/video-question.list-entries.container.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';
import 'package:youplay/ui/components/next_button/next_button.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class VideoQuestionList extends StatelessWidget {
  final VideoQuestion item;
  final Function() tapProvideAnswer;
  final Function(Response) tapRecording;

  VideoQuestionList({required this.tapRecording, required this.item, required this.tapProvideAnswer, Key? key})
      : super(key: key);

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
              VideoQuestionListEntriesContainer(tapRecording: tapRecording),
              // TextQuestionListEntriesContainer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 8),
                child: NextButtonContainer(item: item),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 28),
                child: CustomFlatButton(
                    title: "Nieuwe video opname",
                    icon: Icons.videocam,
                    color: Colors.white,
                    onPressed: tapProvideAnswer),
              ),
            ],
          ),
        )));
  }
}
