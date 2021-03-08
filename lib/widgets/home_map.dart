import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shelf/pages/profile_page.dart';
import 'package:shelf/providers/auth_provider.dart';

class HomeMap extends StatefulWidget {
  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  GoogleMapController? _controller;
  late AuthProvider authProvider;
  Set<Marker> markers = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    fetchMarkers();
  }

  fetchMarkers() async {
    QuerySnapshot future = await FirebaseFirestore.instance
        .collection('users')
        .where('visibility', isEqualTo: true)
        .get();
    future.docs.forEach((userDoc) async {
      if (userDoc.id != authProvider.uid) {
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
    if (markers.length > 0) setState(() {});
  }

  LatLng parseLatLang(String coordenates) {
    List<String> parts = coordenates.split(',');
    return LatLng(double.parse(parts[0]), double.parse(parts[1]));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(30.0494817, 31.236408),
        zoom: 19,
      ),
      markers: markers,
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        String? location = authProvider.location;
        if (location != null) {
          _controller?.animateCamera(
            CameraUpdate.newLatLng(parseLatLang(location)),
          );
        }
        // setting state to allow map to apply padding correctly
        setState(() {});
      },
      padding: EdgeInsets.only(top: 100, right: 10),
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
    );
  }
}
