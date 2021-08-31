import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/screens/components/button/cust_raised_button.container.dart';
import 'package:youplay/screens/components/button/cust_raised_button.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../../../../localizations.dart';
import '../../../general_item.dart';
import 'game_themes.viewmodel.dart';
import 'next_button.dart';

class ThemedCard extends StatelessWidget {
  final Color primaryColor;
  final String buttonText;
  final String feedback;
  final Function() buttonClick;
  GeneralItem item;
  GeneralItemViewModel? giViewModel;

  ThemedCard(
      {required this.primaryColor,
      required this.buttonText,
      required this.feedback,
      required this.buttonClick,
      required this.item,
      this.giViewModel});

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, GameThemesViewModel>(
        converter: (store) => GameThemesViewModel.fromStore(store),
        builder: (context, GameThemesViewModel themeModel) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(25),
                    child: Text("${feedback}", style: AppConfig().customTheme!.cardTextStyle)),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(15, 0, 15, 12),
                //   child: Visibility(
                //     visible: this.giViewModel != null,
                //     child: this.giViewModel == null
                //         ? Container()
                //         : NextButton(
                //             buttonText: item.description != ""
                //                 ? item.description
                //                 : AppLocalizations.of(context).translate('screen.proceed'),
                //             overridePrimaryColor: giViewModel!.getPrimaryColor(),
                //             giViewModel: giViewModel!,
                //           ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 12),
                  // child: Visibility(
                  //     visible: this.giViewModel == null,
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
        });
  }
}
