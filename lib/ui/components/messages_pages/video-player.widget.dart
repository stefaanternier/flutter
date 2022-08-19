import 'dart:math';

import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:video_player/video_player.dart';
import 'package:youplay/models/general_item/video_object.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/messages/video_player/video-player.button.container.dart';
import 'package:youplay/ui/components/messages/video_player/video-player.controls.container.dart';
import 'package:youplay/ui/components/next_button/next_button.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';
import 'package:youplay/ui/pages/game_landing.page.loading.dart';

import '../messages/themed_loading_page.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoObjectGeneralItem item;
  Function() onFinishedPlaying;

  // Widget showOnFinish;
  String? url;

  VideoPlayerWidget(
      {required this.item,
      required this.onFinishedPlaying,
      required this.url,
      // required this.showOnFinish,
      Key? key})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> with AutomaticKeepAliveClientMixin {

  @override
  final wantKeepAlive = true;

  VideoPlayerController? _controller;
  bool showControls = true;
  double _position = 0;
  double _maxposition = 0;
  bool isFinished = false;

  @override
  void initState() {
    super.initState();
    var time = DateTime.now().millisecondsSinceEpoch;
    print('init ${time} ${widget.url}');
    if (widget.url == null) {
      return;
    }
    _controller = VideoPlayerController.network(widget.url!)
      ..addListener(() {
        setState(() {
          if (_controller!.value.duration != null) {
            _position = _controller!.value.position.inMilliseconds.roundToDouble();
            _maxposition = max(_position, _controller!.value.duration.inMilliseconds.roundToDouble());

            if (((_controller!.value.duration.inMilliseconds - 1000) <= _controller!.value.position.inMilliseconds) &&
                _controller!.value.duration.inMilliseconds > 100) {
              // print('should execute finished playing ${isFinished}');
              if (!isFinished) {
                // print('execute finished playing');
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
          if (!UniversalPlatform.isWeb && widget.item.autoPlay) {
            _controller!.play();
            showControls = false;
          }

        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var screensize = MediaQuery.of(context);
    if (widget.url == null) {
      return ThemedLoadingMessage(title: widget.item.title, message: "Video ontbreekt, gebruik de auteursomgeving om een video te koppelen");
      // return GameLandingLoadingPage(init: () {}, text: "Video ontbreekt, gebruik de auteursomgeving om een video te koppelen");
    }
    if (!(_controller?.value.isInitialized ?? false)) {
      return ThemedLoadingMessage(title: widget.item.title, message: "Even wachten, we laden de video...");
      // return GameLandingLoadingPage(init: () {}, text: "Even wachten, we laden de video...");
    }

    //videoPlayerController.value.size?.height
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ThemedAppbarContainer(title: widget.item.title, elevation: true),
        body: WebWrapper(
            child: MessageBackgroundWidgetContainer(
              darken: true,
          child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child:
                      FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                            width: screensize.size.width,
                            height: screensize.size.width / _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!)),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            showControls = !showControls;
                          });
                        },
                        child: new Container(color: Colors.transparent)),
                    Visibility(
                      visible: showControls && !isFinished,
                      child: VideoPlayerButtonContainer(
                        play: _controller?.value.isPlaying ?? false,
                        tap: () {
                          setState(() {
                            if (_controller!.value.isPlaying) {
                              _controller!.pause();
                            } else {
                              _controller!.play();
                              showControls = false;
                            }
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: showControls && !isFinished,
                      child: VideoPlayerControlsContainer(
                        seek: (double val) {
                          _controller!.seekTo(Duration(milliseconds: val.floor()));
                        },
                        maxPosition: _maxposition,
                        position: _position,
                      ),
                    ),
                    Visibility(
                      visible: isFinished,
                      child: Positioned(
                          left: 46,
                          right: 46,
                          bottom: 46,
                          child: Opacity(
                            opacity: 1.0,
                            child: NextButtonContainer(item: widget.item),
                          )),
                    )
                  ],
                )

        )));
  }
}
