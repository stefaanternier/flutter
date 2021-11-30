import 'package:flutter/material.dart';

class CodeWordEntry extends StatelessWidget {

  final int index;
  final String? text;

  CodeWordEntry({
    this.text,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: SizedBox(
        height: 80,
        width: 30,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.end,

          children: [
            Positioned.fill(
              child: Align(
                  child: Text(
                    '${text}',
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
                    color: text == ' '?  Colors.grey :Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}

