import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

import 'video-question.recorder.widget.dart';

class RotateCameraPreviewIos extends StatefulWidget {
  final CameraPreview cameraPreview;
  final VideoRecordingStatus status;

  const RotateCameraPreviewIos({
    required this.status,
    required this.cameraPreview,
    Key? key,
  }) : super(key: key);

  @override
  State<RotateCameraPreviewIos> createState() => _RotateCameraPreviewIosState();
}

class _RotateCameraPreviewIosState extends State<RotateCameraPreviewIos> {
  NativeDeviceOrientation cachedOrientation = NativeDeviceOrientation.portraitUp;

  @override
  Widget build(BuildContext context) {
    return NativeDeviceOrientationReader(
      useSensor: true,
      builder: (context) {
        final orientation = NativeDeviceOrientationReader.orientation(context);
        if (orientation != cachedOrientation && widget.status == VideoRecordingStatus.stopped) {
          Future.delayed(const Duration(milliseconds: 200), () {
            setState(() {
              cachedOrientation = orientation;
            });
          });
        }
        if (cachedOrientation == NativeDeviceOrientation.landscapeLeft ||
            cachedOrientation == NativeDeviceOrientation.landscapeRight) {
          return RotatedBox(
              quarterTurns: (cachedOrientation == NativeDeviceOrientation.landscapeLeft) ? 1 : 3,
              child: Container(
                //1280x720
                width: 1280,
                height: 720,
                child: widget.cameraPreview, // this is my CameraPreview
              ));
        } else {
          return Container(
            //1280x720
            width: 720,
            height: 1280,
            child: widget.cameraPreview, // this is my CameraPreview
          );
        }
      },
    );
  }
}
