import 'dart:async';
import 'dart:collection';
import 'dart:io' as io;
import 'dart:io';

import 'package:flutter/material.dart';


// import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/localizations.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/screens/components/button/cust_flat_button.dart';
import 'package:youplay/screens/components/button/cust_raised_button.dart';
import 'package:youplay/screens/general_item/general_item.dart';
import 'package:youplay/screens/general_item/util/messages/components/list_audio_player.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

import 'components/audio_meter.dart';
import 'components/game_themes.viewmodel.dart';
import 'components/next_button.dart';
import 'generic_message.dart';
import 'package:permission_handler/permission_handler.dart';

enum AudioRecordingStatus { stopped, paused, recording }

format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

class _RecordingsViewModel {
  List<String> keys;
  List<Response> audioResponses;
  List<Response> fromServer;

  _RecordingsViewModel({this.keys, this.audioResponses, this.fromServer});

  static _RecordingsViewModel fromStore(Store<AppState> store) {
    return new _RecordingsViewModel(
        audioResponses: currentRunResponsesSelector(store.state),
        fromServer: currentItemResponsesFromServerAsList(store.state));
  }

  int amountOfItems() {
    return audioResponses.length + fromServer.length;
  }

  bool isLocal(int index) {
    return index >= fromServer.length;
  }

  Response getItem(index) {
    if (index < fromServer.length) {
      return fromServer[index];
    }
    return audioResponses[index - fromServer.length];
  }

  Response delete(index) {
    if (index < fromServer.length) {
      return fromServer.removeAt(index);
    } else {
      return audioResponses.removeAt(index - fromServer.length);
    }
  }

  void deleteAllResponses(List<Response> deleted) {
    this.fromServer = this.fromServer.where((element) {
      for (var i = 0; i < deleted.length; ++i) {
        var o = deleted[i];
        if (deleted[i].responseId == element.responseId) return false;
      }
      return true;
    }).toList(growable: true);
    this.audioResponses = this.audioResponses.where((element) {
      for (var i = 0; i < deleted.length; ++i) {
        var o = deleted[i];
        if (deleted[i].responseId == element.responseId) return false;
      }
      return true;
    }).toList(growable: true);
  }
}

class ItemEntry<number> extends LinkedListEntry<ItemEntry> {
  number value;

  ItemEntry(this.value);

  String toString() => "${super.toString()} : value.toString()";
}

class NarratorWithAudio extends StatefulWidget {
  GeneralItem item;
  GeneralItemViewModel giViewModel;

  NarratorWithAudio({this.item, this.giViewModel});

  @override
  _NarratorWithAudioState createState() => new _NarratorWithAudioState();
}

class _NarratorWithAudioState extends State<NarratorWithAudio> {
  AudioRecordingStatus status = AudioRecordingStatus.stopped;
  LinkedList meteringList = new LinkedList<ItemEntry>();
  List<Response> deleted = [];

  int selectedItem = -1;
  FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  Duration currentDuration;

  @override
  void initState() {
    super.initState();
    openTheRecorder().then((value) {
      setState(() {
      });
    });

  }

  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    FlutterSoundRecorder recorder= await _myRecorder.openAudioSession(
    focus: AudioFocus.requestFocusAndStopOthers,
    mode: SessionMode.modeSpokenAudio,
    category: SessionCategory.record
    );
    setState(() {
      _myRecorder  = recorder;

    });

  }

  String cp;

  Future _startRecording() async {
    // String customPath = '/flutter_audio_recorder_';
    // io.Directory appDocDirectory;
    // if (io.Platform.isIOS) {
    //   appDocDirectory = await getApplicationDocumentsDirectory();
    // } else {
    //   appDocDirectory = await getExternalStorageDirectory();
    // }
    String customPath = await getCustomPath();
    setState(() {
      cp = customPath;
    });
    var status = await Permission.microphone.request();

    meteringList.addFirst(ItemEntry(0));
    await _myRecorder.setSubscriptionDuration(Duration(milliseconds: 200));

    _myRecorder.onProgress.listen((event) {
      print('event ${event}');
      setState(() {
        meteringList.addFirst(ItemEntry(event.decibels));
        this.currentDuration = event.duration;
      });
    });
    await _myRecorder
        .startRecorder(
            toFile: customPath
            )
        .then((value) {
      setState(() {});
    });



    // _t = Timer.periodic(Duration(milliseconds: 50), (Timer t) async {
    //   setState(() {
    //
    //     meteringList.addFirst(ItemEntry(10));
    //     _t = t;
    //   });
    // });

    // await _init();
    // await _recorder.start();
    // var current = await _recorder.current();
    // setState(() {
    //   _recording = current;
    // });
    //
    // _t = Timer.periodic(Duration(milliseconds: 50), (Timer t) async {
    //   var current = await _recorder.current();
    //
    //   setState(() {
    //     meteringList.addFirst(ItemEntry(current.metering.averagePower));
    //     _recording = current;
    //     _t = t;
    //   });
    // });
  }

  Future _stopRecording() async {
    // var result = await _recorder.stop();
    // _t.cancel();
    // widget.giViewModel.onDispatch(LocalAction(
    //   action: "answer_given",
    //   generalItemId: widget.giViewModel.item.itemId,
    //   runId: widget.giViewModel.run.runId,
    // ));
    // widget.giViewModel.onDispatch(AudioResponseAction(
    //     audioResponse: AudioResponse(
    //         length: _recording?.duration.inMilliseconds,
    //         item: widget.item,
    //         path: _recording?.path,
    //         run: widget.giViewModel.run)));
    // widget.giViewModel.onDispatch(SyncFileResponse(runId: widget.giViewModel.run.runId));
    //
    // setState(() {
    //   _recording = result;
    //   meteringList.clear();
    // });

    String test = await _myRecorder.stopRecorder();


    // String customPath = '/flutter_audio_recorder_';
    // io.Directory appDocDirectory;
    // if (io.Platform.isIOS) {
    //   appDocDirectory = await getApplicationDocumentsDirectory();
    // } else {
    //   appDocDirectory = await getExternalStorageDirectory();
    // }
    // String outputFile = appDocDirectory.path +
    //     customPath +
    //     DateTime.now().millisecondsSinceEpoch.toString()+".mp3";
    String outputFile = await getCustomPath(extension: ".mp3");
    print("path $outputFile");
    await flutterSoundHelper.convertFile(cp, Codec.aacADTS, outputFile, Codec.mp3);

    widget.giViewModel.onDispatch(LocalAction(
      action: "answer_given",
      generalItemId: widget.giViewModel.item.itemId,
      runId: widget.giViewModel.run.runId,
    ));
    widget.giViewModel.onDispatch(AudioResponseAction(
        audioResponse: AudioResponse(
            length: currentDuration.inSeconds,
            item: widget.item,
            path: outputFile,
            run: widget.giViewModel.run)));
    widget.giViewModel
        .onDispatch(SyncFileResponse(runId: widget.giViewModel.run.runId));


    setState(() {
      meteringList.clear();
    });

    await _myRecorder.closeAudioSession();

    openTheRecorder().then((value) {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (status) {
      case AudioRecordingStatus.stopped:
        {
          body = buildStopped(context);
        }
        break;

      case AudioRecordingStatus.recording:
        {
          body = buildRecording(context);
        }
        break;

      case AudioRecordingStatus.paused:
        {
          body = buildStopped(context);
        }
        break;
    }
    return GeneralItemWidget(
        item: this.widget.item,
        giViewModel: this.widget.giViewModel,
        padding: false,
        elevation: AudioRecordingStatus.stopped != status,
        body: Container(color: Color.fromRGBO(0, 0, 0, 0.8), child: body));
  }

  Widget buildRecording(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(flex: 2),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Text(
        //       "${format(_recording?.duration)}",
        //       style: new TextStyle(color: Colors.white, fontSize: 60.0),
        //     ),
        //   ],
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "nieuwe geluidsopname",
              style: new TextStyle(
                  color: Colors.white.withOpacity(0.7), fontSize: 14.0),
            ),
          ],
        ),
        Spacer(flex: 2),
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 300),
          painter: AudioMeter(meteringList: this.meteringList),
        ),
        Spacer(flex: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ClipOval(
              child: Material(
                color: Colors.white, // button color
                child: InkWell(
                  splashColor: Colors.red, // inkwell color
                  child: SizedBox(
                      width: 94,
                      height: 94,
                      child: Icon(
                        Icons.stop,
                        size: 50,
                      )),
                  onTap: () {
                    setState(() {
                      status = AudioRecordingStatus.stopped;
                      _stopRecording();
                    });
                  },
                ),
              ),
            ),
//              )
          ],
        ),
        Spacer(flex: 2),
//            Opacity(
//                opacity: 0.9,
//                child: Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
//                    child: Text("hallo"
//                    )
//                ))
      ],
    );
  }

  Widget buildStopped(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new StoreConnector<AppState, GameThemesViewModel>(
            converter: (store) => GameThemesViewModel.fromStore(store),
            builder: (context, GameThemesViewModel themeModel) {
              return Container(
                  // color: this.widget.giViewModel.getPrimaryColor(),
                  color: this.widget.giViewModel.getPrimaryColor() != null
                      ? this.widget.giViewModel.getPrimaryColor()
                      : themeModel.getPrimaryColor(),
                  child: Visibility(
                    visible: this.widget.item.richText != null,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "${this.widget.item.richText}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ));
            }),
        Expanded(
          child: StoreConnector<AppState, _RecordingsViewModel>(
              converter: (store) => _RecordingsViewModel.fromStore(store),
              builder: (context, _RecordingsViewModel map) {
//                print("map is back ${map.amountOfItems()}");
                map.deleteAllResponses(this.deleted);
//                print("map is back ${map.amountOfItems()}");
                final DateTime now = DateTime.now();
//                final DateFormat formatter = DateFormat('yyyy-MM-dd');
                final DateFormat formatter = DateFormat.yMMMMd(
                    Localizations.localeOf(context).languageCode);
                return ListView.builder(
                  itemCount: map.amountOfItems(),
                  itemBuilder: (context, index) {
                    final DateTime thatTime =
                        DateTime.fromMillisecondsSinceEpoch(
                            map.getItem(index).timestamp);
                    return Dismissible(
                        key: Key('${map.getItem(index).timestamp}'),
                        background: slideLeftBackground(),
                        onDismissed: (direction) {
                          setState(() {
                            this.deleted.add(map.getItem(index));
                            deleteResponse(map.delete(index));
                            map.deleteAllResponses(this.deleted);
                          });
                        },
                        child: ListAudioPlayer(response: map.getItem(index))

                        // new ExpansionTile(
                        //   title: Text('Nieuwe opname', style: TextStyle(color: Colors.white)),
                        //   subtitle: Text('${formatter.format(thatTime)} ',
                        //       style: TextStyle(color: Colors.white.withOpacity(0.7))),
                        //   trailing:
                        //       Text('1:12', style: TextStyle(color: Colors.white.withOpacity(0.7))),
                        //   children: <Widget>[ListAudioPlayer(response: map.getItem(index))],
                        // )
                        );
                  },
                );
              }),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 8),
            child: NextButton(
                buttonText:
                    AppLocalizations.of(context).translate('screen.proceed'),
                overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
                customButton: CustomRaisedButton(
                  useThemeColor: true,
                  title:
                      AppLocalizations.of(context).translate('screen.proceed'),
                  // icon: new Icon(Icons.play_circle_outline, color: Colors.white),
                  primaryColor: widget.giViewModel.getPrimaryColor(),
                  onPressed: () {
                    widget.giViewModel.continueToNextItem(context);
                  },
                ),
                giViewModel: widget.giViewModel)),
        Padding(
          padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 28),
          child: CustomFlatButton(
            title: "Nieuwe opname",
            icon: FontAwesomeIcons.microphoneAlt,
            color: Colors.white,
            onPressed: () {
              setState(() {
                status = AudioRecordingStatus.recording;
                _startRecording();
              });
            },
          ),
        ),
        // Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     mainAxisSize: MainAxisSize.max,
        //     children: <Widget>[
        //       Padding(
        //         padding: EdgeInsets.fromLTRB(30, 45, 30, 45),
        //         child: ClipOval(
        //           child: Material(
        //             color: Colors.white, // button color
        //             child: InkWell(
        //               splashColor: Colors.red, // inkwell color
        //               child: SizedBox(
        //                   width: 94,
        //                   height: 94,
        //                   child: Icon(
        //                     Icons.mic,
        //                     size: 50,
        //                   )),
        //               onTap: () {
        //                 setState(() {
        //                   status = AudioRecordingStatus.recording;
        //                   _startRecording();
        //                 });
        //               },
        //             ),
        //           ),
        //         ),
        //       )
        //     ])
      ],
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // if (this.status == AudioRecordingStatus.recording) {
    //   _recorder.stop();
    //   _t.cancel();
    //
    //   meteringList.clear();
    // }

    _myRecorder.closeAudioSession();
    _myRecorder = null;



    super.dispose();
  }

  deleteResponse(Response item) {
    print("delete ${item.toString()}");
    if (item.responseId != null) {
      widget.giViewModel.deleteResponse(item.responseId);
    }
  }
}

Future<String> getCustomPath({String extension = ''})async {
  String customPath = '/flutter_audio_recorder_';
  io.Directory appDocDirectory;
  if (io.Platform.isIOS) {
    appDocDirectory = await getApplicationDocumentsDirectory();
  } else {
    appDocDirectory = await getExternalStorageDirectory();
  }
  return appDocDirectory.path +
      customPath +
      DateTime.now().millisecondsSinceEpoch.toString()+extension;
}