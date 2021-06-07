import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/screens/general_item/util/messages/components/game_themes.viewmodel.dart';
import 'package:youplay/store/state/app_state.dart';

class CustomRaisedButton extends StatelessWidget {
  Function onPressed;
  String title;
  Icon icon;
  bool useThemeColor;
  Color primaryColor;
  bool disabled;

  CustomRaisedButton(
      {this.onPressed,
      this.title,
      this.icon,
      this.useThemeColor = false,
      this.primaryColor,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: AppConfig.isTablet() ? 290 : double.infinity,
          height: 51.0,
          child: buildButton(context),
        ),
      ],
    );
  }

  buildButton(BuildContext context) {
    if (!useThemeColor) {
      return buildRawButton(null);
    }
    return new StoreConnector<AppState, GameThemesViewModel>(
        converter: (store) => GameThemesViewModel.fromStore(store),
        builder: (context, GameThemesViewModel themeModel) {
          return buildRawButton(themeModel);
        });
  }

  buildRawButton(GameThemesViewModel themeModel) {
    if (icon == null) {
      return RaisedButton(
          color: (this.primaryColor != null)
              ? this.primaryColor
              : (themeModel == null ? null : themeModel.getPrimaryColor()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26.0),
          ),
          onPressed: disabled
              ? null
              : () {
                  onPressed();
                },
          child: Text(
            '$title',
            style: AppConfig().customTheme.nextButtonStyle,
          ));
    } else {
      return RaisedButton.icon(
          color: (this.primaryColor != null)
              ? this.primaryColor
              : (themeModel == null ? null : themeModel.getPrimaryColor()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26.0),
          ),
          onPressed: disabled
              ? null
              : () {
                  onPressed();
                },
          icon: icon,
          label: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
            ),
          ));
    }
  }
}
