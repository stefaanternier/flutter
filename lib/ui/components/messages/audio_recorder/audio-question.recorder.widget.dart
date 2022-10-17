import 'dart:async';
import 'dart:collection';
import 'dart:io' as io;

import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_audio/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/log.dart';
import 'package:ffmpeg_kit_flutter_audio/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/buttons/audio_stop_button.dart';
import 'package:youplay/ui/components/messages/audio_recorder/audio_meter.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';

class AudioRecorder extends StatefulWidget {
  final GeneralItem item;
  Function(String, int) dispatchRecording;

  AudioRecorder({required this.item, required this.dispatchRecording, Key? key}) : super(key: key);

  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  LinkedList<LinkedListEntry> meteringList = new LinkedList<ItemEntry>();
  FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  Duration? currentDuration;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    openTheRecorder().then((value) {
      setState(() {});
      _startRecording();
    });
  }

  @override
  void dispose() {
    // _myRecorder.closeAudioSession();
    _myRecorder.closeRecorder();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ThemedAppbarContainer(title: widget.item.title, elevation: false),
        body: MessageBackgroundWidgetContainer(
            darken: true,
            child: Column(
              children: <Widget>[
                Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "nieuwe geluidsopname",
                      style: new TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14.0),
                    ),
                  ],
                ),
                Spacer(flex: 2),
                if (this.meteringList.isNotEmpty)
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 300),
                    painter: AudioMeter(meteringList: this.meteringList),
                  ),
                Spacer(flex: 2),
                AudioStopButton(onTap: () {
                  setState(() {
                    // status = AudioRecordingStatus.stopped;
                    isRecording = true;
                    _stopRecording();
                  });
                }),
                Spacer(flex: 2),
              ],
            )));
  }

  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status == PermissionStatus.permanentlyDenied) openAppSettings();
    print('microphone $status');
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    FlutterSoundRecorder? recorder =await _myRecorder.openRecorder();

    setState(() {
      _myRecorder = recorder ?? _myRecorder;
    });

    // FlutterSoundRecorder? recorder = await _myRecorder.openAudioSession( //todo reenable
    //     focus: AudioFocus.requestFocusAndStopOthers,
    //     mode: SessionMode.modeSpokenAudio,
    //     category: SessionCategory.record);
    // setState(() {
    //   _myRecorder = recorder ?? _myRecorder;
    //
    // });

    // await _myRecorder.startRecorder(
    //   codec: Codec.pcm16,
    //   // toStream: _mPlayer!.foodSink, // ***** THIS IS THE LOOP !!! *****
    //   sampleRate: 44000,
    //   numChannels: 1,
    // );
  }

  Future _startRecording() async {
    meteringList.addFirst(ItemEntry(0));
    await _myRecorder.setSubscriptionDuration(Duration(milliseconds: 200));

    _myRecorder.onProgress?.listen((event) {
      print('event ${event}');
      setState(() {
        meteringList.addFirst(ItemEntry(event.decibels));
        this.currentDuration = event.duration;
      });
    });
    String? cp = await getCustomPath();
    await _myRecorder.startRecorder(
        toFile: cp).then((value) {
      setState(() {});
    });
  }

  Future _stopRecording() async {
    String? test = await _myRecorder.stopRecorder();

    String? outputFileNull = await getCustomPath(extension: ".mp3");
    if (outputFileNull == null || test == null) {
      return;
    }

    // FlutterSoundHelper().pcmToWave(inputFile: inputFile, outputFile: outputFile)
    // await flutterSoundHelper.convertFile( //todo reenable
    //     test, Codec.aacADTS, outputFileNull, Codec.mp3); //Codec.aacADTS




    FFmpegKit.executeAsync('-i ${test} -c:v mp3 ${outputFileNull}', (Session session) async {
       widget.dispatchRecording(outputFileNull, currentDuration?.inSeconds ?? 0);

      setState(() {
        meteringList.clear();
      });

      await _myRecorder.closeRecorder();
    }, (Log log) {
      print('log ${log.getMessage()}');
    }, (dynamic statistics) {
print('stats $statistics');

    });


    // openTheRecorder().then((value) {
    //   setState(() {});
    // });
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
    return appDocDirectory.path + customPath + DateTime.now().millisecondsSinceEpoch.toString() + extension;
  }
}
