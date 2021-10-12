import 'package:flutter/material.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:youplay/models/general_item/video_question.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/screens/general_item/util/messages/components/content_card.text.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_app_bar.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/messages/video-question/video-question.list.widget.dart';
import 'package:youplay/ui/components/messages/video-question/video-question.play.widget.dart';
import 'package:youplay/ui/components/messages/video-question/video-question.recorder.widget.dart';
import 'package:youplay/ui/components/next_button/next_button.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

enum VideoQuestionStatus { list, record, play }

class VideoQuestionWidget extends StatefulWidget {
  final VideoQuestion item;
  final Function(String, int) newRecording;
  final Function(Response) deleteVideo;

  VideoQuestionWidget({required this.item, required this.newRecording, required this.deleteVideo, Key? key})
      : super(key: key);

  @override
  _VideoQuestionWidgetState createState() => _VideoQuestionWidgetState();
}

class _VideoQuestionWidgetState extends State<VideoQuestionWidget> {
  VideoQuestionStatus status = VideoQuestionStatus.list;
  Response? currentResponse;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case VideoQuestionStatus.list:
        {
          return VideoQuestionList(
            item: widget.item,
            tapProvideAnswer: () {
              setState(() {
                status = VideoQuestionStatus.record;
              });
            },
            tapRecording: (Response resp) {
              setState(() {
                currentResponse = resp;
                status = VideoQuestionStatus.play;
              });
            },
          );
        }
      case VideoQuestionStatus.play:
        {
          return VideoQuestionPlayWidget(
            response: currentResponse!,
            item: widget.item,
            back: () {
              setState(() {
                status = VideoQuestionStatus.list;
              });
            },
            onDelete: () {
              setState(() {
                status = VideoQuestionStatus.list;
              });
              widget.deleteVideo(currentResponse!);
            },
          );
        }
      case VideoQuestionStatus.record:
        {
          return VideoRecorder(
              item: widget.item,
              newRecording: (String rec, int duration) {
                setState(() {
                  status = VideoQuestionStatus.list;
                });
                widget.newRecording(rec, duration);
              });
        }
    }
  }
}
