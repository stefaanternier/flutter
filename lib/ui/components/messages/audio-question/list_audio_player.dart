import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/response.dart';

format(Duration d) => d.inHours < 1
    ? d.toString().split('.').first.substring(2)
    : d.toString().split('.').first.padLeft(8, "0");

class ListAudioPlayer extends StatefulWidget {
  Response response;

  ListAudioPlayer({required this.response});

  @override
  _PlayerState createState() => new _PlayerState();
}

class _PlayerState extends State<ListAudioPlayer> {
  double _position = 0;
  double _maxposition = 100;
  late AudioPlayer audioPlayer;
  PlayerState status = PlayerState.stopped;

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    // AudioPlayer.logEnabled = false;
    audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      setState(() {
        this.status = s;
      });
    });
    audioPlayer.onPositionChanged.listen((Duration p) async {
      Duration? duration = await audioPlayer.getDuration() ;
      _maxposition = (duration?.inMilliseconds ?? 0).toDouble();
      setState(() {
        _position = p.inMilliseconds.roundToDouble();
        _maxposition = (duration?.inMilliseconds ?? 0).toDouble();
      });
    });
  }

  play() async {

    await audioPlayer.play(UrlSource('https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/${widget.response.value}'));
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter =
    new DateFormat('MMMM d, y – kk:mm');
    // DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
    final DateTime thatTime =
    DateTime.fromMillisecondsSinceEpoch(widget.response.timestamp);
    print('pos $_position  max $_maxposition');
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
                    value: min(_position, _maxposition),
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
                    (status == PlayerState.paused ||
                        status == PlayerState.stopped ||
                        status == PlayerState.completed)
                        ? Icons.play_arrow
                        : Icons.pause,
                    color: Colors.white,
                    size: 50,
                  ),
                  onPressed: () {
                    if ((status == PlayerState.stopped || status == PlayerState.completed)) {
                      play();
                    } else if (status == PlayerState.playing) {
                      audioPlayer.pause();
                    } else if (status == PlayerState.paused) {
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
                    if (status != PlayerState.completed) {
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
