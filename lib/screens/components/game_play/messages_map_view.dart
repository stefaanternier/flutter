import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/screens/ui_models/message_view_model.dart';
import 'package:youplay/screens/util/location/context2.dart';
import 'package:youplay/store/state/app_state.dart';

class MessagesMapView extends StatefulWidget {
  List<ItemTimes> items = [];
  Function(GeneralItem) tapEntry;
  Game? game;
  MessagesMapView({this.game,required  this.items, required  this.tapEntry})
      : _kInitialPosition = CameraPosition(
          target: (game == null || game.lat == null || game.lng == null)
              ? LatLng(50.886959, 5.973426)
              : LatLng(game.lat!, game.lng!),
          zoom: 14.0,
        );

  CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(50.886959, 5.973426),
    zoom: 14.0,
  );

  @override
  _MessagesMapViewState createState() => _MessagesMapViewState();
}

class _MessagesMapViewState extends State<MessagesMapView> {
  StreamSubscription<LocationData>? _locationChangedSubscription;

  Completer<GoogleMapController> _controller = Completer();

  LocationData? _locationData;

  @override
  void initState() {
    super.initState();
    // initLoc();
  }

  void initLoc(GoogleMapController controller) async {
    bool _serviceEnabled;
    Location location = new Location();
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    LocationData locationData = await location.getLocation();
    if (locationData != null && locationData.latitude!=null&& locationData.longitude!=null) {
      controller.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(locationData.latitude!, locationData.longitude!), 17));
    }
  }

  @override
  Widget build(BuildContext context) {
    LocationData? data = LocationContext.of(context)?.lastLocation;
    // print("data is ${data.latitude}");
    List<Marker> markers = [];
    widget.items
        .where((element) =>
            element.generalItem.showOnMap == null ||
            element.generalItem.showOnMap)
        .forEach((item) {
      if (item.generalItem.lat != null) {
        markers.add(buildMarker(item.generalItem, () {
          widget.tapEntry(item.generalItem);
        }));
      }
    });
    Set<Marker> _markers = Set<Marker>.of(markers);
    return GoogleMap(
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      ].toSet(),
      mapType: MapType.normal,
      markers: _markers,
      initialCameraPosition: widget._kInitialPosition,
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        initLoc(controller);
      },
    );
  }

  Marker buildMarker(GeneralItem generalItem, Function onTap) {
    return Marker(
      markerId: MarkerId("${generalItem.itemId}"),
      position: LatLng(generalItem.lat??50, generalItem.lng??6),
      infoWindow: InfoWindow(
          title: "${generalItem.title}",
//              snippet: '*',
          onTap: () {
            print("tap ${generalItem.title}");
            if (generalItem != null) {
              print("tap ${generalItem.title}");
              onTap();
            }
            ;
          }),
      onTap: () {},
    );
  }
}
