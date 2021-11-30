import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_app_bar.viewmodel.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/icon/run_play_icon.dart';
import 'package:youplay/ui/components/messages/text_question/dismissible_background.dart';

class RunListEntry extends StatelessWidget {
  final String title;
  int lastModificationDate;
  final GestureTapCallback onTap;
  final Function(Run) deleteRun;
  final Run run;
  // Color iconColor;

  RunListEntry({required this.onTap,
    required this.run,
    required this.deleteRun,
    required this.title,required  this.lastModificationDate});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
    return new StoreConnector<AppState, ThemedAppBarViewModel>(
        converter: (store) => ThemedAppBarViewModel.fromStore(store),
        builder: (context, ThemedAppBarViewModel themeModel) {
          return  Dismissible(
            key: Key("${run.runId}"),
            background: DismissibleBackground(),
            onDismissed: (direction) {
              deleteRun(run);
            },
            child: new ListTile(
              onTap: this.onTap,

              leading:  RunPlayIcon(color:themeModel.getPrimaryColor()),

              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Flexible(
                      child: new Text(
                        "${title}",
                        style: AppConfig().customTheme!.runListEntryTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
              subtitle: Text(
                  '${formatter.format(DateTime.fromMillisecondsSinceEpoch(lastModificationDate))} '),

            ),
          );
        });
  }
}
