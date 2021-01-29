import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shelf/widgets/drawer_button.dart';

class HomePage extends StatelessWidget {
  static final String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(30.0494817, 31.236408),
                zoom: 17,
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
              top: 45,
              left: 20,
              child: DrawerButton(scaffoldContext: context),
            )
          ],
        ));
  }
}
