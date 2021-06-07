// import 'package:flutter/material.dart';
//
// class SplashScreenButton extends StatelessWidget {
// //  final Widget child;
//   final Color gradientColor1;
//   final Color gradientColor2;
//   final double width;
//   final double height;
//   final Function onPressed;
//   final String label;
//   final String image;
//   const SplashScreenButton({
//     Key key,
// //    @required this.child,
//     this.label,
//     this.image,
//     this.gradientColor1,
//     this.gradientColor2,
//     this.width = double.infinity,
//     this.height = 50.0,
//     this.onPressed,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: 50.0,
// //      padding: EdgeInsets.all(5.0),
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//               colors: [
//                 this.gradientColor1,
//                 this.gradientColor2,
//               ], // whitish to gray
//               begin: Alignment.topLeft
// //                  colors: <Color>[Colors.green, Colors.black],
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey[500],
//               offset: Offset(0.0, 1.5),
//               blurRadius: 1.5,
//             ),
//           ]),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//             onTap: onPressed,
//             child: Center(
//               child: Container(
//                   padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                             child: Image.asset(
//                               this.image,
//                             )),
//                         Text(this.label,
//                             style: TextStyle(
// //                              fontWeight: FontWeight.bold,
//                               fontSize: 20.0,
//                               color: const Color(0xFFFFFFFF),
//                             ))
//                       ])),
//             )),
//       ),
//     );
//   }
// }
