import 'package:domain_models/domain_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:location_service/src/data_to_app_location_mapper.dart';

void main() {
  group('Mapper test:', () {
    test(
        'When mapping DarkModePreferenceCM.alwaysDark to domain, return DarkModePreference.alwaysDark',
        () {
      final locationData =
          LocationData.fromMap({'latitude': 1.0, 'longitude': 1.0});

      expect(
        locationData.toAppLocation().toJoinedString(),
        AppLocation(lat: 1.0, long: 1.0).toJoinedString(),
      );
    });
  });
}
