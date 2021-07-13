import 'package:youplay/config/app_config.dart';
import 'package:flutter/material.dart';

import '../../../localizations.dart';

// class FeaturedGameCard extends StatelessWidget {
//   String overline;
//   String headline;
//   String body;
//   String iconUrl;
//   int gameId;
//   Function onGameClicked;
//
//   FeaturedGameCard({this.overline, this.headline, this.body, this.gameId, this.onGameClicked});
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Card(
//       child: Container(
//         decoration: new BoxDecoration(
//           borderRadius: new BorderRadius.circular(18.0),
//           color: Theme.of(context).dialogBackgroundColor,
//         ),
//         padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               flex: 4,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("$overline", style: Theme.of(context).textTheme.overline),
// //                    Flexible(child:
//                   Text("$headline", style: Theme.of(context).textTheme.headline),
//                   Text("$body",
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                       style: Theme.of(context).textTheme.body1),
//                   Container(
//                       alignment: Alignment.bottomLeft,
//                       child: RaisedButton(
//                         child: Text(
//                           AppLocalizations.of(context).translate('library.start'),
//                         ),
//                         onPressed: onGameClicked,
//                       )),
//                 ],
//               ),
//             ),
//             Expanded(
//                 flex: 2,
//                 child: AspectRatio(
//                     aspectRatio: 1,
//                     child: iconUrl != null
//                         ? Container(
//                             decoration: new BoxDecoration(
//                                 image: new DecorationImage(
//                                     fit: BoxFit.cover, image: new NetworkImage(iconUrl))),
//                           )
//                         : Container())),
//           ],
//         ),
//       ),
// //      ),
//     );
//   }
// }
