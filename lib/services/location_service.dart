import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  static Future<LatLng?> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  static double calculateDistance(LatLng start, LatLng end) {
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }

  static List<LatLng> getNearbyCarLocations(LatLng userLocation) {
    // Sample car locations near user
    return [
      LatLng(userLocation.latitude + 0.01, userLocation.longitude + 0.01),
      LatLng(userLocation.latitude - 0.01, userLocation.longitude - 0.01),
      LatLng(userLocation.latitude + 0.005, userLocation.longitude - 0.005),
    ];
  }
}