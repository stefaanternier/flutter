import 'package:flutter/material.dart';

class ReadIndication extends StatelessWidget {
  Color primaryColor;

  ReadIndication({required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          color: primaryColor,

          borderRadius: BorderRadius.only(topRight: Radius.circular(3), bottomRight: Radius.circular(3), ),
          border: Border.all(color: primaryColor)

      ),

    );
  }
}
