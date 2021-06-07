import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:universal_platform/universal_platform.dart';


class CameraSquarePreview extends StatelessWidget {

  CameraController controller;

  CameraSquarePreview({this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return AspectRatio(
          aspectRatio: 1, //controller.value.aspectRatio,
          child: Container()
      );
    }
    return NativeDeviceOrientationReader(
      useSensor: true,
      builder: (context) {
        // print('orientation ${orientation.}');
        final orientation =
        NativeDeviceOrientationReader.orientation(context);
        print('Received new orientation: $orientation');

        if (orientation == NativeDeviceOrientation.portraitDown || orientation == NativeDeviceOrientation.portraitUp ) {
          var size = MediaQuery.of(context).size.width;

          print('nl size $size $orientation');
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
                    height:
                    size / (1/controller.value.aspectRatio),
                    child: CameraPreview(controller), // this is my CameraPreview
                  ),
                ),
              ),
            ),
          );



        } else {
          if (UniversalPlatform.isIOS) {
            var size = MediaQuery.of(context).size.width;
print('${MediaQuery.of(context).size.width} ${MediaQuery.of(context).size.height}  ${controller.value.aspectRatio}');
            // return ;



            return
              RotatedBox(
                quarterTurns: orientation == NativeDeviceOrientation.landscapeLeft? 1 : 3,
                child: Center(
                  child: Container(
                    width: size,
                    height: size,
                    child: ClipRect(
                      child: OverflowBox(
                        alignment: Alignment.center,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Container(
                            width: size/(1/controller.value.aspectRatio),
                            height:
                            size,
                            child: CameraPreview(controller), // this is my CameraPreview
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
          } else {
            return
              RotatedBox(
                quarterTurns: orientation == NativeDeviceOrientation.landscapeLeft? 3 : 1,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: CameraPreview(controller),
                  ),
                ),
              );
          }

        }
      },
    );
  }
}


Widget cameraPreviewWidget(
    CameraController controller, Function takePicture, Function cancel, BuildContext context) {
  if (controller == null || !controller.value.isInitialized) {
    return const Text(
      'Initializing camera',
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w900,
      ),
    );
  } else {
//    print("aspect ratio");


  }
}
