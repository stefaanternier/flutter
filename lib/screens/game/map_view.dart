// import 'dart:async';
// import 'dart:collection';
//
// import 'package:youplay/models/general_item.dart';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:youplay/screens/ui_models/message_view_model.dart';
//
// class MapView extends StatefulWidget {
//   MessageViewModel messageViewModel;
//   MapView({required this.messageViewModel});
//
//   @override
//   State createState() => _MapViewState();
// }
//
// class _MapViewState extends State<MapView> {
// //  MessageViewModel messageViewModel;
//
//
//   HashMap<Marker, int> markerMap = new HashMap();
//   Completer<GoogleMapController> _controller = Completer();
//   Set<Marker> _markers = Set<Marker>.of([]);
//
//   static final CameraPosition _kInitialPosition = const CameraPosition(
//     target: LatLng(50.886959, 5.973426),
//     zoom: 14.0,
//   );
//   GoogleMapController? mapController;
//
//   _MapViewState();
//
//   @override
//   initState() {
//     super.initState();
//     List<Marker> markers = [];
//     for (int i= 0; i<widget.messageViewModel.items.length;i++) {
//       if (widget.messageViewModel.items[i].generalItem.lat != null){
//
//             markers.add(buildMarker(widget.messageViewModel.items[i].generalItem));
//
//       }
//
//     }
//     _markers = Set<Marker>.of(markers);
//
//   }
//
//
//   Marker buildMarker(GeneralItem generalItem) {
//     return Marker(
//       markerId:  MarkerId("${generalItem.itemId}"),
//       position: LatLng(generalItem.lat??50, generalItem.lng??6),
//       infoWindow: InfoWindow(
//           title: "${generalItem.title}",
// //              snippet: '*',
//           onTap: () {
//             print("tap ${generalItem.title}");
//             if (generalItem != null) _onMarkerTapped(generalItem);
//           }
//       ),
//       onTap: () {
//
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
// //    Set<Marker> markers = Set
//
// print("rebuild triggered");
// setState(() {
//   List<Marker> markers = [];
//   for (int i= 0; i<widget.messageViewModel.items.length;i++) {
//     if (widget.messageViewModel.items[i].generalItem.lat != null){
//
//       markers.add(buildMarker(widget.messageViewModel.items[i].generalItem));
//
//     }
//
//   }
//   _markers = Set<Marker>.of(markers);
//   print("length markesr ${_markers.length} - ${widget.messageViewModel.items.length}");
//
// });
//
//     return GoogleMap(
//       gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
//         Factory<OneSequenceGestureRecognizer>(
//           () => EagerGestureRecognizer(),
//         ),
//       ].toSet(),
//       initialCameraPosition: _kInitialPosition,
//       onMapCreated: (GoogleMapController controller) {
//         _controller.complete(controller);
// //        for (int i= 0; i<messageViewModel.items.length;i++) {
// //          controller.
// //        }
//       },
//       markers: _markers,
//       myLocationEnabled: true,
// //      trackCameraPosition: true,
//     );
//   }
// //        icon: BitmapDescriptor.fromAsset(
// //            "graphics/generalItems/narratorType.png"),
//
//
//
//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       mapController = controller;
// //      controller.onMarkerTapped.add(_onMarkerTapped);
// //      for (int i= 0; i<messageViewModel.items.length;i++) {
// //        if (messageViewModel.items[i].generalItem.lat != null){
// //          int copyOfI = i;
// //          controller.addMarker(MarkerOptions(
// //            position: LatLng(messageViewModel.items[i].generalItem.lat, messageViewModel.items[i].generalItem.lng),
// //          )).then((marker)=> markerMap.putIfAbsent(marker, ()=>copyOfI));
// //        }
// //      }
//     });
//   }
//
//   void _onMarkerTapped(GeneralItem item) {
//
//
//     widget.messageViewModel.giItemTapAction(item, context)();
//   }
// }
