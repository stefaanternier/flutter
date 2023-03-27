import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:youplay/models/general_item/audio_object.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/messages/audio_player/audio-player.controls.container.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/next_button/next_button.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../messages/chapter/chapter-widget.container.dart';

class AudioPlayerWidget extends StatefulWidget {
  final AudioObjectGeneralItem item;
  final String? url;

  AudioPlayerWidget({required this.item, this.url, Key? key}) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer audioPlayer;
  PlayerState status = PlayerState.stopped;
  bool showControls = true;
  double _position = 0;
  double _maxposition = 10;
  bool isFinished = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        this._position = this._maxposition;
        this.isFinished = true;
      });
    });

    audioPlayer.onPositionChanged.listen((Duration p) async {
      Duration? duration = await audioPlayer.getDuration();
      _maxposition = (duration?.inMilliseconds ?? 0).toDouble();
      setState(() {
        _position = p.inMilliseconds.roundToDouble();
        _maxposition = (duration?.inMilliseconds ?? 0).toDouble();
      });
    });
    AudioPlayer.global.changeLogLevel(LogLevel.error);

    // this.play();
  }

  play() async {
    if (widget.url != null) {
      await audioPlayer.play(UrlSource(widget.url!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ThemedAppbarContainer(title: widget.item.title, elevation: true),
        body: WebWrapper(
            child: ChapterWidgetContainer(
                child: GestureDetector(
          onTap: () {
            setState(() {
              showControls = !showControls;
            });
          },
          child: MessageBackgroundWidgetContainer(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (!isFinished)
                  Expanded(
                    child: !showControls
                        ? Container()
                        : AudioPlayerControlsContainer(
                            buttonTap: () {
                              new Timer(Duration(milliseconds: 10), () {
                                setState(() {
                                  if ((status == PlayerState.stopped || status == PlayerState.completed)) {
                                    play();
                                    status = PlayerState.playing;
                                  } else if (status == PlayerState.playing) {
                                    audioPlayer.pause();
                                    status = PlayerState.paused;
                                  } else if (status == PlayerState.paused) {
                                    audioPlayer.resume();
                                    status = PlayerState.playing;
                                  }
                                });
                              });
                            },
                            seek: (double val) {
                              audioPlayer.seek(Duration(milliseconds: val.floor()));
                            },
                            position: _position,
                            maxposition: _maxposition,
                            showPlay: (status == PlayerState.paused ||
                                status == PlayerState.stopped ||
                                status == PlayerState.completed),
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
          ),
        ))));
  }

  @override
  void dispose() {
    this.audioPlayer.dispose();
    super.dispose();
  }
}
