import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class LocationService {
  static GeoPoint parseLatLang(String coordenates) {
    List<String> parts = coordenates.split(',');
    return GeoPoint(double.parse(parts[0]), double.parse(parts[1]));
  }

  Future<String?> getUserLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    LocationData locData = await location.getLocation();
    return '${locData.latitude},${locData.longitude}';
  }
}
