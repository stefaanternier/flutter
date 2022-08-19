import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/ui/components/icon/run_play_icon.dart';
import 'package:youplay/ui/components/messages/text_question/dismissible_background.dart';

class RunListEntry extends StatelessWidget {
  final String title;
  final int lastModificationDate;
  final GestureTapCallback onTap;
  final Function(Run) deleteRun;
  final Run run;
  final Color color;

  RunListEntry({
    required this.onTap,
    required this.run,
    required this.deleteRun,
    required this.title,
    required this.lastModificationDate,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat.yMMMMd(Localizations.localeOf(context).languageCode).add_jm();
    return Dismissible(
      key: Key("${run.runId}"),
      background: DismissibleBackground(),
      onDismissed: (direction) {
        deleteRun(run);
      },
      child: new ListTile(
        onTap: this.onTap,
        leading: RunPlayIcon(color: color),
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
        subtitle: Text('${formatter.format(DateTime.fromMillisecondsSinceEpoch(lastModificationDate))} '),
      ),
    );
  }
}
