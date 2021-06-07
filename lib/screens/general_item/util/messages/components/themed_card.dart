import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../../../../localizations.dart';
import '../../../general_item.dart';
import 'game_themes.viewmodel.dart';
import 'next_button.dart';

class ThemedCard extends StatelessWidget {
  final Color primaryColor;
  final String buttonText;
  final String feedback;
  final Function buttonClick;
  GeneralItem item;
  GeneralItemViewModel giViewModel;

  ThemedCard(
      {this.primaryColor,
      this.buttonText,
      this.feedback,
      this.buttonClick,
      this.item,
      this.giViewModel});

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, GameThemesViewModel>(
        converter: (store) => GameThemesViewModel.fromStore(store),
        builder: (context, GameThemesViewModel themeModel) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(25),
                    child: Text("${feedback}", style: AppConfig().customTheme.cardTextStyle)),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 12),
                  child: Visibility(
                    visible: this.giViewModel != null,
                    child: this.giViewModel == null
                        ? Container()
                        : NextButton(
                            buttonText: item.description != ""
                                ? item.description
                                : AppLocalizations.of(context).translate('screen.proceed'),
                            overridePrimaryColor: giViewModel.getPrimaryColor(),
                            giViewModel: giViewModel,
                          ),
                  ),
                ),
                Visibility(
                  visible: this.giViewModel == null,
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          '${buttonText}',
                          style: AppConfig().customTheme.nextButtonStyle,
                        ),
                        color: primaryColor != null ? primaryColor : themeModel.getPrimaryColor(),
                        onPressed: this.buttonClick,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
