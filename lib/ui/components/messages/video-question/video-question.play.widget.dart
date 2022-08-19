import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item/video_question.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../message-background.widget.container.dart';

class VideoQuestionPlayWidget extends StatefulWidget {
  final VideoQuestion item;
  final Function() back;
  final Response response;
  final Function() onDelete;

  const VideoQuestionPlayWidget(
      {required this.back, required this.response, required this.item, required this.onDelete, Key? key})
      : super(key: key);

  @override
  _VideoQuestionPlayWidgetState createState() => _VideoQuestionPlayWidgetState();
}

class _VideoQuestionPlayWidgetState extends State<VideoQuestionPlayWidget> {
  late VideoPlayerController _controller;
  double _position = 0;
  double _maxPosition = 0;
  bool isFinished = false;
  bool stopListening = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
        'https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/${widget.response.value}')
      ..addListener(() {
        if (stopListening) return;
        setState(() {
          if (_controller.value.duration != null) {
            _position = _controller.value.position.inMilliseconds.roundToDouble();
            _maxPosition = max(_position, _controller.value.duration.inMilliseconds.roundToDouble());
            if (((_controller.value.duration.inMilliseconds - 1000) <= _controller.value.position.inMilliseconds) &&
                _controller.value.duration.inMilliseconds > 100) {
              Future.delayed(
                Duration(seconds: 1),
                () {
                  if (stopListening) return;
                  setState(() {
                    isFinished = true;
                  });
                  print('controller ${_controller.value.size.width < _controller.value.size.height}');
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
        if (stopListening) return;
        setState(() {});
        _controller.seekTo(Duration(milliseconds: 0));
      });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        setState(() {
          stopListening = true;
        });
        widget.back();
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: ThemedAppbarContainer(title: widget.item.title, elevation: true),
          body: WebWrapper(
              child: MessageBackgroundWidgetContainer(
            darken: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                (_controller != null && _controller.value.isInitialized)
                    ? AspectRatio(
                        aspectRatio: 1,
                        child: ClipRect(
                          child: OverflowBox(
                            alignment: Alignment.center,
                            child:

                            FittedBox(
                              fit: (_controller.value.size.width < _controller.value.size.height) ? BoxFit.fitWidth : BoxFit.fitHeight,
                              child: Container(
                                width: _controller.value.size.width, // < _controller.value.size.height ? 720 : 1280,
                                height: _controller.value.size.height, // < _controller.value.size.height ? 1280,
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
                                    max: _maxPosition,
                                    onChanged: (double val) {
                                      _controller.seekTo(Duration(milliseconds: val.floor()));
                                    },
                                    onChangeEnd: (val) {}),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[],
                                  ),
                                )
                              ],
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Icon(
                                  Icons.fast_rewind,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _controller.seekTo(Duration(milliseconds: max((_position.floor() - 5000), 0) ));
                                  // _controller.value.isPlaying ? _controller.pause() : _controller.play();
                                });
                              },
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

                                  _controller.value.isPlaying ? _controller.pause() : _controller.play();
                                });
                              },
                            ),
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Icon(
                                  Icons.fast_forward,
                                  size: 40,
                                  color: Colors.white,

                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _controller.seekTo(Duration(milliseconds: min((_position.floor() + 5000), _maxPosition.floor()) ));
                                  // _controller.value.isPlaying ? _controller.pause() : _controller.play();
                                });
                              },
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
                                      onTap: widget.onDelete)
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
            ),
          ))),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
