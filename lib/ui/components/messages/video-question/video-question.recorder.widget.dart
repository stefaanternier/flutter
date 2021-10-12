import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youplay/models/general_item/video_question.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/buttons/camera_button.dart';
import 'package:youplay/ui/components/buttons/video_record_button.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';
import 'package:youplay/ui/pages/game_landing.page.loading.dart';

import '../message-background.widget.container.dart';
enum VideoRecordingStatus { stopped, recording }
class VideoRecorder extends StatefulWidget {
  final VideoQuestion item;
  // final Function(String, int) dispatchRecording;
  final Function(String, int) newRecording;
  const VideoRecorder({required this.item, required this.newRecording, Key? key}) : super(key: key);

  @override
  _VideoRecorderState createState() => _VideoRecorderState();
}

class _VideoRecorderState extends State<VideoRecorder> {
  CameraController? controller;
  List<CameraDescription> cameras = [];
  CameraLensDirection _direction = CameraLensDirection.back;
  VideoRecordingStatus status = VideoRecordingStatus.stopped;

  @override
  void initState() {
    // Fetch the available cameras before initializing the app.
    _loadCameras().then((cameras) {
      setState(() {
        this.cameras = cameras;
        print("cameras loaded ${this.cameras.length}");
      });
      _initializeCamera();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (cameras.isEmpty) {
      return GameLandingLoadingPage(init: () {}, text: "Even wachten, we laden de camera's...");
    }
    if (controller == null) {
      return GameLandingLoadingPage(init: () {}, text: "Even wachten, we laden de video...");
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ThemedAppbarContainer(title: widget.item.title, elevation: false),
      body: MessageBackgroundWidgetContainer(
          // item: widget.giViewModel.item!,
          // giViewModel: widget.giViewModel,
          // padding: false,
          // elevation: false,
          child: Stack(
        children: [
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.7),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // SingleChildScrollView(
                //   scrollDirection: Axis.vertical,
                //   child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RichTextTopContainer(),

                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipRect(
                        child: OverflowBox(
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: (controller == null)
                                ? Container()
                                : Container( //1280x720
                               width: 720,
                              height: 1280,
                              child: CameraPreview(
                                  controller!), // this is my CameraPreview
                            ),
                          ),
                        ),
                      ),
                    ),

                    VideoRecordButton(
                      isRecording: status == VideoRecordingStatus.stopped,
                      tapRecord: () {
                        setState(() {
                          status = VideoRecordingStatus.recording;
                        });
                        startRecording();
                      },
                      tapStop: () {
                        setState(() {
                          status = VideoRecordingStatus.stopped;
                        });
                        stopVideoRecording();
                      },
                    ),
                  ],
                ),
                // ),
              ],
            ),
          ),


          // Positioned(
          //     left: 0,
          //     right: 0,
          //     bottom: 30,
          //     child:
          //         Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: <Widget>[
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Padding(
          //             padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
          //             child: CameraButton(onTap: () => startRecording()),
          //           ),
          //         ],
          //       )
          //     ]))
        ],
      )),
    );
  }

  void startRecording() {
    if (controller == null) {
      return null;
    }
    if (!(controller!.value.isInitialized)) {
      return null;
    }
    if (controller!.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return null;
    }

    try {
      // videoPath = filePath;

      //await controller.startVideoRecording(filePath);
      controller!.startVideoRecording();
    } on CameraException catch (e) {
    print(e);
    //_showCameraException(e);
    return null;
    }

  }

  Future<void> stopVideoRecording() async {
    if (controller == null) {
      return null;
    }
    if (!controller!.value.isRecordingVideo) {
      return null;
    }

    try {
      XFile result = await controller!.stopVideoRecording();
      print('path is ${result.path}');

      // setState(() {
      //   this.videoPath = result.path;
      // });

      VideoPlayerController vpc = VideoPlayerController.file(File(result.path));
      await vpc.initialize();
      widget.newRecording(result.path, vpc.value.duration.inMilliseconds);
    } on CameraException catch (e) {
      // _showCameraException(e);
      return null;
    }
  }



  void _initializeCamera() async {
    CameraDescription? cameraDesc = await getCamera(_direction);
    if (cameraDesc == null) {
      return;
    }
    controller = CameraController(cameraDesc, ResolutionPreset.high, enableAudio: true);
    print('controller is init');
    await controller!.initialize().then((_) {
      setState(() {});
    });
  }

  CameraDescription? getCamera(CameraLensDirection dir) {
    if (cameras.length == 0) return null;
    return cameras.firstWhere((CameraDescription? camera) {
      return camera?.lensDirection == dir;
    }, orElse: null);
  }

  Future<List<CameraDescription>> _loadCameras() async {
    // Fetch the available cameras before initializing the app.
    try {
      if (cameras.isEmpty) return await availableCameras();
    } on CameraException catch (e) {
//      logError(e.code, e.description);
    }
    return [];
  }
}
