// import 'package:flutter/material.dart';
// import 'package:youplay/config/app_config.dart';
//
// class ContentCard extends StatelessWidget {
//
//   Widget? content;
//   Widget? button;
//   bool showOnlyButton;
//
//   ContentCard(
//       { this.content, this.button, this.showOnlyButton = false});
//
//   @override
//   Widget build(BuildContext context) {
//     if (this.showOnlyButton) {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: getRows(context),
//       );
//     }
//     return Card(
//       child: LimitedBox(
//         maxHeight: MediaQuery.of(context).size.height*0.66,
//
//         child: Padding(
//           padding: AppConfig.isTablet()
//               ? const EdgeInsets.fromLTRB(20, 20, 20, 20)
//               : const EdgeInsets.all(10),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: getRows(context),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> getRows(BuildContext context) {
//     return [
//       Visibility(
//         visible: !this.showOnlyButton,
//         child: Container(
//           padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
//           child: getContent(context),
//         ),
//       ),
//       Visibility(
//         visible: button != null,
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
//           child: Column(children: button == null? []:[button!]),
//         ),
//       )
//     ];
//   }
//
//   getContent(BuildContext context) {
//
//     if (this.content == null) return Container();
//     return this.content;
//   }
// }
