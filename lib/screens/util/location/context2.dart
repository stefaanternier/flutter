//
// import 'dart:async';
//
//
// import 'package:youplay/models/general_item.dart';
// import 'package:youplay/screens/util/location/gps_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
//
// @visibleForTesting
// typedef Location LocationFactory();
//
// @visibleForTesting
// void mockLocation(LocationFactory mock) {
//   _createLocation = mock;
// }
//
// LocationFactory _createLocation = () => Location();
//
//
// class LocationContext extends InheritedWidget {
//   final LocationData? currentLocation;
//   final LocationData? lastLocation;
//   final String? error;
//
//   LocationContext._({
//     required this.currentLocation,
//     this.lastLocation,
//     this.error,
//     Key? key,
//     required Widget child,
//   }) : super(key: key, child: child);
//
//   static LocationContext? of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType() as LocationContext?;
//   }
//
//   static Widget around(Widget child, List<LocationTrigger> points, Function onLocFound, {Key? key}) {
//     return _LocationContextWrapper(child: child,points:points,onLocationFound:onLocFound,key:  Key('__locationAr__'));
//   }
//
//
//   double? distanceFromItem(GeneralItem item) {
//     if (item.lat != null && item.lng != null) {
//       return distanceFrom(item.lat!, item.lng!);
//     }
//     return null;
//   }
//
//   double? distanceFrom(double lat, double lng) {
//     if (this.currentLocation == null
//         || currentLocation!.latitude == null
//         || currentLocation!.longitude == null) return null;
//     return GpsUtils.distance(lat, lng, currentLocation!.latitude!, currentLocation!.longitude!, 1);
//   }
//
//   @override
//   bool updateShouldNotify(LocationContext oldWidget) {
//     return currentLocation != oldWidget.currentLocation ||
//         lastLocation != oldWidget.lastLocation ||
//         error != oldWidget.error;
//   }
// }
//
// class _LocationContextWrapper extends StatefulWidget {
//   final Widget child;
//   final List<LocationTrigger> points;
//   final Function onLocationFound;
//
//   _LocationContextWrapper({Key? key, required this.points, required this.onLocationFound, required this.child}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _LocationContextWrapperState();
// }
//
// class _LocationContextWrapperState extends State<_LocationContextWrapper> {
//
//   final Location _location = _createLocation();
// //  LocationOptions locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 5);
//
//   String? _error;
//
//   LocationData? _currentLocation;
//   LocationData? _lastLocation;
//
//   late StreamSubscription<LocationData> _locationChangedSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _locationChangedSubscription = _location.onLocationChanged.listen((LocationData _position) {
//       print('$_position');
//         setState(() {
//           _error = null;
//           _lastLocation = _currentLocation;
//           _currentLocation = _position;
//           dynamic removePoint;
//           widget.points.forEach((point){
//             if (_position.latitude != null && _position.latitude != null&& _position.accuracy != null){
//               if (GpsUtils.distance(point.lat, point.lng, _position.latitude!, _position.longitude!, 1)
//                   < (point.radius-_position.accuracy!)) {
//                 print("location found ${point.lat} ${point.lng}");
//                 widget.onLocationFound(point.lat, point.lng, point.radius);
//                 removePoint = point;
//               } else {
//                 print ("distance is ${GpsUtils.distance(point.lat, point.lng, _position.latitude!, _position.longitude!, 1)}");
//               }
//             }
//
//           });
//           if (removePoint!=null) widget.points.remove(removePoint);
//         });
//     });
//     initLocation();
//   }
//
//   void initLocation() async {
// //    try {
//     final LocationData result = await _location.getLocation();
//
//     setState(() {
//       _error = null;
//       _lastLocation = result;
//       _currentLocation = _lastLocation;
//     });
//     //todo check what happens if permission is denied
// //    } on PlatformException catch (e) {
// //      setState(() {
// //        if (e.code == 'PERMISSION_DENIED') {
// //          _error = 'Location Permission Denied';
// //        } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
// //          _error =
// //          'Location Permission Denied. Please open App Settings and enabled Location Permissions';
// //        }
// //      });
// //    }
//   }
//
//   @override
//   void dispose() {
//     _locationChangedSubscription.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LocationContext._(
//       lastLocation: _lastLocation,
//       currentLocation: _currentLocation,
//       error: _error,
//       child: widget.child,
//     );
//   }
// }
