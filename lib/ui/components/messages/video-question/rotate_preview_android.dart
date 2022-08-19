import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

import 'video-question.recorder.widget.dart';

class RotateCameraPreviewAndroid extends StatefulWidget {
  final CameraPreview cameraPreview;
  final VideoRecordingStatus status;
  final NativeDeviceOrientation recordOrientation;

  const RotateCameraPreviewAndroid({
    required this.status,
    required this.cameraPreview,
    required this.recordOrientation,
    Key? key,
  }) : super(key: key);

  @override
  State<RotateCameraPreviewAndroid> createState() => _RotateCameraPreviewAndroidState();
}

class _RotateCameraPreviewAndroidState extends State<RotateCameraPreviewAndroid> {
  NativeDeviceOrientation cachedOrientation = NativeDeviceOrientation.portraitUp;

  @override
  Widget build(BuildContext context) {
      if (widget.status != VideoRecordingStatus.stopped) {
        if (widget.recordOrientation == NativeDeviceOrientation.landscapeLeft) {
          return RotatedBox(
              quarterTurns: 3, // (orientation == NativeDeviceOrientation.landscapeLeft)? 1 : 3,
              child: Container(
                //1280x720
                width: 1280,
                height: 720,
                child: widget.cameraPreview,
              ));
        } else if (widget.recordOrientation == NativeDeviceOrientation.portraitUp || widget.recordOrientation == NativeDeviceOrientation.portraitDown) {
          return Container(
            //1280x720
            width: 720,
            height: 1280,
            child: widget.cameraPreview,
          );
        } else {
          return RotatedBox(
              quarterTurns: 1,
              child: Container(
                //1280x720
                width: 1280,
                height: 720,
                child: widget.cameraPreview,
              ));
        }
      } else {
        return Container(
          width: 720,
          height: 1280,
          child: widget.cameraPreview,
        );
      }

  }
}
