import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youplay/models/response.dart';

import 'dismissible_background.dart';

class TextQuestionListEntries extends StatelessWidget {
  final List<Response> responses;
  final Function(Response) deleteResponse;
  TextQuestionListEntries({
    required this.responses,
    required this.deleteResponse,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // map.deleteAllResponses(this.deleted);
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat.yMMMMd(
        Localizations.localeOf(context).languageCode);
    return Expanded(
      child:
           ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
              ),
              itemCount: responses.length,
              itemBuilder: (context, index) {
                final DateTime thatTime =
                DateTime.fromMillisecondsSinceEpoch(
                    responses[index].timestamp);
                return Dismissible(
                    key: Key('${responses[index].timestamp}'),
                    background: DismissibleBackground(),
                    onDismissed: (direction) {
                      deleteResponse(responses[index]);
                      // setState(() {
                      //   this.deleted.add(map.getItem(index));
                      //   deleteResponse(map.delete(index));
                      //   map.deleteAllResponses(this.deleted);
                      // });
                    },
                    child: ListTile(
                      title: Text("${responses[index].value}",
                          style: TextStyle(color: Colors.white)),
                      trailing: Text(
                          '${formatter.format(thatTime)} ',
                          style: TextStyle(
                              color:
                              Colors.white.withOpacity(0.7))),
                    ));
              },
            )
          ,
    );
  }
}
