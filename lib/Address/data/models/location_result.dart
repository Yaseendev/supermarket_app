import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationResult {
  final LatLng position;
  final String displayPlace;
  final String city;
  final String suburb;
  final String neighbourhood;

  LocationResult({
    required this.position,
    required this.displayPlace,
    required this.city,
    required this.suburb,
    required this.neighbourhood,
  });

  factory LocationResult.fromJson(Map<String, dynamic> responseData) {
    return LocationResult(
      displayPlace: responseData['display_name'] ?? '',
      position: LatLng(
        double.parse(responseData['lat'].toString()),
        double.parse(responseData['lon'].toString()),
      ),
      city: responseData['address']['city'] ?? '',
      suburb: responseData['address']['suburb'] ?? '',
      neighbourhood: responseData['address']['neighbourhood'] ?? '',
    );
  }
}
