import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:youplay/models/general_item/audio_object.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_app_bar.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/messages/audio_player/audio-player.controls.container.dart';
import 'package:youplay/ui/components/next_button/next_button.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class AudioPlayerWidget extends StatefulWidget {
  final AudioObjectGeneralItem item;
  final String? url;

  AudioPlayerWidget({required this.item, this.url, Key? key}) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer audioPlayer;
  AudioPlayerState status = AudioPlayerState.STOPPED;

  double _position = 0;
  double _maxposition = 10;
  bool isFinished = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    AudioPlayer.logEnabled = true;
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      if (!isFinished){
        setState(() {
          this.status = s;
          if (s == AudioPlayerState.COMPLETED) {
            this._position = this._maxposition;
            this.isFinished = true;
          }
        });
      }

    });

    audioPlayer.onAudioPositionChanged.listen((Duration p) async {
      int duration = await audioPlayer.getDuration();
      _maxposition = duration.toDouble();
      setState(() {
        _maxposition = duration.toDouble();
        _position = min(p.inMilliseconds.roundToDouble(), _maxposition);
      });
    });
    // this.play();
  }

  play() async {
    if (widget.url != null) {
      int result = await audioPlayer.play(widget.url!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ThemedAppBar(title: widget.item.title, elevation: true),
        body: WebWrapper(
            child: MessageBackgroundWidgetContainer(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (!isFinished)
                Expanded(
                  child: AudioPlayerControlsContainer(
                    buttonTap: () {
                      new Timer(Duration(milliseconds: 10), () {
                        setState(() {
                          if ((status == AudioPlayerState.STOPPED || status == AudioPlayerState.COMPLETED)) {
                            play();
                          } else if (status == AudioPlayerState.PLAYING) {
                            audioPlayer.pause();
                          } else if (status == AudioPlayerState.PAUSED) {
                            audioPlayer.resume();
                          }

                        });
                      });
                    },
                    seek: (double val) {
                      audioPlayer.seek(Duration(milliseconds: val.floor()));
                    },
                    position: _position,
                    maxposition: _maxposition,
                    showPlay: (status == AudioPlayerState.PAUSED ||
                        status == AudioPlayerState.STOPPED ||
                        status == AudioPlayerState.COMPLETED),
                  ),
                ),
              if (isFinished)
                Expanded(
                  child: Stack(
                    // alignment: const Alignment(0.8, 0.7),
                    children: [
                      // videoPlayer,
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(28, 30, 28, 30),
                            child: NextButtonContainer(item: widget.item),
                          )),
                    ],
                  ),
                )
            ],
          ),
        )));
  }

  @override
  void dispose() {
    this.audioPlayer.dispose();
    super.dispose();
  }
}
