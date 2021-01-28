import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  static final String routeNAme = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(30.0494817, 31.236408),
            zoom: 19,
          ),
          myLocationEnabled: true,
          indoorViewEnabled: true,
          buildingsEnabled: true,
          compassEnabled: true,
          mapToolbarEnabled: true,
          myLocationButtonEnabled: true,
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
        ),
        Positioned(
          child: Row(
            children: [
              Expanded(child: Container()),
              // GoogleUserCircleAvatar(identity: GoogleIdentity())
            ],
          ),
          top: 20,
        ),
      ],
    ));
  }
}
