import 'package:flutter/material.dart';

class ListSeparationText extends StatelessWidget {
  String text;

  ListSeparationText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Column(
            // padding: const EdgeInsets.all(8),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ]));
  }
}
