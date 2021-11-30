// import 'dart:async';
// import 'dart:math';
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:universal_platform/universal_platform.dart';
// import 'package:video_player/video_player.dart';
// import 'package:youplay/actions/run_actions.dart';
// import 'package:youplay/config/app_config.dart';
// import 'package:youplay/models/general_item/video_object.dart';
// import 'package:youplay/screens/general_item/general_item.dart';
//
// import '../../../../localizations.dart';
// import 'components/next_button.dart';
// import 'generic_message.dart';
//
// class VideoObjectGeneralItemScreen extends StatefulWidget {
//   VideoObjectGeneralItem item;
//   GeneralItemViewModel giViewModel;
//
//   VideoObjectGeneralItemScreen(
//       {required this.item, required this.giViewModel, Key? key})
//       : super(key: key) {
//     _VideoObjectGeneralItemScreenState().updateController();
//   }
//
//   @override
//   _VideoObjectGeneralItemScreenState createState() =>
//       _VideoObjectGeneralItemScreenState();
// }
//
// class _VideoObjectGeneralItemScreenState
//     extends State<VideoObjectGeneralItemScreen> {
//   VideoPlayerController? _controller;
//   double _position = 0;
//   double _maxposition = 0;
//   bool showControls = false;
//   bool isFinished = false;
//   bool completeActionSent = false;
//
//   _VideoObjectGeneralItemScreenState();
//
//   void updateController() {}
//
//   @override
//   void initState()  {
//     super.initState();
//     String? unencPath;
//     if (widget.item.fileReferences != null) {
//       unencPath = widget.item.fileReferences!['video']?.replaceFirst('//', '/');
//     }
//     if (unencPath != null) {
//       int index = unencPath.lastIndexOf("/") + 1;
//       String path;
//       if (UniversalPlatform.isIOS) {
//         path = Uri.encodeComponent(unencPath);
//         print(path);
//       } else {
//         path = unencPath.substring(0, index) +
//             Uri.encodeComponent(unencPath.substring(index));
//       }
//
//       _controller = VideoPlayerController.network(
//           // url
//
//         'http://storage.googleapis.com/${AppConfig().projectID}.appspot.com${path}'
//       )
//         ..addListener(() {
//           setState(() {
//             if (_controller!.value.duration != null) {
//               _position =
//                   _controller!.value.position.inMilliseconds.roundToDouble();
//               _maxposition = max(_position,
//                   _controller!.value.duration.inMilliseconds.roundToDouble());
//
//               if (((_controller!.value.duration.inMilliseconds - 1000) <=
//                   _controller!.value.position.inMilliseconds) &&
//                   _controller!.value.duration.inMilliseconds > 100) {
//                 isFinished = true;
//                 if (!completeActionSent) {
//                   if (widget.giViewModel.item != null && widget.giViewModel.run?.runId != null) {
//                     widget.giViewModel.onDispatch(Complete(
//                       generalItemId: widget.giViewModel.item!.itemId,
//                       runId: widget.giViewModel.run!.runId!,
//                     ));
//                     completeActionSent = true;
//                   }
//                 }
//               }
//             }
//           });
//         })
//         ..initialize().then((_) {
//           // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//           setState(() {
//             // _controller!.play();
//           });
//         });
//       // FirebaseStorage.instance.ref(path).getDownloadURL().then((url) {
//       //   print('url is $url');
//       //
//       // });
//
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GeneralItemWidget(
//         item: this.widget.item,
//         renderBackground: false,
//         giViewModel: this.widget.giViewModel,
//         body: _controller == null? Container():Container(
//             constraints: const BoxConstraints.expand(),
//             child: _controller!.value.isInitialized
//                 ? buildVideoPlayer(context)
//                 : Theme(
//                     data: Theme.of(context).copyWith(
//                         accentColor: this.widget.giViewModel.getPrimaryColor()),
//                     child: Center(child: CircularProgressIndicator()),
//                   )));
//   }
//
//   Widget buildVideoPlayer(BuildContext context) {
//     Widget vp = FittedBox(
//       fit: BoxFit.cover,
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.width / 1080 * 1920,
//         child: GestureDetector(
//           onTap: () {
//             setState(() {
//               showControls = !showControls;
//             });
//           },
//           child: VideoPlayer(_controller!),
//         ),
//       ),
//     );
//
//     return Stack(
//       alignment: const Alignment(0, 0),
//       // fit: StackFit.expand,
//       children: [
//         Positioned(top: 0, right: 0, left: 0, child: vp),
//         Visibility(
//             visible: showControls && !isFinished,
//             child: getPlayButton(vp, context)),
//         Positioned(
//             bottom: 100,
//             left: 30,
//             right: 30,
//             child: Visibility(
//               visible: showControls && !isFinished,
//               child: Opacity(
//                 opacity: 0.9,
//                 // child: Padding(
//                 // padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
//                 child: Card(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       new Slider(
//                           activeColor: widget.giViewModel.getPrimaryColor(),
//                           value: _position,
//                           max: _maxposition,
//                           onChanged: (double val) {
//                             _controller!
//                                 .seekTo(Duration(milliseconds: val.floor()));
//                           },
//                           onChangeEnd: (val) {})
//                     ],
//                   ),
//                 ),
//               ),
//             )
//             // ),
//             ),
//         Visibility(
//           visible: isFinished,
//           child: Positioned(
//               left: 46,
//               right: 46,
//               bottom: 46,
//               child: Opacity(
//                 opacity: 1.0,
//                 child: NextButton(
//                     buttonText: widget.item.description != ""
//                         ? widget.item.description
//                         : AppLocalizations.of(context)
//                             .translate('screen.proceed'),
//                     overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
//                     giViewModel: widget.giViewModel),
//               )),
//         )
//       ],
//     );
//   }
//
//   Widget getPlayButton(Widget videoPlayer, BuildContext context) {
//     return Opacity(
//       opacity: 1.0,
//       child: GestureDetector(
//         onTap: () {
//           new Timer(Duration(milliseconds: 10), () {
//             setState(() {
//               if (_controller!.value.isPlaying) {
//                 _controller!.pause();
//               } else {
//                 _controller!.play();
//                 showControls = false;
//               }
//             });
//           });
//         },
//         child: Icon(
//             _controller?.value.isPlaying ?? false
//                 ? Icons.pause_circle_filled
//                 : Icons.play_circle_filled,
//             color: widget.giViewModel.getPrimaryColor(),
//             size: 75),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//
//     _controller?.dispose();
//   }
// }
