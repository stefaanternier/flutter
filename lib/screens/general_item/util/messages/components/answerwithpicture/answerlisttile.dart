// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/screens/util/extended_network_image.dart';

class AnswerWithPictureTile extends StatelessWidget {
  Response response;
  Function tapPictureTile;

  AnswerWithPictureTile({required this.response, required this.tapPictureTile});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat.yMMMMd(Localizations
        .localeOf(context)
        .languageCode);
    final DateTime thatTime =
    DateTime.fromMillisecondsSinceEpoch(response.timestamp);
    print('response value ${response.value}');
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GestureDetector(
        onTap: () {
          if (tapPictureTile != null) {
            tapPictureTile(response);
          }
        },

        child: Row(
          children: [
            SizedBox(
              width: 79,
              height: 79,
              child: Container(
                decoration: getBoxDecoration('/${response.value}'),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${response.text??'Nieuwe opname'}', style: TextStyle(color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
                  Text('${formatter.format(thatTime)} ',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7), fontSize: 16)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
