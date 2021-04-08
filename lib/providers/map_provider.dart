import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shelf/pages/profile_page.dart';

class MapProvider with ChangeNotifier {
  Set<Marker> markers = {};

  Future<BitmapDescriptor?> getCustomMarker() async {
    return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
          size: Size(5, 5),
        ),
        'assets/pics/marker.png');
  }

  fetchMarkers(BuildContext context, String userID) async {
    QuerySnapshot future = await FirebaseFirestore.instance
        .collection('users')
        .where('visibility', isEqualTo: true)
        .get();
    future.docs.forEach((userDoc) async {
      if (userDoc.id == userID) {
        var icon = await getCustomMarker();
        markers.add(Marker(
          markerId: MarkerId(userDoc.id),
          position: parseLatLang(userDoc.get('location')),
          icon: icon!,
          infoWindow: InfoWindow(
            title: 'Me',
            onTap: () => Navigator.of(context)
                .pushNamed(ProfilePage.routeName, arguments: userDoc.id),
          ),
        ));
      } else {
        markers.add(
          Marker(
            markerId: MarkerId(userDoc.id),
            position: parseLatLang(userDoc.get('location')),
            infoWindow: InfoWindow(
              title: userDoc.get('name'),
              onTap: () => Navigator.of(context)
                  .pushNamed(ProfilePage.routeName, arguments: userDoc.id),
            ),
          ),
        );
      }
    });
    if (markers.length > 0) notifyListeners();
  }

  LatLng parseLatLang(String coordenates) {
    List<String> parts = coordenates.split(',');
    return LatLng(double.parse(parts[0]), double.parse(parts[1]));
  }
}
