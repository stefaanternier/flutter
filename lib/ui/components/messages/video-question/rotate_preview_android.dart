import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

import 'video-question.recorder.widget.dart';

class RotateCameraPreviewAndroid extends StatefulWidget {
  final CameraPreview cameraPreview;
  final VideoRecordingStatus status;
  final NativeDeviceOrientation recordOrientation;
  final int sensorOrientation;

  const RotateCameraPreviewAndroid({
    required this.status,
    required this.cameraPreview,
    required this.recordOrientation,
    required this.sensorOrientation,
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

          if (widget.sensorOrientation == 0) {
            return RotatedBox(
                quarterTurns: 3,
                child: Container(
                  width: 720,
                  height: 1280,
                  child: widget.cameraPreview,
                ));
          }

          return RotatedBox(
              quarterTurns: 1, // (orientation == NativeDeviceOrientation.landscapeLeft)? 1 : 3,
              child: Container(
                //1280x720
                width: 1280,
                height: 720,
                child: widget.cameraPreview,
              ));
        } else if (widget.recordOrientation == NativeDeviceOrientation.portraitUp || widget.recordOrientation == NativeDeviceOrientation.portraitDown) {
          if (widget.sensorOrientation == 0) { //chromebook
            return NativeDeviceOrientationReader(
                useSensor: true,
                builder: (context) {
                  final orientation = NativeDeviceOrientationReader.orientation(context);
                  if (orientation == NativeDeviceOrientation.landscapeLeft || orientation == NativeDeviceOrientation.landscapeRight) {
                    return RotatedBox(
                        quarterTurns: 2,
                        child:  Container(
                          width: 1280,
                          height: 720,
                          child: widget.cameraPreview,
                        ));
                  }
                  return Container(
                    width: 1280,
                    height: 720,
                    child: widget.cameraPreview,
                  );
                }
            );

          }
          return Container(
            //1280x720
            width: 720,
            height: 1280,
            child: widget.cameraPreview,
          );

        } else {
          if (widget.sensorOrientation == 0) {
            return RotatedBox(
                quarterTurns: 1,
                child: Container(
                  //1280x720
                  width: 720,
                  height: 1280,
                  child: widget.cameraPreview,
                ));

          }
          return RotatedBox(
              quarterTurns: 3,
              child: Container(
                //1280x720
                width: 1280,
                height: 720,
                child: widget.cameraPreview,
              ));
        }
      } else {
        if (widget.sensorOrientation == 0 ) {

          return NativeDeviceOrientationReader(
            useSensor: true,
            builder: (context) {
              final orientation = NativeDeviceOrientationReader.orientation(context);
              if (orientation == NativeDeviceOrientation.landscapeLeft || orientation == NativeDeviceOrientation.landscapeRight) {
                return RotatedBox(
                  quarterTurns: 2,
                  child:  Container(
                    width: 1280,
                    height: 720,
                    child: widget.cameraPreview,
                  ));
              }
              return Container(
                width: 1280,
                height: 720,
                child: widget.cameraPreview,
              );
            }
          );

        }
        return Container(
          width: 720,
          height: 1280,
          child: widget.cameraPreview,
        );
      }

  }
}
