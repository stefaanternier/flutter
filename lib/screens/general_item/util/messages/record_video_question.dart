// import 'dart:async';
// import 'dart:collection';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:intl/intl.dart';
// import 'package:redux/redux.dart';
// import 'package:youplay/models/general_item.dart';
// import 'package:youplay/models/response.dart';
// import 'package:youplay/screens/components/button/cust_flat_button.dart';
// import 'package:youplay/screens/general_item/dataCollection/play_video.dart';
// import 'package:youplay/screens/general_item/dataCollection/record_video.dart';
// import 'package:youplay/screens/general_item/general_item.dart';
// import 'package:youplay/store/selectors/current_run.selectors.dart';
// import 'package:youplay/store/state/app_state.dart';
// import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';
// import 'package:youplay/ui/components/next_button/next_button.container.dart';
//
// import 'generic_message.dart';
//
// enum VideoRecordingStatus { stopped, play, recording }
//
// format(Duration d) {
//   String retValue = d.toString().split('.').first.padLeft(8, "0");
//   if (retValue.startsWith("00:")) {
//     retValue = retValue.substring(3);
//   }
//   return retValue;
// }
//
// class _RecordingsViewModel {
//   List<Response> audioResponses;
//   List<Response> fromServer;
//
//   _RecordingsViewModel(
//       {required this.audioResponses, required this.fromServer});
//
//   static _RecordingsViewModel fromStore(Store<AppState> store) {
//     return new _RecordingsViewModel(
//         audioResponses: currentRunResponsesSelector(store.state),
//         fromServer: currentItemResponsesFromServerAsList(store.state));
//   }
//
//   int amountOfItems() {
//     return audioResponses.length + fromServer.length;
//   }
//
//   bool isLocal(int index) {
//     return index >= fromServer.length;
//   }
//
//   Response getItem(index) {
//     if (index < fromServer.length) {
//       return fromServer[index];
//     }
//     return audioResponses[index - fromServer.length];
//   }
//
//   Response delete(index) {
//     if (index < fromServer.length) {
//       return fromServer.removeAt(index);
//     } else {
//       return audioResponses.removeAt(index - fromServer.length);
//     }
//   }
//
//   void deleteAllResponses(List<Response> deleted) {
//     this.fromServer = this.fromServer.where((element) {
//       for (var i = 0; i < deleted.length; ++i) {
//         var o = deleted[i];
//         if (deleted[i].responseId == element.responseId) return false;
//       }
//       return true;
//     }).toList(growable: true);
//     this.audioResponses = this.audioResponses.where((element) {
//       for (var i = 0; i < deleted.length; ++i) {
//         var o = deleted[i];
//         if (deleted[i].responseId == element.responseId) return false;
//       }
//       return true;
//     }).toList(growable: true);
//   }
// }
//
// class NarratorWithVideo extends StatefulWidget {
//   GeneralItem item;
//   GeneralItemViewModel giViewModel;
//
//   NarratorWithVideo({required this.item, required this.giViewModel});
//
//   @override
//   _NarratorWithVideoState createState() => new _NarratorWithVideoState();
// }
//
// class _NarratorWithVideoState extends State<NarratorWithVideo> {
//   VideoRecordingStatus status = VideoRecordingStatus.stopped;
//   List<Response> deleted = [];
//
//   int selectedItem = -1;
//   Response? selectedResponse;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Future _startRecording() async {
//     setState(() {
//       status = VideoRecordingStatus.recording;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget body;
//     switch (status) {
//       case VideoRecordingStatus.stopped:
//         {
//           body = buildStopped(context);
//         }
//         break;
//
//       case VideoRecordingStatus.recording:
//         {
//           body = RecordVideoWidget(
//             giViewModel: widget.giViewModel,
//             finished: () {
//               setState(() {
//                 status = VideoRecordingStatus.stopped;
//               });
//             },
//           );
//         }
//         break;
//
//       case VideoRecordingStatus.play:
//         {
//           if (selectedResponse != null && widget.giViewModel.item != null) {
//             body = PlayVideoWidget(
//               response: selectedResponse!,
//               item: widget.giViewModel.item!,
//               onDelete: () {
//                 print('on delete not implemented');
//               },
//             );
//           } else {
//             return Container(
//                 child: Text('item loading...')); //todo make message beautiful
//
//           }
//         }
//         break;
//     }
//     return GeneralItemWidget(
//         item: this.widget.item,
//         giViewModel: this.widget.giViewModel,
//         padding: false,
//         elevation: false,
//         body: Container(color: Color.fromRGBO(0, 0, 0, 0.8), child: body));
//   }
//
//   Widget buildStopped(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         RichTextTopContainer(),
//         Expanded(
//           child: StoreConnector<AppState, _RecordingsViewModel>(
//               converter: (store) => _RecordingsViewModel.fromStore(store),
//               builder: (context, _RecordingsViewModel map) {
//                 map.deleteAllResponses(this.deleted);
//                 final DateTime now = DateTime.now();
//                 final DateFormat formatter = DateFormat.yMMMMd(
//                     Localizations.localeOf(context).languageCode);
//                 return ListView.builder(
//                   itemCount: map.amountOfItems(),
//                   itemBuilder: (context, index) {
//                     final DateTime thatTime =
//                         DateTime.fromMillisecondsSinceEpoch(
//                             map.getItem(index).timestamp);
//                     return Dismissible(
//                         key: Key('${map.getItem(index).timestamp}'),
//                         background: slideLeftBackground(),
//                         onDismissed: (direction) {
//                           setState(() {
//                             this.deleted.add(map.getItem(index));
//                             deleteResponse(map.delete(index));
//                             map.deleteAllResponses(this.deleted);
//                           });
//                         },
//                         child: new ListTile(
//                           title: Text('Nieuwe opname',
//                               style: TextStyle(color: Colors.white)),
//                           subtitle: Text('${formatter.format(thatTime)} ',
//                               style: TextStyle(
//                                   color: Colors.white.withOpacity(0.7))),
//                           trailing: Text(
//                               "${format(new Duration(milliseconds: map.getItem(index).length ?? 0))}",
//                               style: TextStyle(
//                                   color: Colors.white.withOpacity(0.7))),
//                           onTap: () {
//                             if (widget.giViewModel.item != null) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => PlayVideoWidget(
//                                         response: map.getItem(index),
//                                         item: widget.giViewModel.item!,
//                                         onDelete: () {
//                                           deleteResponse(map.delete(index));
//                                         })),
//                               );
//                             }
//                           },
//                         ));
//                   },
//                 );
//               }),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 8),
//           child: NextButtonContainer(item: widget.giViewModel.item!),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 28),
//           child: CustomFlatButton(
//             title: "Nieuwe video opname",
//             icon: Icons.videocam,
//             color: Colors.white,
//             onPressed: () {
//               setState(() {
//                 status = VideoRecordingStatus.recording;
//                 _startRecording();
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget slideLeftBackground() {
//     return Container(
//       color: Colors.red,
//       child: Align(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             Icon(
//               Icons.delete,
//               color: Colors.white,
//             ),
//             Text(
//               "Delete",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w700,
//               ),
//               textAlign: TextAlign.right,
//             ),
//             SizedBox(
//               width: 20,
//             ),
//           ],
//         ),
//         alignment: Alignment.centerRight,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   deleteResponse(Response item) {
//     if (item.responseId != null) {
//       widget.giViewModel.deleteResponse(item.responseId);
//     }
//   }
// }
