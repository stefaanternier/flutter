import 'package:flutter/material.dart';

class RichTextTop extends StatelessWidget {

  Color color;
  String? richText;

  RichTextTop({
    required this.color,
    required this.richText,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: this.widget.giViewModel.getPrimaryColor(),
        color: color,
        child: Visibility(
          visible: richText != null,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "$richText",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ));
  }
}

