import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

Future<CameraDescription?> getCamera(CameraLensDirection dir) async {
  return await availableCameras().then((List<CameraDescription?> cameras) =>
      cameras.firstWhere((CameraDescription? camera) {
        return camera?.lensDirection == dir;
      }, orElse: null));
}

Uint8List concatenatePlanes(List<Plane> planes) {
  final WriteBuffer allBytes = WriteBuffer();
  planes.forEach((Plane plane) => allBytes.putUint8List(plane.bytes));
  return allBytes.done().buffer.asUint8List();
}
