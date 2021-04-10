import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';

class ChangeLocationMap extends StatefulWidget {
  @override
  _ChangeLocationMapState createState() => _ChangeLocationMapState();
}

class _ChangeLocationMapState extends State<ChangeLocationMap> {
  GoogleMapController? _controller;
  late AuthProvider authProvider;
  Set<Marker> markers = {};
  LatLng camera = LatLng(30.0494817, 31.236408);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    fetchLocation();
  }

  fetchLocation() async {
    print('getting user location');
    DocumentSnapshot future = await FirebaseFirestore.instance
        .collection('users')
        .doc(authProvider.uid)
        .get();
    print('location ${future.get('location')}');
    markers.add(
      Marker(
        markerId: MarkerId(Timestamp.now().toString()),
        position: parseLatLang(future.get('location')),
      ),
    );
    print('moving to new camera position');
    print(_controller.toString());
    camera = parseLatLang(future.get('location'));
    _controller?.animateCamera(
      CameraUpdate.newLatLng(
        camera,
      ),
    );
    setState(() {});
  }

  LatLng parseLatLang(String coordenates) {
    List<String> parts = coordenates.split(',');
    return LatLng(double.parse(parts[0]), double.parse(parts[1]));
  }

  @override
  void dispose() {
    if (_controller != null) _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: camera,
                zoom: 19,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                _controller?.animateCamera(CameraUpdate.newLatLng(camera));
                setState(() {});
              },
              onTap: (LatLng newLatLng) {
                markers.clear();
                markers.add(
                  Marker(
                    markerId: MarkerId(Timestamp.now().toString()),
                    position: newLatLng,
                  ),
                );
                setState(() {});
              },
              markers: markers,
              myLocationEnabled: true,
              compassEnabled: true,
              mapToolbarEnabled: true,
              myLocationButtonEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (markers.isNotEmpty) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(authProvider.uid)
                          .update({
                        'location':
                            '${markers.first.position.latitude},${markers.first.position.longitude}'
                      });
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
                SizedBox(width: 10),
              ],
            )
          ],
        ),
      ),
    );
  }
}
