import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/ui/components/messages/chapter/chapter-widget.container.dart';
import 'package:youplay/ui/components/messages/text_question/dismissible_background.dart';

format(Duration d) {
  String retValue = d.toString().split('.').first.padLeft(8, "0");
  if (retValue.startsWith("00:")) {
    retValue = retValue.substring(3);
  }
  return retValue;
}

class VideoQuestionListEntries extends StatelessWidget {
  final List<Response> responses;
  final Function(Response) deleteResponse;
  final Function(Response) tapRecording;

  VideoQuestionListEntries(
      {required this.responses, required this.deleteResponse, required this.tapRecording, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // map.deleteAllResponses(this.deleted);
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
    return Expanded(
        child: ChapterWidgetContainer(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey,
          ),
          itemCount: responses.length,
          itemBuilder: (context, index) {
            final DateTime thatTime = DateTime.fromMillisecondsSinceEpoch(responses[index].timestamp);
            return Dismissible(
                key: Key('${responses[index].timestamp}'),
                background: DismissibleBackground(),
                onDismissed: (direction) {
                  deleteResponse(responses[index]);
                },
                child: ListTile(
                  title: Text('Nieuwe opname', style: TextStyle(color: Colors.white)),
                  subtitle:
                      Text('${formatter.format(thatTime)} ', style: TextStyle(color: Colors.white.withOpacity(0.7))),
                  trailing: Text("${format(new Duration(milliseconds: responses[index].length ?? 0))}",
                      style: TextStyle(color: Colors.white.withOpacity(0.7))),
                  onTap: () {
                    tapRecording(responses[index]);
                  },
                ));
          },
        ),
      ),
    ));
  }
}
