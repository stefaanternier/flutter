

import 'package:flutter/material.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/screens/general_item/util/messages/components/list_audio_player.dart';
import 'package:youplay/ui/components/messages/audio-slide-left-background.dart';

class AudioResultsList extends StatelessWidget {
  List<Response> audioResponses;
  Function(Response) dismissAudio;

  AudioResultsList({
    required this.audioResponses,
    required this.dismissAudio,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: audioResponses.length,
      itemBuilder: (context, index) {
        final DateTime thatTime =
        DateTime.fromMillisecondsSinceEpoch(
            audioResponses[index].timestamp);
        return Dismissible(
            key: Key('${audioResponses[index].timestamp}'),
            background: AudioSlideLeftBackground(),
            onDismissed: (direction) {
              this.dismissAudio(audioResponses[index]);
              // this.audioResponses = this
              //     .audioResponses
              //     .where((element) => element.responseId != audioResponses[index].responseId)
              //     .toList(growable: false);
              // setState(() {
              //   this.deleted.add(map.getItem(index));
              //   deleteResponse(map.delete(index));
              //   map.deleteAllResponses(this.deleted);
              // });
            },
            child: //Container(),
             ListAudioPlayer(response: audioResponses[index])
        );
      },
    );
  }
}
