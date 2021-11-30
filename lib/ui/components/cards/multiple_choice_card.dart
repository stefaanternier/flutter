import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item/single_choice.dart';
import 'package:youplay/ui/components/buttons/cust_raised_button.container.dart';
import 'package:youplay/ui/components/messages/themed-checkbox-tile.container.dart';

class MultipleChoicesCard extends StatelessWidget {
  final List<ChoiceAnswer> answers;
  final Map<String, bool> selected;
  final Function changeSelection;
  final Function submitPressed;
  final bool buttonVisible;
  final String? buttonText;
  final String? text;

  MultipleChoicesCard({
    this.text,
    this.buttonText,
    required this.answers,
    required this.selected,
    required this.changeSelection,
    required this.buttonVisible,
    required this.submitPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: LimitedBox(
        maxHeight: MediaQuery.of(context).size.height * 0.66,
        child: Padding(
          padding: AppConfig.isTablet() ? const EdgeInsets.fromLTRB(20, 20, 20, 20) : const EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: getRows(context),
            ),
          ),
        ),
      ),
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
          child: Text("${text}",
              style: AppConfig.isTablet()
                  ? AppConfig().customTheme!.cardTitleStyleTablet
                  : AppConfig().customTheme!.cardTitleStyle)),
      visible: text != '' && text != null,
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
                    : ThemedCheckboxListTileContainer(
                        title: "${answers[(i / 2).floor()].answer}",
                        value: selected[answers[(i / 2).floor()].id] ?? false,
                        onChanged: (bool? value) {
                          changeSelection(value ?? true, (i / 2).floor(), answers[(i / 2).floor()].id);
                        },
                      ))));
  }

  _buildButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Visibility(
            visible: buttonVisible,
            child: Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                child:
                //todo this should not be a nextbutton (but answer button)
                // Container(),
                CustomRaisedButtonContainer(
                  title:  buttonText ?? 'todo',
                  onPressed: () {
                    submitPressed();
                  },
                )),
          ),
        ),
      ],
    );
  }
}
