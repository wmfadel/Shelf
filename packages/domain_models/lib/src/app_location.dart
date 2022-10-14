class AppLocation {
  late final double? lat;
  late final double? long;

  AppLocation({required this.lat, required this.long});

  AppLocation.fromJson(Map<String, dynamic> map)
      : lat = map['lat'],
        long = map['long'];

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
    };
  }

  /// creates an [AppLocation] from a string in the format of "lat,long"
  AppLocation.fromJoinedString(String location) {
    final split = location.split(',');
    if(split.length != 2) {
      throw ArgumentError('location must be in the format of "lat,long"');
    }
    lat = double.tryParse(split[0]);
    long = double.tryParse(split[1]);
  }

  /// returns a string representation of the location in the format
  /// "latitude,longitude"
  String toJoinedString() {
    return '$lat,$long';
  }
}
