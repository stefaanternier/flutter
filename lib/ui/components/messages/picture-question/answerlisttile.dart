// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/ui/components/messages/picture-question/answer_picture_icon.dart';

class AnswerWithPictureTile extends StatelessWidget {
  Response response;
  Function tapPictureTile;

  AnswerWithPictureTile({required this.response, required this.tapPictureTile});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
    final DateTime thatTime = DateTime.fromMillisecondsSinceEpoch(response.timestamp);
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GestureDetector(
        onTap: () {
          tapPictureTile(response);
        },
        child: Row(
          children: [
            AnswerPictureIcon(response: response),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${response.text ?? 'Nieuwe opname'}',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                  Text('${formatter.format(thatTime)} ',
                      style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
