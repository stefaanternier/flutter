import 'package:flutter/material.dart';
import 'package:youplay/models/general_item/audio_question.dart';
import 'package:youplay/ui/components/messages/audio-question/audio-list-recordings.dart';

import '../messages/audio_recorder/audio-question.recorder.widget.dart';

enum AudioRecordingStatus { stopped, recording }

class AudioQuestionWidget extends StatefulWidget {
  final AudioQuestion item;
  final Function(String, int) dispatchRecording;

  AudioQuestionWidget({required this.item,
    required this.dispatchRecording,
    Key? key}) : super(key: key);

  @override
  _AudioQuestionWidgetState createState() => _AudioQuestionWidgetState();
}

class _AudioQuestionWidgetState extends State<AudioQuestionWidget> {
  AudioRecordingStatus status = AudioRecordingStatus.stopped;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case AudioRecordingStatus.stopped:
        {
          return AudioListRecordings(
            pressRecord: () {
              setState(() {
                status = AudioRecordingStatus.recording;
              });
            },
            item: widget.item,
          );
        }
      case AudioRecordingStatus.recording:
        {
          return AudioRecorder(
            item: widget.item,
            dispatchRecording: (String rec, int duration) {
              setState(() {
                status = AudioRecordingStatus.stopped;
              });
              widget.dispatchRecording(rec, duration);

            },
          );
        }

    }
  }
}
