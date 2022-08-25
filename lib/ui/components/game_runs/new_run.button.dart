import 'package:flutter/material.dart';
import 'package:youplay/ui/components/buttons/cust_raised_button.container.dart';

class NewRunButton extends StatelessWidget {
  final Function(BuildContext) onPressed;
  final String? title;
  const NewRunButton({required this.onPressed, this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
        child: CustomRaisedButtonContainer(
          title: title ?? 'nieuwe groep',
          onPressed: () {
            onPressed(context);
          },
        ));
  }
}
