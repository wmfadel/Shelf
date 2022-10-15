class AppLocation {
  late final double? latitude;
  late final double? longitude;

  AppLocation({required this.latitude, required this.longitude});

  AppLocation.fromJson(Map<String, dynamic> map)
      : latitude = map['lat'],
        longitude = map['long'];

  Map<String, dynamic> toJson() {
    return {
      'lat': latitude,
      'long': longitude,
    };
  }

  /// creates an [AppLocation] from a string in the format of "lat,long"
  AppLocation.fromJoinedString(String location) {
    final split = location.split(',');
    if(split.length != 2) {
      throw ArgumentError('location must be in the format of "lat,long"');
    }
    latitude = double.tryParse(split[0]);
    longitude = double.tryParse(split[1]);
  }

  /// returns a string representation of the location in the format
  /// "latitude,longitude"
  String toJoinedString() {
    return '$latitude,$longitude';
  }
}
