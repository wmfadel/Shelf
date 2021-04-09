import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/map_provider.dart';
import 'package:shelf/services/location_service.dart';

class HomeMap extends StatefulWidget {
  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  GoogleMapController? _controller;
  late AuthProvider authProvider;
  late MapProvider mapProvider;
  //Set<Marker> markers = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    mapProvider = Provider.of<MapProvider>(context);
    mapProvider.fetchMarkers(context, authProvider.uid!);
    // mapProvider.getMapMarket(authProvider.uid!);
    // fetchMarkers();
  }

  /* Future<BitmapDescriptor?> getCustomMarker() async {
    return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
          size: Size(5, 5),
        ),
        'assets/pics/marker.png');
  }*/
/*
  fetchMarkers() async {
    QuerySnapshot future = await FirebaseFirestore.instance
        .collection('users')
        .where('visibility', isEqualTo: true)
        .get();
    future.docs.forEach((userDoc) async {
      if (userDoc.id == authProvider.uid) {
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
    if (markers.length > 0) setState(() {});
  }
*/

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(30.0494817, 31.236408),
        zoom: 19,
      ),
      markers: mapProvider.markers,
      onMapCreated: (GoogleMapController controller) async {
        _controller = controller;
        String? location = await LocationService().getUserLocation();
        if (location != null) {
          _controller?.animateCamera(
            CameraUpdate.newLatLng(mapProvider.parseLatLang(location)),
          );
        }
        // setting state to allow map to apply padding correctly
        setState(() {});
      },
      padding: EdgeInsets.only(top: 100, right: 10, bottom: 200),
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
