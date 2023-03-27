import 'package:flutter/material.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/ui/components/messages/audio-slide-left-background.dart';

import 'list_audio_player.dart';

class AudioResultsList extends StatelessWidget {
  final List<Response> audioResponses;
  final Function(Response) dismissAudio;

  AudioResultsList({
    required this.audioResponses,
    required this.dismissAudio,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: ListView.builder(
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
              },
              child: //Container(),
               ListAudioPlayer(response: audioResponses[index])
          );
        },
      ),
    );
  }
}
