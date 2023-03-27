import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:universal_platform/universal_platform.dart';


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
    var height = MediaQuery.of(context).size.width;

    if (!(orientation == NativeDeviceOrientation.landscapeLeft ||
        orientation == NativeDeviceOrientation.landscapeRight)) {

      // controller!.lockCaptureOrientation(DeviceOrientation.portraitUp);
      print('portrait width is $size  $height  --- ${controller!.value.aspectRatio} - ${controller!.value.previewSize}');
      CameraValue value = controller!.value;

      if (UniversalPlatform.isAndroid && controller!.description.sensorOrientation == 0) {
        return Container(
          width: size,
          height: size,
          child: ClipRect(
            child: OverflowBox(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Container(
                  width: size,
                  height: size / ( controller!.value.aspectRatio),
                  child: CameraPreview(controller!), // this is my CameraPreview
                ),
              ),
            ),
          ),
        );
      }
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
                height: size / ( 1 / controller!.value.aspectRatio),
                child: CameraPreview(controller!), // this is my CameraPreview
              ),
            ),
          ),
        ),
      );
    } else {
      print('landscape left width is $size  $height  --- ${controller!.value.aspectRatio}');
      print('landscape left width is $size  $height  --- ${controller!.description.sensorOrientation}');
      var quarterTurns =(orientation == NativeDeviceOrientation.landscapeLeft) ? 1 : 3;
      if (UniversalPlatform.isAndroid && controller!.description.sensorOrientation == 0) {
        return RotatedBox(
            quarterTurns: (orientation == NativeDeviceOrientation.landscapeLeft) ? 3 : 1,
            child: Container(
              width: size,
              height: size,
              child: ClipRect(
                child: OverflowBox(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      height: size,
                      width: size / (controller!.value.aspectRatio),
                      child: CameraPreview(controller!), // this is my CameraPreview
                    ),
                  ),
                ),
              ),
            ));
      }

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
