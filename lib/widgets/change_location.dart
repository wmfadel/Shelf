import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shelf/providers/auth_provider.dart';

class ChangeLocation extends StatefulWidget {
  @override
  _ChangeLocationState createState() => _ChangeLocationState();
}

class _ChangeLocationState extends State<ChangeLocation> {
  GoogleMapController? _controller;
  late AuthProvider authProvider;
  Set<Marker> markers = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
        markerId: MarkerId('markerID ^-^'),
        position: parseLatLang(future.get('location')),
      ),
    );

    _controller?.moveCamera(
      CameraUpdate.newLatLng(
        parseLatLang(future.get('location')),
      ),
    );

    //if (markers.length > 0) setState(() {});
  }

  LatLng parseLatLang(String coordenates) {
    List<String> parts = coordenates.split(',');
    return LatLng(double.parse(parts[0]), double.parse(parts[1]));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Change Location'),
      leading: Icon(
        Icons.location_on_outlined,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) {
              authProvider = Provider.of<AuthProvider>(context, listen: false);

              fetchLocation();

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.6,
                color: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                          child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(30.0494817, 31.236408),
                          zoom: 19,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller = controller;
                        },
                        onTap: (LatLng newLatLng) {
                          markers.clear();
                          markers.add(
                            Marker(
                              markerId: MarkerId('markerID ^-^'),
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
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(authProvider.uid)
                                  .update({
                                'location':
                                    '${markers.first.position.latitude},${markers.first.position.longitude}'
                              });
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
            });
      },
    );
  }
}
