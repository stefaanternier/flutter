// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:youplay/screens/components/button/cust_raised_button.dart';
// import 'package:youplay/store/state/app_state.dart';
//
// import '../../../general_item.dart';
// import 'game_themes.viewmodel.dart';
//
// //deprecated delete me
// class NextButton extends StatefulWidget {
//   String buttonText;
//   Function? overrideButtonPress;
//   Color? overridePrimaryColor;
//   GeneralItemViewModel giViewModel;
//   Widget? customButton;
//   bool makeVisible;
//
//   //todo deprecated. todo delete
//   NextButton(
//       {required this.buttonText,
//       required this.giViewModel,
//       this.overridePrimaryColor,
//       this.overrideButtonPress,
//       this.customButton,
//       this.makeVisible = false});
//
//   @override
//   _NextButtonState createState() => _NextButtonState();
// }
//
// class _NextButtonState extends State<NextButton> {
//   Timer? _timer;
//
//   @override
//   void dispose() {
//     super.dispose();
//     _timer?.cancel();
//   }
//
//   @override
//   build(BuildContext context) {
//     if (this.widget.buttonText != null &&
//         this.widget.buttonText.contains("::")) {
//       int index = this.widget.buttonText.indexOf("::");
//       this.widget.buttonText = this.widget.buttonText.substring(0, index);
//     }
//     int now = new DateTime.now().millisecondsSinceEpoch;
//     if (((this.widget.giViewModel.nextItem?.lastModificationDate??0) - now) > 0) {
//       _timer?.cancel();
//       _timer = new Timer(const Duration(milliseconds: 1000), () {
//         setState(() {
//           print("setting state");
//         });
//       });
//     }
//
//     return new StoreConnector<AppState, GameThemesViewModel>(
//         converter: (store) => GameThemesViewModel.fromStore(store),
//         builder: (context, GameThemesViewModel themeModel) {
//           return Visibility(
//             visible: widget.makeVisible ||
//                 (this.widget.giViewModel.nextItem != null &&
//                     ((this.widget.giViewModel.nextItem?.lastModificationDate??0) -
//                             now) <
//                         0),
//             child: CustomRaisedButton(
//               title: '${widget.buttonText}',
//               primaryColor: widget.overridePrimaryColor != null
//                   ? widget.overridePrimaryColor
//                   : this.widget.giViewModel.getPrimaryColor(),
//               onPressed: () {
//                 pressButton();
//               },
//             ),
//           );
//         });
//   }
//
//   pressButton() {
//     if (widget.overrideButtonPress != null) {
//       this.widget.overrideButtonPress!();
//     } else {
//       if (!this.widget.giViewModel.continueToNextItem(context)) {
//         new Future.delayed(const Duration(milliseconds: 200), () {
//           this.widget.giViewModel.continueToNextItem(context);
//         });
//       }
//     }
//   }
// }
