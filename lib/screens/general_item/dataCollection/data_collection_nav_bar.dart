//
// import 'package:youplay/models/general_item/open_question.dart';
// import 'package:youplay/screens/general_item/dataCollection/fab_layout.dart';
// import 'package:youplay/screens/general_item/dataCollection/fab_with_icons.dart';
// import 'package:youplay/screens/general_item/dataCollection/picture.dart';
// import 'package:flutter/material.dart';
//
//
// class DataCollectionNavBarItem {
//   DataCollectionNavBarItem({this.iconData, this.text});
//   IconData iconData;
//   String text;
// }
//
// class DataCollectionNavBar extends StatefulWidget {
//   OpenQuestion openQuestion;
//
//   DataCollectionNavBar({
//     this.openQuestion,
// //    this.items,
//     this.centerItemText,
//     this.height: 60.0,
//     this.iconSize: 24.0,
//     this.backgroundColor,
//     this.color,
//     this.selectedColor,
//     this.notchedShape,
//     this.onTabSelected,
//
//   }) {
//
//     this.items = [];
//     if (this.openQuestion.withPicture) this.items..add(DataCollectionNavBarItem(iconData: Icons.camera_alt, text: 'Picture'));
//     if (this.openQuestion.withVideo) this.items..add(DataCollectionNavBarItem(iconData: Icons.videocam, text: 'Video'));
//     if (this.openQuestion.withAudio) this.items..add(DataCollectionNavBarItem(iconData: Icons.mic, text: 'Audio'));
//     if (this.openQuestion.withText) this.items..add(DataCollectionNavBarItem(iconData: Icons.edit, text: 'Text'));
//     if (this.openQuestion.withValue) this.items..add(DataCollectionNavBarItem(iconData: Icons.dialpad, text: 'Value'));
//   }
//    List<DataCollectionNavBarItem> items;
//   final String centerItemText;
//   final double height;
//   final double iconSize;
//   final Color backgroundColor;
//   final Color color;
//   final Color selectedColor;
//   final NotchedShape notchedShape;
//   final ValueChanged<int> onTabSelected;
//
//   @override
//   State<StatefulWidget> createState() => DataCollectionNavBarState();
// }
//
// class DataCollectionNavBarState extends State<DataCollectionNavBar> {
//   int _selectedIndex = 0;
//
//   _updateIndex(int index) {
//     //widget.onTabSelected(index);
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> items = List.generate(widget.items.length, (int index) {
//       return _buildTabItem(
//         item: widget.items[index],
//         index: index,
//         onPressed: _updateIndex,
//       );
//     });
//     items.insert(items.length , _buildMiddleTabItem());
//
//     return BottomAppBar(
//       shape: widget.notchedShape,
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: items,
//       ),
//       color: widget.backgroundColor,
//     );
//   }
//
//   Widget _buildMiddleTabItem() {
//     return Expanded(
//       child: SizedBox(
//         height: widget.height,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(height: widget.iconSize),
//             Text(
//               widget.centerItemText ?? '',
//               style: TextStyle(color: widget.color),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTabItem({
//     DataCollectionNavBarItem item,
//     int index,
//     ValueChanged<int> onPressed,
//   }) {
//     Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
//     return Expanded(
//       child: SizedBox(
//         height: widget.height,
//         child: Material(
//           type: MaterialType.transparency,
//           child: InkWell(
//             onTap: () => onPressed(index),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Icon(item.iconData, color: color, size: widget.iconSize),
//                 Text(
//                   item.text,
//                   style: TextStyle(color: color),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class DataCollectionFAB extends StatelessWidget {
//
//   OpenQuestion openQuestion;
//   final Function onTakePictureSelected;
//   bool show;
//
//   DataCollectionFAB({this.openQuestion,this.onTakePictureSelected,this.show});
//
//   @override
//   Widget build(BuildContext context) {
//     List<IconData> icons = [];
//     if (this.openQuestion.withPicture) icons..add(Icons.camera_alt);
//     if (this.openQuestion.withVideo) icons..add(Icons.videocam);
//     if (this.openQuestion.withAudio) icons..add( Icons.mic);
//     if (this.openQuestion.withText) icons..add( Icons.edit);
//     if (this.openQuestion.withValue) icons..add( Icons.dialpad);
// print("building overlay!!!");
//     AnchoredOverlay overlay= AnchoredOverlay(
//       showOverlay: this.show,
//       overlayBuilder: (context, offset) {
//         return CenterAbout(
//           position: Offset(offset.dx, offset.dy - icons.length * 35.0),
//           child: FabWithIcons(
//             icons: icons,
//           onIconTapped: (index) {
//             if (icons[index] == Icons.camera_alt) {
//
//               onTakePictureSelected();
// //              Navigator.push(
// //                context,
// //                MaterialPageRoute(
// //                    builder: (context) => CameraExampleHome()),
// //              );
//             }
//               print("ico $index tapped");
//           },
//           ),
//         );
//       },
//       child: FloatingActionButton(
//         onPressed: () { },
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//         elevation: 2.0,
//       ),
//     );
// //    print ("overlay is ${overlay.wi} ");
//     return overlay;
//   }
//
//
// }
