// import 'dart:async';
// import 'dart:io';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:youplay/actions/run_actions.dart';
// import 'package:youplay/models/response.dart';
// import 'package:youplay/screens/util/utils.dart';
// import 'package:youplay/store/actions/current_run.actions.dart';
// import 'package:youplay/store/actions/current_run.picture.actions.dart';
// import 'package:youplay/ui/components/buttons/video_record_button.dart';
// import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';
//
// import '../general_item.dart';
//
// enum VideoRecordingStatus { stopped, recording }
//
// class RecordVideoWidget extends StatefulWidget {
//   GeneralItemViewModel giViewModel;
//   Function finished;
//
//   RecordVideoWidget({required this.giViewModel, required this.finished});
//
//   @override
//   _RecordVideoWidgetState createState() => _RecordVideoWidgetState();
// }
//
// class _RecordVideoWidgetState extends State<RecordVideoWidget> {
//   CameraController? controller;
//   String? videoPath;
//   VideoPlayerController? videoController;
//   List<CameraDescription> cameras = [];
//   CameraLensDirection _direction = CameraLensDirection.back;
//   VideoRecordingStatus status = VideoRecordingStatus.stopped;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         RichTextTopContainer(),
//         AspectRatio(
//           aspectRatio: 1,
//           child: ClipRect(
//             child: OverflowBox(
//               alignment: Alignment.center,
//               child: FittedBox(
//                 fit: BoxFit.fitWidth,
//                 child: (controller == null)
//                     ? Container()
//                     : Container(
//                         width: 200,
//                         height: 200,
//                         child: CameraPreview(
//                             controller!), // this is my CameraPreview
//                       ),
//               ),
//             ),
//           ),
//         ),
//
//         (controller == null ||
//                 controller!.value == null ||
//                 !controller!.value.isInitialized)
//             ? Container()
//             :
//         VideoRecordButton(
//           isRecording: status == VideoRecordingStatus.stopped,
//           tapRecord: () {
//             setState(() {
//               status = VideoRecordingStatus.recording;
//             });
//             startVideoRecording();
//           },
//           tapStop: () {
//             setState(() {
//               status = VideoRecordingStatus.stopped;
//             });
//             stopVideoRecording();
//           },
//         ),
//
//       ],
//     );
//     ;
//   }
//
//   @override
//   void initState() {
//     // Fetch the available cameras before initializing the app.
//     _loadCameras().then((cameras) {
//       setState(() {
//         this.cameras = cameras;
//         print("cameras loaded ${this.cameras.length}");
//       });
//     });
//
//     _initializeCamera();
//
//     super.initState();
//   }
//
//   void _initializeCamera() async {
//     CameraDescription? cameraDesc = await getCamera(_direction);
//     if (cameraDesc == null) {
//       return;
//     }
//     controller = CameraController(
//         cameraDesc, ResolutionPreset.medium,
//         enableAudio: true);
//     await controller!.initialize().then((_) {
//       setState(() {});
//     });
//   }
//
//   Future<List<CameraDescription>> _loadCameras() async {
//     // Fetch the available cameras before initializing the app.
//     try {
//       if (cameras == null || cameras.isEmpty) return await availableCameras();
//     } on CameraException catch (e) {
// //      logError(e.code, e.description);
//     }
//     return [];
//   }
//
//   String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
//
//   void _showCameraException(CameraException e) {
//     print(' ${e.code} - ${e.description}');
//
// //    showInSnackBar('Error: ${e.code}\n${e.description}');
//   }
//
//   void onStopButtonPressed() {
//     stopVideoRecording().then((_) {
//       if (mounted) setState(() {});
//       print('Video recorded to: $videoPath');
//     });
//   }
//
//   Future<void> startVideoRecording() async {
//     if (controller == null) {
//       return null;
//     }
//     if (!(controller!.value.isInitialized)) {
//       return null;
//     }
//     if (controller!.value.isRecordingVideo) {
//       // A recording is already started, do nothing.
//       return null;
//     }
//
//     try {
//       // videoPath = filePath;
//
//       //await controller.startVideoRecording(filePath);
//       await controller!.startVideoRecording();
//     } on CameraException catch (e) {
//       print(e);
//       _showCameraException(e);
//       return null;
//     }
//   }
//
//   Future<void> stopVideoRecording() async {
//     if (controller == null) {
//       return null;
//     }
//     if (!controller!.value.isRecordingVideo) {
//       return null;
//     }
//
//     try {
//       XFile result = await controller!.stopVideoRecording();
//       setState(() {
//         this.videoPath = result.path;
//       });
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       return null;
//     }
//     VideoPlayerController vpc = VideoPlayerController.file(File(videoPath!));
//     await vpc.initialize();
//     Duration d = vpc.value.duration;
//     if (widget.giViewModel.item != null &&
//         widget.giViewModel.run?.runId != null) {
//       widget.giViewModel.onDispatch(LocalAction(
//         action: "answer_given",
//         generalItemId: widget.giViewModel.item!.itemId,
//         runId: widget.giViewModel.run!.runId!,
//       ));
//       widget.giViewModel.onDispatch(VideoResponseAction(
//           videoResponse: VideoResponse(
//               length: d.inMilliseconds,
//               item: widget.giViewModel.item,
//               path: videoPath!,
//               run: widget.giViewModel.run)));
//       widget.giViewModel
//           .onDispatch(SyncFileResponse(runId: widget.giViewModel.run!.runId!));
//     }
//
//     vpc.dispose();
//
//     widget.finished();
// //    await _startVideoPlayer();
//   }
// }
