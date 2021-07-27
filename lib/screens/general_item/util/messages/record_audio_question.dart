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
import 'package:universal_platform/universal_platform.dart';
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
import 'package:youplay/ui/components/messages/audio-list-recordings.dart';
import 'package:youplay/ui/components/messages/audio-results-list.container.dart';
import 'package:youplay/ui/components/messages/audio-slide-left-background.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';
import 'package:youplay/ui/components/next_button/next_button.container.dart';

import 'components/audio_meter.dart';
import 'components/game_themes.viewmodel.dart';
import 'components/next_button.dart';
import 'generic_message.dart';
import 'package:permission_handler/permission_handler.dart';

enum AudioRecordingStatus { stopped, paused, recording }

format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

class ItemEntry<number> extends LinkedListEntry<ItemEntry> {
  number value;

  ItemEntry(this.value);

  String toString() => "${super.toString()} : value.toString()";
}

class NarratorWithAudio extends StatefulWidget {
  GeneralItem item;
  GeneralItemViewModel giViewModel;

  NarratorWithAudio({required this.item, required this.giViewModel});

  @override
  _NarratorWithAudioState createState() => new _NarratorWithAudioState();
}

class _NarratorWithAudioState extends State<NarratorWithAudio> {
  AudioRecordingStatus status = AudioRecordingStatus.stopped;
  LinkedList<LinkedListEntry> meteringList = new LinkedList<ItemEntry>();
  List<Response> deleted = [];

  int selectedItem = -1;
  FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  Duration? currentDuration;
  String? cp;

  @override
  void initState() {
    super.initState();
    openTheRecorder().then((value) {
      setState(() {});
    });
  }

  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    FlutterSoundRecorder? recorder = await _myRecorder.openAudioSession(
        focus: AudioFocus.requestFocusAndStopOthers,
        mode: SessionMode.modeSpokenAudio,
        category: SessionCategory.record);
    setState(() {
      _myRecorder = recorder ?? _myRecorder;
    });
  }

  Future _startRecording() async {
    String? customPath = await getCustomPath();
    setState(() {
      cp = customPath;
    });
    var status = await Permission.microphone.request();

    meteringList.addFirst(ItemEntry(0));
    await _myRecorder.setSubscriptionDuration(Duration(milliseconds: 200));

    _myRecorder.onProgress?.listen((event) {
      print('event ${event}');
      setState(() {
        meteringList.addFirst(ItemEntry(event.decibels));
        this.currentDuration = event.duration;
      });
    });
    await _myRecorder.startRecorder(toFile: customPath).then((value) {
      setState(() {});
    });
  }

  Future _stopRecording() async {
    String? test = await _myRecorder.stopRecorder();

    String? outputFileNull = await getCustomPath(extension: ".mp3");
    if (outputFileNull == null || cp == null) {
      return;
    }
    String outputFile = outputFileNull;

    await flutterSoundHelper.convertFile(
        cp, Codec.aacADTS, outputFile, Codec.mp3); //Codec.aacADTS
    if (widget.giViewModel.item != null &&
        widget.giViewModel.run?.runId != null) {
      widget.giViewModel.onDispatch(LocalAction(
        action: "answer_given",
        generalItemId: widget.giViewModel.item!.itemId,
        runId: widget.giViewModel.run!.runId!,
      ));
      widget.giViewModel.onDispatch(AudioResponseAction(
          audioResponse: AudioResponse(
              length: currentDuration?.inSeconds ?? 0,
              item: widget.item,
              path: outputFile,
              run: widget.giViewModel.run)));
      widget.giViewModel
          .onDispatch(SyncFileResponse(runId: widget.giViewModel.run!.runId!));
    }

    setState(() {
      meteringList.clear();
    });

    await _myRecorder.closeAudioSession();

    openTheRecorder().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (status) {
      case AudioRecordingStatus.stopped:
        {
          body = AudioListRecordings(
            pressRecord: () {
              setState(() {
                status = AudioRecordingStatus.recording;
                _startRecording();
              });
            }, item: widget.item,
          );
        }
        break;

      case AudioRecordingStatus.recording:
        {
          body = buildRecording(context);
        }
        break;

      case AudioRecordingStatus.paused:
        {
          body = AudioListRecordings(
            pressRecord: () {
              setState(() {
                status = AudioRecordingStatus.recording;
                _startRecording();
              });
            }, item: widget.item,
          );
        }
        break;
    }
    return GeneralItemWidget(
        item: this.widget.item,
        giViewModel: this.widget.giViewModel,
        padding: false,
        elevation: AudioRecordingStatus.stopped != status,
        body: Container(
            color: Color.fromRGBO(0, 0, 0, 0.8),
            child: body)
    );
  }

  Widget buildRecording(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(flex: 2),
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
      ],
    );
  }

  // Widget buildStopped(BuildContext context) {
  //   return
  // }


  @override
  void dispose() {
    _myRecorder.closeAudioSession();

    super.dispose();
  }

}

Future<String?> getCustomPath({String extension = ''}) async {
  String customPath = '/flutter_audio_recorder_';
  io.Directory? appDocDirectory;
  if (UniversalPlatform.isIOS) {
    appDocDirectory = await getApplicationDocumentsDirectory();
  } else {
    appDocDirectory = await getExternalStorageDirectory();
  }
  if (appDocDirectory == null) {
    return null;
  }
  return appDocDirectory.path +
      customPath +
      DateTime.now().millisecondsSinceEpoch.toString() +
      extension;
}
