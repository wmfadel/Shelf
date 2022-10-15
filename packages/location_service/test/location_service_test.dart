import 'package:domain_models/domain_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:location_service/location_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'location_service_test.mocks.dart';

@GenerateMocks([Location])
void main() {
  group('LocationService', () {
    final location = MockLocation();
    final locationService = LocationService(location: location);

    test('When calling getLocation, return location', () async {
      final testLocationData = LocationData.fromMap(
        {'latitude': 1.0, 'longitude': 1.0, 'accuracy': 1.0, 'altitude': 1.0},
      );

      when(location.serviceEnabled()).thenAnswer((_) async => true);
      when(location.hasPermission())
          .thenAnswer((_) async => PermissionStatus.granted);
      when(location.getLocation()).thenAnswer((_) async => testLocationData);

      final locationValue = await locationService.getUserLocation();
      expect(locationValue, isA<AppLocation>());
    });
  });
}
