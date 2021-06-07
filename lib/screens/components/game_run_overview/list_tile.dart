import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_app_bar.viewmodel.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:intl/intl.dart';

class RunListTile extends StatelessWidget {
  final String title;
  int lastModificationDate;
  final GestureTapCallback onTap;
  // Color iconColor;

  RunListTile({this.onTap, this.title, this.lastModificationDate});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
    return new StoreConnector<AppState, ThemedAppBarViewModel>(
        converter: (store) => ThemedAppBarViewModel.fromStore(store),
        builder: (context, ThemedAppBarViewModel themeModel) {
          return  new ListTile(
            onTap: this.onTap,

            leading:  SizedBox(
              width: 44,
              height: 44,
              child: ClipOval(
                child: Material(
                  color: themeModel.getPrimaryColor(), // button color
                  child: InkWell(
                    splashColor: themeModel.getPrimaryColor(),
                    child: SizedBox(
                        width: 44,
                        height: 44,
                        child: Icon(
                          FontAwesomeIcons.play,
                          size: 15,
                          color: Colors.white,
                        )),

                  ),
                ),
              ),
            ),
            // leading: Icon(
            //   FontAwesomeIcons.playCircle,
            // ),
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Flexible(
                    child: new Text(
                      "${title}",
                      style: AppConfig().customTheme.runListEntryTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
              ],
            ),
            subtitle: Text(
                '${formatter.format(DateTime.fromMillisecondsSinceEpoch(lastModificationDate))} '),
//          subtitle: new Container(
//            child: new Text(
//              title,
//            ),
//          ),

          );
        });
  }
}
