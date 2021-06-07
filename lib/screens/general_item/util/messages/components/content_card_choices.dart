import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item/single_choice.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../../../../localizations.dart';
import '../../../general_item.dart';
import 'content_card.dart';
import 'game_themes.viewmodel.dart';
import 'next_button.dart';

class ContentCardChoices extends ContentCard {
  List<ChoiceAnswer> answers;
  Map<String, bool> selected;
  Function changeSelection;
  Function submitPressed;
  Color overridePrimaryColor;
  bool buttonVisible;

  ContentCardChoices(
      {GeneralItemViewModel giViewModel,
      this.answers,
      this.selected,
      this.changeSelection,
      this.submitPressed,
      this.buttonVisible,
      this.overridePrimaryColor})
      : super(item: giViewModel.item, content: null, button: null, giViewModel: giViewModel);

  @override
  getContent(BuildContext context) {
    return Text(
      "${item.richText}",
      style: AppConfig.isTablet()
          ? AppConfig().customTheme.cardTitleStyleTablet
          : AppConfig().customTheme.cardTitleStyle,
    );
  }

  @override
  List<Widget> getRows(BuildContext context) {
    return [_buildQuestion(), _buildOptions(), _buildButton(context)];
  }

  _buildQuestion() {
    return Visibility(
      child: Container(
          padding: const EdgeInsets.all(10),
          child: Text("${(item as dynamic).text}",
              style: AppConfig.isTablet()
                  ? AppConfig().customTheme.cardTitleStyleTablet
                  : AppConfig().customTheme.cardTitleStyle)),
      visible: (item as dynamic).text != '' && (item as dynamic).text != null,
    );
  }

  _buildOptions() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List<Widget>.generate(
                answers.length * 2 - 1,
                (i) => (i % 2) == 1
                    ? Divider(
                        height: 2,
                        color: Colors.black,
                      )
                    : CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: giViewModel.getPrimaryColor(),
                        title: Text("${answers[(i / 2).floor()].answer}",
                            style: AppConfig().customTheme.mcOptionTextStyle),
                        value: selected[answers[(i / 2).floor()].id],
                        onChanged: (bool value) {
                          changeSelection(value, (i / 2).floor(), answers[(i / 2).floor()].id);
                        },
                      ))));
  }

  _buildButton(BuildContext context) {
    return new StoreConnector<AppState, GameThemesViewModel>(
        converter: (store) => GameThemesViewModel.fromStore(store),
        builder: (context, GameThemesViewModel themeModel) {
          return Row(

            children: [
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: buttonVisible,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                    child: NextButton(
                      buttonText: item.description != ""
                          ? item.description
                          : AppLocalizations.of(context).translate('screen.proceed'),
                      // overridePrimaryColor: themeModel.getPrimaryColor(),
                      giViewModel: giViewModel,
                      overrideButtonPress: submitPressed,
                      makeVisible: buttonVisible,
                    ),
                  ),
                ),
              ),
            ],
          );
          // return ButtonBar(children: [
          //   RaisedButton(
          //     color: overridePrimaryColor != null
          //         ? overridePrimaryColor
          //         : themeModel.getPrimaryColor(), // giViewModel.getPrimaryColor(),
          //     splashColor: Colors.red,
          //     child: Text(
          //       AppLocalizations.of(context).translate('screen.next'),
          //       style: AppConfig().customTheme.nextButtonStyle,
          //     ),
          //     onPressed: submitPressed,
          //   )
          // ]);
        });
  }
}
