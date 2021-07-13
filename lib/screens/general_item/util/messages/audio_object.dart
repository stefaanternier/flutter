import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item/audio_object.dart';
import 'package:youplay/screens/general_item/general_item.dart';

import '../../../../localizations.dart';
import 'components/next_button.dart';
import 'generic_message.dart';
class AudioObjectGeneralItemScreen extends StatefulWidget {
  AudioObjectGeneralItem item;
  GeneralItemViewModel giViewModel;

  AudioObjectGeneralItemScreen({
    required this.item,
    required this.giViewModel,
    Key? key}) : super(key: key) {
    _AudioObjectGeneralItemScreenState().updateController();
  }

  @override
  _AudioObjectGeneralItemScreenState createState() => _AudioObjectGeneralItemScreenState();
}

class _AudioObjectGeneralItemScreenState extends State<AudioObjectGeneralItemScreen> {
  // VideoPlayerController _controller;
  double _position = 0;
  double _maxposition = 10;
  bool showControls = true;
  bool isFinished = false;
  bool completeActionSent = false;

  late AudioPlayer audioPlayer;
  AudioPlayerState status = AudioPlayerState.STOPPED;

  _AudioObjectGeneralItemScreenState();

  void updateController() {}

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    AudioPlayer.logEnabled = true;
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      setState(() {
        print ('state change $s');
        this.status = s;
        if (s == AudioPlayerState.COMPLETED) {
          this._position = this._maxposition;
          this.isFinished = true;
        }
      });
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
    if (widget.item.fileReferences != null) {
      String? unencPath = widget.item.fileReferences!['audio']?.replaceFirst('//', '/')?.replaceAll(' ', '%20');
      print('https://storage.googleapis.com/${AppConfig().projectID}.appspot.com${unencPath}');
      if (unencPath != null) {
        int result = await audioPlayer
            .play('https://storage.googleapis.com/${AppConfig().projectID}.appspot.com${unencPath}');
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return GeneralItemWidget(
        item: this.widget.item,
        giViewModel: this.widget.giViewModel,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
mainAxisSize: MainAxisSize.max,
         crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child:buildVideoPlayer(context))
            ]));
  }

  Widget buildVideoPlayer(BuildContext context) {
    if (isFinished) {
      return addContinueTo( context);
    }
    return addControlsTo( context);
  }

  Widget addControlsTo( BuildContext context) {
    return Stack(
      alignment: const Alignment(0, 0.8),
      children: [
        Positioned(
            left:0,
            right:0,
            top: 0,
            bottom: 0,
            child: addPlayButtonTo( context)),
        Opacity(
            opacity: 0.9,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Slider(
                        activeColor: widget.giViewModel.getPrimaryColor(),
                        value: _position,
                        max: _maxposition,
                        onChanged: (double val) {
                          // _controller
                          //     .seekTo(Duration(milliseconds: val.floor()));
                          audioPlayer.seek(Duration(milliseconds: val.floor()));
                        },
                        onChangeEnd: (val) {})
                  ],
                ),
              ),
            )),

      ],
    );
  }

  Widget addContinueTo( BuildContext context) {
    return Stack(
      // alignment: const Alignment(0.8, 0.7),
      children: [
        // videoPlayer,
        Positioned(
            left: 46,
            right: 46,
            bottom: 46,
            child: Opacity(
              opacity: 1.0,
              child: NextButton(
                  buttonText: widget.item.description != "" ? widget.item.description : AppLocalizations.of(context).translate('screen.proceed'),
                  overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
                  giViewModel: widget.giViewModel),
            )),
      ],
    );
  }

//  Widget showContinue(Widget videoPlayer, BuildContext context) {
//    RaisedButton button = RaisedButton(
//      color: Theme
//          .of(context)
//          .accentColor,
//      splashColor: Colors.red,
//      child: Text(
//        'VERDER',
//        style: TextStyle(color: Colors.white.withOpacity(0.8)),
//      ),
//      onPressed: () {
//        widget.giViewModel.continueToNextItem();
//      },
//    );
//
//    return Stack(
//      alignment: const Alignment(0.8, 0.8),
//      children: [
//        videoPlayer,
//        Opacity(
//          opacity: 1.0,
//          child: button,
//        ),
//      ],
//    );
//  }

  Widget addPlayButtonTo( BuildContext context) {
    Icon icon = Icon(
      Icons.play_circle_filled,
      size: 75,
      color: widget.giViewModel.getPrimaryColor(),
    );
    if  (!(status == AudioPlayerState.PAUSED ||
        status == AudioPlayerState.STOPPED ||
        status == AudioPlayerState.COMPLETED))
      icon = Icon(Icons.pause_circle_filled,
          color: widget.giViewModel.getPrimaryColor(),
          size: 75);

    GestureDetector gestureDetector = GestureDetector(
      onTap: () {
        new Timer(Duration(milliseconds: 10), () {
          setState(() {
            if ((status == AudioPlayerState.STOPPED || status == AudioPlayerState.COMPLETED)) {
              play();
            } else if (status == AudioPlayerState.PLAYING) {
              audioPlayer.pause();
            } else if (status == AudioPlayerState.PAUSED) {
              audioPlayer.resume();
            }
            // if (_controller.value.isPlaying) {
            //   _controller.pause();
            // } else {
            //   _controller.play();
            //   showControls = false;
            // }
          });
        });
      },
      child: icon,
    );
return gestureDetector;
    // return Stack(
    //   alignment: const Alignment(0, 0),
    //   children: [
    //     // videoPlayer,
    //     // gestureDetector
    //     Opacity(
    //       opacity: 1.0,
    //       child: gestureDetector,
    //     ),
    //   ],
    // );
  }

  @override
  void dispose() {
    super.dispose();
    this.audioPlayer.dispose();
    // _controller.dispose();
  }
}
