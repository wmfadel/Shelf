import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';
import 'package:shelf/providers/map_provider.dart';
import 'package:shelf/providers/market_provider.dart';
import 'package:shelf/services/location_service.dart';

class HomeMap extends StatefulWidget {
  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  late AuthProvider authProvider;
  late MapProvider mapProvider;
  late MarketProvider marketProvider;
  bool showingOverView = false;
  //Set<Marker> markers = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    mapProvider = Provider.of<MapProvider>(context);
    marketProvider = Provider.of<MarketProvider>(context);
    mapProvider.fetchMarkers(context, authProvider.uid!);
  }

  @override
  void dispose() {
    mapProvider.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('building map');
    showingOverView = marketProvider.getActiveBook() != null;
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(30.0494817, 31.236408),
        zoom: 19,
      ),
      markers: mapProvider.markers,
      onMapCreated: (GoogleMapController controller) async {
        mapProvider.controller = controller;
        String? location = await LocationService().getUserLocation();
        if (location != null) {
          mapProvider.controller?.animateCamera(
            CameraUpdate.newLatLng(mapProvider.parseLatLang(location)),
          );
        }
        // setting state to allow map to apply padding correctly
        setState(() {});
      },
      padding: EdgeInsets.only(
        top: 100,
        right: 10,
        bottom: showingOverView ? 450 : 200,
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
