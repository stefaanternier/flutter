import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/screens/general_item/util/messages/components/list_audio_player.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_app_bar.dart';

class PlayVideoWidget extends StatefulWidget {
  Response response;
  GeneralItem item;
  Function onDelete;

  PlayVideoWidget({required this.response, required this.item, required this.onDelete});

  @override
  _PlayVideoWidgetState createState() => _PlayVideoWidgetState();
}

class _PlayVideoWidgetState extends State<PlayVideoWidget> {
  late VideoPlayerController _controller;
  double _position =0;
  double _maxposition=0;
  bool isFinished = false;

  @override
  void initState() {
    super.initState();

    _controller =
        VideoPlayerController.network(
            'https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/${widget.response.value}')
          ..addListener(() {
            setState(() {
              if (_controller.value.duration != null) {
                _position = _controller.value.position.inMilliseconds.roundToDouble();
                _maxposition =
                    max(_position, _controller.value.duration.inMilliseconds.roundToDouble());
//                print('position ${_maxposition} - ${_position}');
                if (((_controller.value.duration.inMilliseconds - 1000) <=
                        _controller.value.position.inMilliseconds) &&
                    _controller.value.duration.inMilliseconds > 100) {
                  Future.delayed(
                    Duration(seconds: 1),
                    () {
                      setState(() {
                        isFinished = true;
                      });
                      _controller.pause();
                      _controller.seekTo(Duration(milliseconds: 0));
                    },
                  );
                }
              }
            });
          })
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
            _controller.seekTo(Duration(milliseconds: 0));
            print('loading complete');
            print(
                'https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/${widget.response.value}');
          });


  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//        drawer: ARLearnNavigationDrawer(),
        backgroundColor: Colors.black,
        appBar: ThemedAppBar(title: widget.item.title, elevation: true),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            (_controller != null && _controller.value.isInitialized)
                ?
                AspectRatio(
                    aspectRatio: 1,
                    child: ClipRect(
                      child: OverflowBox(
                        alignment: Alignment.center,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Container(
                            width: 200,
                            height: 200,
                            child: VideoPlayer(_controller), // this is my CameraPreview
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      "Nieuwe video",
                      style: new TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  (_position != null)
                      ? Column(
                          children: <Widget>[
                            new Slider(
                                activeColor: Colors.white,
                                value: _position,
                                max: _maxposition,
                                onChanged: (double val) {
                                  _controller.seekTo(Duration(milliseconds: val.floor()));
                                },
                                onChangeEnd: (val) {}),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // Text(
                                  //   "${format(Duration(milliseconds: _position.floor()))}",
                                  //   style: new TextStyle(
                                  //       color: Colors.white.withOpacity(0.7), fontSize: 12.0),
                                  // ),
                                  // Text(
                                  //     "-${format(Duration(milliseconds: (_maxposition - _position).floor()))}",
                                  //     style: new TextStyle(
                                  //         color: Colors.white.withOpacity(0.7), fontSize: 12.0)),
                                ],
                              ),
                            )
                          ],
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.fast_rewind,
                          size: 40,
                          color: Colors.white,
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Icon(
                              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 70,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              print('is playing ${_controller.value.isPlaying}');

                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                        ),
                        Icon(
                          Icons.fast_forward,
                          size: 40,
                          color: Colors.white,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              InkWell(
                                  child: Icon(
                                    Icons.delete,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    widget.onDelete();
                                    Navigator.pop(context);
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      "vandaag 14:33",
                      style: new TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16.0),
                    ),
                  )
                ],
              ),
            )
          ],
        )));
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }
}
