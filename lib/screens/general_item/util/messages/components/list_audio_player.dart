import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/response.dart';
//enum AudioPlayingStatus { stopped, paused, playing }
format(Duration d) => d.inHours < 1
    ? d.toString().split('.').first.substring(2)
    : d.toString().split('.').first.padLeft(8, "0");

class ListAudioPlayer extends StatefulWidget {
  Response response;

  ListAudioPlayer({this.response});

  @override
  _PlayerState createState() => new _PlayerState();
}

class _PlayerState extends State<ListAudioPlayer> {
  double _position = 0;
  double _maxposition = 100;
  AudioPlayer audioPlayer;
  AudioPlayerState status = AudioPlayerState.STOPPED;

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    AudioPlayer.logEnabled = false;
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      setState(() {
        this.status = s;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration p) async {
      int duration = await audioPlayer.getDuration();
      _maxposition = duration.toDouble();
      setState(() {
        _position = p.inMilliseconds.roundToDouble();
        _maxposition = duration.toDouble();
      });
    });
  }

  play() async {
    int result = await audioPlayer.play(
        'https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/${widget.response.value}');
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter =
    new DateFormat('MMMM d, y – kk:mm');
    // DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
    final DateTime thatTime =
    DateTime.fromMillisecondsSinceEpoch(widget.response.timestamp);
    return new ExpansionTile(
      title: Text('Nieuwe opname', style: TextStyle(color: Colors.white)),
      subtitle: Text('${formatter.format(thatTime)} ',
          style: TextStyle(color: Colors.white.withOpacity(0.7))),
      trailing:
      Text( _maxposition ==100 ?"-":"${format(Duration(milliseconds: (_maxposition).floor()))}", style: TextStyle(color: Colors.white.withOpacity(0.7))),
      children: <Widget>[
        new Column(
          children: [
//        new Text("status $status"),
            SliderTheme(
                data: SliderThemeData(
                    inactiveTrackColor: Colors.white.withOpacity(0.3),
                    thumbColor: Colors.white, thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7)),
                child: Slider(
                    activeColor: Colors.white,
                    value: _position,
                    max: _maxposition,
                    onChanged: (double val) {
                      audioPlayer.seek(Duration(milliseconds: val.floor()));
                    },
                    onChangeEnd: (val) {})),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${format(Duration(milliseconds: _position.floor()))}",
                    style: new TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12.0),
                  ),
                  Text(
                    "-${format(Duration(milliseconds: (_maxposition - _position).floor()))}",
                    style: new TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12.0),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new IconButton(
                  icon: new Icon(
                    Icons.fast_rewind,
                    color: Colors.white,
                    size: 50,
                  ),
                  onPressed: () {
                    audioPlayer.seek(Duration(milliseconds: max(0, (_position.floor() - 5000))));
                  },
                ),
                new IconButton(
                  icon: new Icon(
                    (status == AudioPlayerState.PAUSED ||
                        status == AudioPlayerState.STOPPED ||
                        status == AudioPlayerState.COMPLETED)
                        ? Icons.play_arrow
                        : Icons.pause,
                    color: Colors.white,
                    size: 50,
                  ),
                  onPressed: () {
                    if ((status == AudioPlayerState.STOPPED || status == AudioPlayerState.COMPLETED)) {
                      play();
                    } else if (status == AudioPlayerState.PLAYING) {
                      audioPlayer.pause();
                    } else if (status == AudioPlayerState.PAUSED) {
                      audioPlayer.resume();
                    }
                  },
                ),
                new IconButton(
                  icon: new Icon(
                    Icons.fast_forward,
                    color: Colors.white,
                    size: 50,
                  ),
                  onPressed: () {
                    if (status != AudioPlayerState.COMPLETED) {
                      audioPlayer.seek(Duration(
                          milliseconds: min(_maxposition.floor(), (_position.floor() + 5000))));
                    }
                  },
                ),
              ],
            )
          ],
        )
      ],
    );

     //;
  }
}
