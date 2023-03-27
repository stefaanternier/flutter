import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/buttons/camera_button.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/messages/picture-question/square_camara_preview_live.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';

class TakePictureWidget extends StatefulWidget {
  final Function cancelCallBack;
  final Function(String) pictureTaken;
  final GeneralItem? generalItem;

  TakePictureWidget({required this.cancelCallBack, required this.generalItem, required this.pictureTaken});

  @override
  _TakePictureWidgetState createState() {
    return _TakePictureWidgetState();
  }
}

class _TakePictureWidgetState extends State<TakePictureWidget> {
  CameraController? controller;

  _TakePictureWidgetState();

  List<CameraDescription> cameras = [];
  CameraLensDirection _direction = CameraLensDirection.back;
  int cameraIndex = 0;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loadCameras().then((cameras) {
      setState(() {
        this.cameras = cameras;
        print("cameras loaded ${this.cameras.length}");
      });
      if (cameras.isNotEmpty) {
        controller = CameraController(
          cameras[0],
          ResolutionPreset.high,
        );
        controller!.initialize().then((_) {
          setState(() {});
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NativeDeviceOrientationReader(
        useSensor: true,
        builder: (context) {
          final nativeOrientation = NativeDeviceOrientationReader.orientation(context);
          if (nativeOrientation == NativeDeviceOrientation.landscapeLeft) {
            if (UniversalPlatform.isAndroid) {
              // print('orientation is landscapleft');
              controller?.lockCaptureOrientation(DeviceOrientation.landscapeLeft);
            } else {
              controller?.lockCaptureOrientation(DeviceOrientation.landscapeRight);
            }
          } else if (nativeOrientation == NativeDeviceOrientation.landscapeRight) {
            if (UniversalPlatform.isAndroid) {
              // print('orientation is landscaperight');
              controller?.lockCaptureOrientation(DeviceOrientation.landscapeRight);
            } else {
              controller?.lockCaptureOrientation(DeviceOrientation.landscapeLeft);
            }
          } else {
            controller?.lockCaptureOrientation(DeviceOrientation.portraitUp);
          }
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: ThemedAppbarContainer(title: widget.generalItem!.title, elevation: false, actions: [
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
            ]),
            body: MessageBackgroundWidgetContainer(
                child: Stack(
              children: [
                Container(
                  color: Color.fromRGBO(0, 0, 0, 0.7),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RichTextTopContainer(),
                          CameraSquarePreview(
                            controller: controller,
                            orientation: nativeOrientation,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 30,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                  child: CameraButton(onTap: () => _takePicture())),
                            ],
                          )
                        ]))
              ],
            )),
          );
        });
  }

  Future<List<CameraDescription>> _loadCameras() async {
    try {
      if (cameras == null || cameras.isEmpty) return await availableCameras();
    } on CameraException catch (e) {}
    return [];
  }

  Future<void> _takePicture() async {
    if (controller == null || !controller!.value.isInitialized) {
      return null;
    }
    if (controller!.value.isTakingPicture) {
      return null;
    }
    XFile imageFile;
    try {
      imageFile = await controller!.takePicture();
    } on CameraException catch (e) {
      return null;
    }

    if (kIsWeb) {
      widget.pictureTaken(imageFile.path);
    } else {
      ImageProperties properties = await FlutterNativeImage.getImageProperties(imageFile.path);
      print('width - height ${properties.width} --- ${properties.height}');
      int width = properties.width ?? 250;
      int height = properties.height ?? 700;
      if (width < height) {
        var offset = (height - width) / 2;
        if (offset < 0) {
          offset = offset * -1;
        }
        File croppedFile = await FlutterNativeImage.cropImage(imageFile.path, 0, offset.round(), width, width);

        croppedFile.path;
        widget.pictureTaken(croppedFile.path);
      } else {
        var offset = (height - width) / 2;
        if (offset < 0) {
          offset = offset * -1;
        }
        File croppedFile = await FlutterNativeImage.cropImage(imageFile.path, offset.round(), 0, height, height);

        croppedFile.path;
        widget.pictureTaken(croppedFile.path);
      }
    }
  }
}
