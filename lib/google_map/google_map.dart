import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class MyGoogleMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyGoogleMapState();
  }
}

class MyGoogleMapState extends State<MyGoogleMap> {
  Completer<GoogleMapController> _controller = Completer();
  final LatLng _center = const LatLng(45, -122);
  MapType _currentMapType = MapType.normal;
  _changeMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  getPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.location]);
    print(permissions);
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    print(permission);
    return permissions;
  }

  Future<void> _getMyLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude), 14));
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          onMapCreated: onMapCreated,
          initialCameraPosition: CameraPosition(target: _center, zoom: 11),
          mapType: _currentMapType,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          compassEnabled: true,
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: FloatingActionButton(
            child: Icon(Icons.map),
            onPressed: _changeMapType,
          ),
        ),
        Positioned(
          bottom: 5,
          left: 5,
          child: FloatingActionButton(
            child: Icon(Icons.my_location),
            onPressed: _getMyLocation,
          ),
        ),
      ],
    );
  }
}
