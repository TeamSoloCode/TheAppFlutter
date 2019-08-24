import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class MyGoogleMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyGoogleMapState();
  }
}

class MyGoogleMapState extends State<MyGoogleMap> {
  final LatLng _center = const LatLng(45, -122);
  Completer<GoogleMapController> _controller = Completer();
  GoogleMap map;

  _getPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.location]);
    print(permissions);
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    print(permission);
    ServiceStatus serviceStatus =
        await PermissionHandler().checkServiceStatus(PermissionGroup.location);
    print(serviceStatus);
    
  }


  _findMyLocation() {
    setState(() {
      _getPermission();
      
    });
  }

  
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: _center, zoom: 11),
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          compassEnabled: true,
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: FloatingActionButton.extended(
            label: Text("My Location"),
            icon: Icon(Icons.my_location),
            onPressed: _findMyLocation,
          ),
        )
      ],
    );
  }
}
