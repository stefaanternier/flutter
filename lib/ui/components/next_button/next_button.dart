


import 'package:flutter/material.dart';
import 'package:youplay/ui/components/buttons/cust_raised_button.dart';

class NextButton extends StatelessWidget {

  bool visible;
  String buttonText = '';
  Color color;
  Function pressButton;

  NextButton({
    required this.visible,
    required this.buttonText,
    required this.color,
    required this.pressButton,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: CustomRaisedButton(
        title: '${buttonText}',
        primaryColor: color,
        onPressed: () {
          pressButton();
        },
      ),
    );
  }
}
