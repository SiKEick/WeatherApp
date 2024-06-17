import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;
  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (unless they are denied forever).
        return Future.error('Location permissions are denied');
      }
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, inform the user to enable them manually.
        return Future.error(
            'Location permissions are permanently denied, please enable them in the app settings.');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
  }
}
