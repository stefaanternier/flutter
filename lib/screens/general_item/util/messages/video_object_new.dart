import 'dart:async';
import 'dart:math';

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoObjectNew extends StatefulWidget {
  Color color;
  Function onFinishedPlaying;
  Widget showOnFinish;
  String url;

  VideoObjectNew({
    required this.color,
    required this.onFinishedPlaying,
    required this.url,
    required this.showOnFinish, Key? key}): super(key: key) ;

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoObjectNew> {
  VideoPlayerController? _controller;
  bool showControls = true;
  double _position = 0;
  double _maxposition = 0;

  bool isFinished = false;

  @override
  void initState() {
    super.initState();
    var time = DateTime.now().millisecondsSinceEpoch;
    print('init ${time}');

    _controller = VideoPlayerController.network(
        widget.url)
      ..addListener(() {
        setState(() {
          if (_controller!.value.duration != null) {
            _position =
                _controller!.value.position.inMilliseconds.roundToDouble();
            _maxposition = max(_position,
                _controller!.value.duration.inMilliseconds.roundToDouble());

            if (((_controller!.value.duration.inMilliseconds - 1000) <=
                _controller!.value.position.inMilliseconds) &&
                _controller!.value.duration.inMilliseconds > 100) {
              if (!isFinished) {
                widget.onFinishedPlaying();
              }
              isFinished = true;
            }
          }

        });
      })
      ..initialize().then((_) {
        setState(() {
          _controller!.seekTo(new Duration(milliseconds: 50));
        });

      });
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context);
    return Container(
      child: _controller?.value.isInitialized??false
          ? Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                  width: screensize.size.width,
                  height: screensize.size.width /
                      _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!)),
            ),
          ),
          GestureDetector(
              onTap: () {
                print('tap gesture');
                setState(() {
                  showControls = !showControls;
                });
              },
              child: new Container(color: Colors.transparent)),
          Visibility(
            visible: showControls && !isFinished,
            child: Positioned.fill(
                child: Opacity(
                  opacity: 1.0,
                  child: GestureDetector(
                    onTap: () {
                      new Timer(Duration(milliseconds: 10), () {
                        setState(() {
                          if (_controller!.value.isPlaying) {
                            _controller!.pause();
                          } else {
                            _controller!.play();
                            showControls = false;
                          }
                        });
                      });
                    },
                    child: Icon(
                        _controller?.value.isPlaying ?? false
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                        color: this.widget.color,
                        size: 75),
                  ),
                )),
          ),
          Visibility(
            visible: showControls && !isFinished,
            child: Positioned(
                bottom: 50,
                left: 50,
                right: 50,
                child: Opacity(
                  opacity: 0.9,
                  // child: Padding(
                  // padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Slider(
                            activeColor: widget.color,
                            value: _position,
                            max: _maxposition,
                            onChanged: (double val) {
                              _controller!.seekTo(
                                  Duration(milliseconds: val.floor()));
                            },
                            onChangeEnd: (val) {})
                      ],
                    ),
                  ),
                )),
          ),
          Visibility(
            visible: isFinished,
            child: Positioned(
                left: 46,
                right: 46,
                bottom: 46,
                child: Opacity(
                  opacity: 1.0,
                  child: widget.showOnFinish,
                )),
          )
        ],
      )
          : Container(),

    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}
