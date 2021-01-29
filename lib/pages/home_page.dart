import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {
  static final String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
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
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2,
              sigmaY: 2,
              tileMode: TileMode.decal,
            ),
            child: Container(
              height: 90,
              width: _size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.8),
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.2),
                    ]),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
