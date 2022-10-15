import 'package:domain_models/domain_models.dart';
import 'package:location/location.dart';

extension LocationDataExtension on LocationData {
  AppLocation toAppLocation() {
    return AppLocation(latitude: latitude, longitude: longitude);
  }
}
