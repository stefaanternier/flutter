import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';

class CustomFlatButton extends StatelessWidget {
  Function onPressed;
  String title;
  IconData icon;
  Color color;

  CustomFlatButton({this.onPressed, this.title, this.icon, this.color = null});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 51.0,
      child: buildButton(context),
    );
  }

  buildButton(BuildContext context) {
    if (icon == null) {
      return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26.0),
              side: BorderSide(
                  width: 2, color: color != null ? color : AppConfig().themeData.primaryColor)),
          onPressed: () {
            onPressed();
          },
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              '$title',
              style: TextStyle(
                color: color != null ? color : AppConfig().themeData.primaryColor,
                fontSize: 22.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ));
    } else {
      return FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26.0),
            side: BorderSide(
                width: 2, color: color != null ? color : AppConfig().themeData.primaryColor)),
        onPressed: () {
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            new Icon(icon, color: color != null ? color : AppConfig().themeData.primaryColor),
            Flexible(
              flex: 1,

              child: Text(
                '$title',
                style: TextStyle(
                  color: color != null ? color : AppConfig().themeData.primaryColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      );

      return FlatButton.icon(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26.0),
              side: BorderSide(
                  width: 2, color: color != null ? color : AppConfig().themeData.primaryColor)),
          onPressed: () {
            onPressed();
          },
          icon: new Icon(icon, color: color != null ? color : AppConfig().themeData.primaryColor),
          label: Flexible(
            fit: FlexFit.loose,
            child: Text(
              'test tsets ese t set$title',
              style: TextStyle(
                color: color != null ? color : AppConfig().themeData.primaryColor,
                fontSize: 22.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ));
    }
  }
}
