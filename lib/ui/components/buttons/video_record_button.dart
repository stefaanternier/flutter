import 'package:flutter/material.dart';

class VideoRecordButton extends StatelessWidget {
  Function tapRecord;
  Function tapStop;
  bool isRecording;

  VideoRecordButton({
    required this.tapRecord,
    required this.tapStop,
    required this.isRecording,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
               ClipOval(
                  child: Material(
                    color: Colors.white, // button color
                    child:  this.isRecording  //status == VideoRecordingStatus.stopped
                        ? InkWell(
                            splashColor: Colors.black12, // inkwell color

                            child: SizedBox(
                              width: 94,
                              height: 94,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            width: 3, color: Colors.black)),
                                    // inkwell colo
                                    child: ClipOval(
                                        child: GestureDetector(
                                      onTap: () {
                                        tapRecord();
                                      },
                                      child: Material(
                                        color: Colors.red,
                                      ),
                                    ))),
                              ),
                            ),
                          )
                        : InkWell(
                            splashColor: Colors.red, // inkwell color
                            child: SizedBox(
                                width: 94,
                                height: 94,
                                child: Icon(
                                  Icons.stop,
                                  color: Colors.red,
                                  size: 50,
                                )),
                            onTap: () {
                              tapStop();
                            },
                          ),
                  ),
                ),

            ]),
      ],
    );
  }
}
