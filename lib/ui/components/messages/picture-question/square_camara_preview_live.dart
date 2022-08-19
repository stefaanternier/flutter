import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';


class CameraSquarePreview extends StatelessWidget {
  NativeDeviceOrientation orientation;
  CameraController? controller;

  CameraSquarePreview({this.controller, required this.orientation});

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return AspectRatio(
          aspectRatio: 1, //controller.value.aspectRatio,
          child: Container());
    }
    var size = MediaQuery.of(context).size.width;
    if (!(orientation == NativeDeviceOrientation.landscapeLeft ||
        orientation == NativeDeviceOrientation.landscapeRight)) {
      print('portr $size');
      return Container(
        width: size,
        height: size,
        child: ClipRect(
          child: OverflowBox(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                width: size,
                height: size / (1 / controller!.value.aspectRatio),
                child: CameraPreview(controller!), // this is my CameraPreview
              ),
            ),
          ),
        ),
      );
    } else {
      return RotatedBox(
          quarterTurns: (orientation == NativeDeviceOrientation.landscapeLeft) ? 1 : 3,
          child: Container(
            width: size,
            height: size,
            child: ClipRect(
              child: OverflowBox(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Container(
                    height: size,
                    width: size / (1 / controller!.value.aspectRatio),
                    child: CameraPreview(controller!), // this is my CameraPreview
                  ),
                ),
              ),
            ),
          ));
    }

  }
}
