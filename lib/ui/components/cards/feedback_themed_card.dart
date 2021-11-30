import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/ui/components/buttons/cust_raised_button.container.dart';

@immutable
class FeedbackThemedCard extends StatelessWidget {
  final Color primaryColor;
  final String buttonText;
  final String feedback;
  final Function() buttonClick;
  final GeneralItem item;

  FeedbackThemedCard({
    required this.primaryColor,
    required this.buttonText,
    required this.feedback,
    required this.buttonClick,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(25),
              child: Text("${feedback}", style: AppConfig().customTheme!.cardTextStyle)),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: AppConfig.isTablet() ? 290 : double.infinity,
                    height: 51.0,
                    child: CustomRaisedButtonContainer(
                      title: buttonText,
                      onPressed: this.buttonClick,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
