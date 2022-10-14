import 'package:location/location.dart';
import 'package:domain_models/domain_models.dart';
import 'package:location_service/src/data_to_app_location_mapper.dart';

class LocationService {
  LocationService({
    Location? location,
  }) : _location = location ?? Location();

  final Location _location;

  /// checks if the location service is enabled
  /// if not enabled requests enabling the location service
  Future<bool> _enableLocationService() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
    }
    return serviceEnabled;
  }

  /// checks if the location permission is granted or not
  /// if not granted requests granting the location permission
  Future<bool> _enableLocationPermission() async {
    PermissionStatus permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  /// returns the current location of the user if the location service is enabled
  /// and the location permission is granted
  Future<AppLocation?> getUserLocation() async {
    if (!await _enableLocationService()) return null;
    if (!await _enableLocationPermission()) return null;
    LocationData locData = await _location.getLocation();
    return locData.toAppLocation();
  }

  /// returns a stream that keeps emitting user location changes
  /// if the location service is enabled and the location permission is granted
  Stream<AppLocation?> getUserLocationStream() async* {
    if (!await _enableLocationService()) yield null;
    if (!await _enableLocationPermission()) yield null;
    yield* _location.onLocationChanged.map((locData) => locData.toAppLocation());
  }
}
