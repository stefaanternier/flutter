// // import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:youplay/config/app_config.dart';
// import 'package:youplay/models/general_item.dart';
// import 'package:youplay/models/general_item/narrator_item.dart';
// import 'package:youplay/screens/general_item/general_item.dart';
// import 'package:youplay/screens/general_item/util/messages/components/content_card.text.dart';
// import 'package:youplay/screens/general_item/util/messages/components/next_button.dart';
// import 'package:youplay/ui/components/next_button/next_button.container.dart';
//
// import 'generic_message.dart';
//
// class NarratorItemWidget extends StatefulWidget {
//   GeneralItem item;
//   GeneralItemViewModel giViewModel;
//
//   NarratorItemWidget({required this.item, required this.giViewModel});
//
//   @override
//   _NarratorItemWidgetState createState() => new _NarratorItemWidgetState();
// }
//
// class _NarratorItemWidgetState extends State<NarratorItemWidget> {
//   bool newLibrary = true;
//
//   @override
//   Widget build(BuildContext context) {
//     bool showButton =
//         widget.item.description != null && !widget.item.description.isEmpty;
//     bool hide = !showButton &&
//         ((widget.item.richText == null) || widget.item.richText.isEmpty);
//     bool showOnlyButton = false;
//     if (((widget.item.richText == null) || widget.item.richText.isEmpty) &&
//         showButton) {
//       showOnlyButton = true;
//     }
//
//     return GeneralItemWidget(
//       item: this.widget.item,
//       giViewModel: this.widget.giViewModel,
//       body: //(widget.item.richText != null &&  !widget.item.richText.isEmpty) ?
//
//           Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Padding(
//               padding: EdgeInsets.fromLTRB(15, 0, 15, 12),
//               child:
//               ContentCardText(
//                   title: (widget.giViewModel.item as NarratorItem).heading,
//                   text: widget.giViewModel.item?.richText,
//                    giViewModel: widget.giViewModel,
//                   button: (showButton || (widget.giViewModel.item !=null))
//                       ?
//                   NextButtonContainer(item: widget.giViewModel.item!)
//
//                       : null,
//                   )
//           )
//         ],
//       )
//
//     );
//   }
// }
