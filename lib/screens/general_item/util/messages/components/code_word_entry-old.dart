import 'package:flutter/material.dart';
import 'package:youplay/models/game.dart';

class CodeWordEntry extends StatefulWidget {
  final Function valueChanged;
  final int index;

  final String? text;
  bool edit;
  final Function() removePrev;
  final Function() removeMe;
  final Function(String) addChar;

  CodeWordEntry({
    required this.valueChanged,
    this.text,
    required this.index,
    required this.edit,
    required this.removePrev,
    required this.removeMe,
    required this.addChar,
    Key? key,
  }) : super(key: key);

  @override
  State<CodeWordEntry> createState() => _CodeWordEntryState();
}

class _CodeWordEntryState extends State<CodeWordEntry> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (widget.edit) {
      return Container(
        // decoration: new BoxDecoration(
        //   color: Colors.green,
        // ),
        child: SizedBox(
            height: 80,
            width: 30,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    child: Container(
                        child: RawKeyboardListener(
                          focusNode: focusNode,
                          onKey: (RawKeyEvent event) {
                            if (event.logicalKey.keyLabel == 'Backspace') {
                              widget.removePrev();
                            }
                          },
                          child: TextField(
                            cursorColor: colorFromHex('#00A7FF'),
                            decoration: InputDecoration(

                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,

                            ),
                            autofocus: true,
                            onChanged: widget.addChar,
                            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        )),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    height: 4,
                    width: 30,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      );
    }

    return GestureDetector(
        onTap: widget.removeMe,
        child: Container(
          // decoration: new BoxDecoration(
          //   color: Colors.green,
          // ),
          child: SizedBox(
            height: 80,
            width: 30,
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.end,

              children: [
                Positioned.fill(
                  child: Align(
                      child: Text(
                        '${widget.text}',
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    height: 4,
                    width: 30,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.text == ' '?  Colors.grey :Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
