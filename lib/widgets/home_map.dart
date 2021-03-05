import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';

class HomeMap extends StatefulWidget {
  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  GoogleMapController? _controller;
  late AuthProvider authProvider;
  Set<Marker> markers = {};
/*
snapshot.data?.docs.forEach((QueryDocumentSnapshot doc) {
              if (doc.id != authProvider.uid)
                markers.add(
                  Marker(
                    markerId: MarkerId(doc.id),
                    position: parseLatLang(doc.get('location')),
                  ),
                );
            });
          }
          print('doc count ${snapshot.data?.docs.length}');
          print('markers length ${markers.length}');*/

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
    future.docs.forEach((element) {
      if (element.id != authProvider.uid)
        markers.add(
          Marker(
            markerId: MarkerId(element.id),
            position: parseLatLang(element.get('location')),
            infoWindow: InfoWindow(title: element.get('name')),
          ),
        );
    });

    print('doc count ${future.docs.length}');
    print('markers length ${markers.length}');
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
      padding: EdgeInsets.only(
        top: (MediaQuery.of(context).size.height - 160),
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
    );
  }
}
