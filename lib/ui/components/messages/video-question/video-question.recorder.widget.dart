import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:video_compress/video_compress.dart';
import 'package:youplay/models/general_item/video_question.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/buttons/video_record_button.dart';
import 'package:youplay/ui/components/messages/video-question/rotate_preview_android.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';
import 'package:youplay/ui/pages/game_landing.page.loading.dart';

import '../message-background.widget.container.dart';
import 'rotate_preview.dart';

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
  bool encoding = false;
  CameraController? controller;
  List<CameraDescription> cameras = [];
  CameraLensDirection _direction = CameraLensDirection.back;
  int cameraIndex = 0;
  VideoRecordingStatus status = VideoRecordingStatus.stopped;
  NativeDeviceOrientation recordOrientation = NativeDeviceOrientation.portraitUp;

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
    if (encoding) {
      return GameLandingLoadingPage(init: () {}, text: "Even wachten, we converteren de video...");
    }
    if (cameras.isEmpty) {
      return GameLandingLoadingPage(init: () {}, text: "Even wachten, we laden de camera's...");
    }
    if (controller == null) {
      return GameLandingLoadingPage(init: () {},
          backgroundColor: Colors.black,
          text: "Even wachten, we laden de video...");
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ThemedAppbarContainer(title: widget.item.title, elevation: false, actions: [
        if (cameras.length > 1)
          new IconButton(
            icon: new Icon(
              Icons.flip_camera_ios,
              color: Colors.white,
            ),
            onPressed: () async {
              if (controller != null) {
                await controller!.dispose();
              }
              setState(() {
                cameraIndex += 1;
                cameraIndex = cameraIndex % cameras.length;

                controller = CameraController(
                  this.cameras[cameraIndex],
                  ResolutionPreset.high,
                );
                controller!.initialize().then((_) {
                  setState(() {});
                });
              });
            },
          ),
      ],),
      body: MessageBackgroundWidgetContainer(
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 0.7),
          child: Column(
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
                            : UniversalPlatform.isAndroid
                                ? RotateCameraPreviewAndroid(
                                    status: status,
                                    cameraPreview: CameraPreview(controller!),
                                    recordOrientation: recordOrientation,
                                  )
                                : RotateCameraPreviewIos(
                                    status: status,
                                    cameraPreview: CameraPreview(controller!),
                                  )),
                  ),
                ),
              ),
              Expanded(
                child: VideoRecordButton(
                  isRecording: status == VideoRecordingStatus.stopped,
                  tapRecord: () async {
                    NativeDeviceOrientation orientation =
                        await NativeDeviceOrientationCommunicator().orientation(useSensor: true);
                    setState(() {
                      status = VideoRecordingStatus.recording;
                      recordOrientation = orientation;
                    });
                    startRecording(orientation);
                  },
                  tapStop: () {
                    setState(() {
                      status = VideoRecordingStatus.stopped;
                    });
                    stopVideoRecording();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startRecording(NativeDeviceOrientation orientation) async {
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
      if (orientation == NativeDeviceOrientation.landscapeLeft) {
        await controller!.lockCaptureOrientation(DeviceOrientation.landscapeRight);
      } else if (orientation == NativeDeviceOrientation.landscapeRight) {
        await controller!.lockCaptureOrientation(DeviceOrientation.landscapeLeft);
      }

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
    setState(() {
      encoding = true;
    });
    try {
      XFile result = await controller!.stopVideoRecording();

      MediaInfo? mediaInfo = await VideoCompress.compressVideo(
        result.path,
        quality: VideoQuality.DefaultQuality,
        deleteOrigin: true, // It's false by default
      );
      if (mediaInfo != null) {
        widget.newRecording(mediaInfo.path!, mediaInfo.duration?.toInt() ?? 0);
      }
    } on CameraException catch (e) {
      // _showCameraException(e);
      return null;
    }
    setState(() {
      encoding = false;
    });
  }

  void _initializeCamera() async {
    CameraDescription? cameraDesc = await getCamera(_direction);
    if (cameraDesc == null) {
      return;
    }
    controller =
        CameraController(cameraDesc, ResolutionPreset.high, imageFormatGroup: ImageFormatGroup.jpeg, enableAudio: true);
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
