import 'dart:typed_data';
import 'dart:ui';
import 'dart:math';

import 'package:camera/camera.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// typedef HandleDetection = Future<dynamic> Function(FirebaseVisionImage image);

Future<CameraDescription> getCamera(CameraLensDirection dir) async {
  return await availableCameras().then((List<CameraDescription> cameras) =>
      cameras.firstWhere((CameraDescription camera) {
        return camera.lensDirection == dir;
      }));
}

Uint8List concatenatePlanes(List<Plane> planes) {
  final WriteBuffer allBytes = WriteBuffer();
  planes.forEach((Plane plane) => allBytes.putUint8List(plane.bytes));
  return allBytes.done().buffer.asUint8List();
}

// FirebaseVisionImageMetadata buildMetaData(CameraImage image) =>
//     FirebaseVisionImageMetadata(
//       rawFormat: image.format.raw,
//       size: Size(image.width.toDouble(), image.height.toDouble()),
//       rotation: ImageRotation.rotation270,
//       planeData: image.planes.map(
//             (Plane plane) {
//           return FirebaseVisionImagePlaneMetadata(
//             bytesPerRow: plane.bytesPerRow,
//             height: plane.height,
//             width: plane.width,
//           );
//         },
//       ).toList(),
//     );
//
// Future<dynamic> detect(
//     CameraImage image,
//     HandleDetection handleDetection,
//     ) async {
//   return handleDetection(
//     FirebaseVisionImage.fromBytes(
//       concatenatePlanes(image.planes),
//       buildMetaData(image),
//     ),
//   );
// }


// class BarcodeDetectorPainter extends CustomPainter {
//   BarcodeDetectorPainter(this.imageSize, this.barcodes);
//
//   final Size imageSize;
//   final List<Barcode> barcodes;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0;
//
// //    for (Barcode barcode in barcodes) {
// //      paint.color = Colors.green;
// //      canvas.drawRect(
// //        _scaleAndFlipRectangle(
// ////          rect: barcode.boundingBox,
// //          imageSize: imageSize,
// //          widgetSize: size,
// //          shouldFlipX: defaultTargetPlatform != TargetPlatform.iOS,
// //          shouldFlipY: defaultTargetPlatform != TargetPlatform.iOS,
// //        ),
// //        paint,
// //      );
// //    }
//   }
//
//   @override
//   bool shouldRepaint(BarcodeDetectorPainter oldDelegate) {
//     return oldDelegate.imageSize != imageSize ||
//         oldDelegate.barcodes != barcodes;
//   }
// }

Rect _scaleAndFlipRectangle({
  @required Rectangle<int> rect,
  @required Size imageSize,
  @required Size widgetSize,
  bool shouldScaleX = true,
  bool shouldScaleY = true,
  bool shouldFlipX = true,
  bool shouldFlipY = true,
}) {
  final double scaleX = shouldScaleX ? widgetSize.width / imageSize.width : 1;
  final double scaleY = shouldScaleY ? widgetSize.height / imageSize.height : 1;

  double left;
  double right;
  if (shouldFlipX) {
    left = imageSize.width - rect.left;
    right = imageSize.width - rect.right;
  } else {
    left = rect.left.toDouble();
    right = rect.right.toDouble();
  }

  double top;
  double bottom;
  if (shouldFlipY) {
    top = imageSize.height - rect.top;
    bottom = imageSize.height - rect.bottom;
  } else {
    top = rect.top.toDouble();
    bottom = rect.bottom.toDouble();
  }

  return Rect.fromLTRB(
    left * scaleX,
    top * scaleY,
    right * scaleX,
    bottom * scaleY,
  );
}