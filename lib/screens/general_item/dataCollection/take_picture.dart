import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/screens/general_item/dataCollection/picture_preview_live.dart';
import 'package:youplay/screens/general_item/util/messages/generic_message.dart';
import 'package:youplay/screens/util/utils.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';

import '../general_item.dart';

class TakePictureWidget extends StatefulWidget {
  // dynamic takePictureCallBack;
  GeneralItemViewModel giViewModel;
  Function cancelCallBack;
  Function(String) pictureTaken;

  Run? run;
  GeneralItem? generalItem;

  TakePictureWidget(
      {required this.giViewModel,
        required this.cancelCallBack,
      this.run,
        required this.generalItem,
        required this.pictureTaken});

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

  // bool pictureTaken = false;
  // String imagePath;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // Fetch the available cameras before initializing the app.
    _loadCameras().then((cameras) {
      setState(() {
        this.cameras = cameras;
        print("cameras loaded ${this.cameras.length}");
      });
    });

    _initializeCamera();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.giViewModel.item == null){
      return Container(child: Text('item loading...'));  //todo make message beautiful
    }
    return GeneralItemWidget(
        item: widget.giViewModel.item!,
        giViewModel: widget.giViewModel,
        padding: false,
        elevation: false,
        body: Stack(
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
                        CameraSquarePreview(controller: controller),

                      ],
                    ),
                  // ),
              ],
            ),

            ),
            Positioned(
              left:0,
                right:0,
                bottom: 30,
                child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,

                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                            child: ClipOval(
                              child: Material(
                                color: Colors.white, // button color
                                child: InkWell(
                                  splashColor: Colors.black12, // inkwell color
                                  child: SizedBox(
                                    width: 94,
                                    height: 94,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(50),
                                              border: Border.all(
                                                  width: 3, color: Colors.black)),
                                          // inkwell colo
                                          child: ClipOval(
                                              child: GestureDetector(
                                                onTap: () {
                                                  _takePicture();
                                                },
                                                child: Material(
                                                  color: Colors.white,
                                                ),
                                              ))),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]))
          ],
        ));
  }

  void _initializeCamera() async {
    controller = CameraController(
      await getCamera(_direction),
      ResolutionPreset.high,
    );
    await controller!.initialize().then((_) {
      setState(() {
        this.cameras = this.cameras;
      });
    });
  }

  Future<List<CameraDescription>> _loadCameras() async {
    try {
      if (cameras == null || cameras.isEmpty) return await availableCameras();
    } on CameraException catch (e) {}
    return [];
  }

  String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> _takePicture() async {
    if (controller == null || !controller!.value.isInitialized) {
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    // final String filePath = '$dirPath/${_timestamp()}.jpg';

    if (controller!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    XFile imageFile;
    try {
      //todo migration
      //await controller.takePicture(filePath);
      imageFile = await controller!.takePicture();
    } on CameraException catch (e) {
//      _showCameraException(e);
      print("exception e");
      return null;
    }
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(imageFile.path);


    // print('filepath $filePath  ${properties.width} ${properties.height}');
    int width = properties.width?? 250;
    int height = properties.height??700;
    if (width < height) {
      var offset = (height - width) / 2;
      if (offset < 0) {
        offset = offset * -1;
      }
      // print('todo $filePath ${offset.round()} 0 $width $height');
      File croppedFile = await FlutterNativeImage.cropImage(
          imageFile.path, 0, offset.round(), width, width);

      croppedFile.path;

      // print("old file ${filePath} ");
      print("new file ${croppedFile.path} ");
      // setState(() {
      // pictureTaken = true;
      // imagePath = filePath;
      widget.pictureTaken(croppedFile.path);
    } else {
      print('todo');
      var offset = (height - width) / 2;
      if (offset < 0) {
        offset = offset * -1;
      }
      // print('todo $filePath ${offset.round()} 0 $height $height');
      File croppedFile = await FlutterNativeImage.cropImage(
          imageFile.path,  offset.round(), 0, height, height);

      croppedFile.path;
      widget.pictureTaken(croppedFile.path);
    }

    // });
    // return filePath;
  }
}
