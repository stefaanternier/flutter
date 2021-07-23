import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context)  {

    return Scaffold(
      appBar: AppBar(
        title: Text('Image cache Route'),
      ),
      body: Center(
        child:Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            RaisedButton(
              child: Text('Go back!'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CameraApp()

          ],
        ),



      ),
    );
  }
}
class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}
List<CameraDescription> cameras = [];

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() async {
    super.initState();

    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio:
        controller.value.aspectRatio,
        child: CameraPreview(controller));
  }
}
