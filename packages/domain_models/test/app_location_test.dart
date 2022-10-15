import 'package:domain_models/domain_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Testing AppLocation toJson', () {
    final location = AppLocation(latitude: 1.0, longitude: 1.0);
    expect(location.toJson(), {'lat': 1.0, 'long': 1.0});
  });

  test('Testing AppLocation fromJson', () {
    final location = AppLocation.fromJson({'lat': 1.0, 'long': 1.0});
    expect(location.latitude, 1.0);
    expect(location.longitude, 1.0);
  });

  test('Testing AppLocation toJoinedString', () {
    final location = AppLocation(latitude: 1.0, longitude: 1.0);
    expect(location.toJoinedString(), '1.0,1.0');
  });

  test('Testing AppLocation fromJoinedString', () {
    final location = AppLocation.fromJoinedString('1.0,1.0');
    expect(location.latitude, 1.0);
    expect(location.longitude, 1.0);
  });
}
