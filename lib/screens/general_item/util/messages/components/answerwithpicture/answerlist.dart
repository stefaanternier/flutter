import 'package:flutter/material.dart';
import 'package:youplay/models/response.dart';

import 'answerlisttile.dart';

class AnswerList extends StatelessWidget {
  List<Response> fromServer;
  Function tapResponse;
  Function deleteReponse;

  AnswerList({required this.fromServer,required  this.tapResponse, required this.deleteReponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: fromServer.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key('${fromServer[index].timestamp}'),
              background: slideLeftBackground(),
              onDismissed: (direction) {
                deleteReponse(fromServer[index].responseId);
                // setState(() {
                  // this.deleted.add(map.getItem(index));
                   //deleteResponse(map.delete(index));
                  // map.deleteAllResponses(this.deleted);
                // }
                // );
              },
              child: AnswerWithPictureTile(response: fromServer[index], tapPictureTile: tapResponse,)
            );
          }),
    );
  }


  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
