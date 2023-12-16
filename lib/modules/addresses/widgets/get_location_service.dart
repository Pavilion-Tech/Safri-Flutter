import 'package:geocoding/geocoding.dart' as gg;
import 'package:geolocator/geolocator.dart';

// import 'package:location/location.dart';

class GetLocationServ {
  static Position? _location;
  static DateTime? _lastUpdate;
  static const Duration _cacheTimeOut = Duration(minutes: 30);

  // =============================================
  static Future<Position?> getLocation({bool forceUpdate = false}) async {
    if (_location == null) return await _getLocation(); // if first time call me will be null
    if (forceUpdate) return await _getLocation(); // forceUpdate so get it again
    if (_canICallLocation()) return await _getLocation(); // cache time out
    return _location; // default
  }

  static bool _canICallLocation() {
    print(_lastUpdate == null);
    if (_lastUpdate == null) return true;
    int differenceInSeconds = DateTime.now().difference(_lastUpdate!).inSeconds;
    if (differenceInSeconds < _cacheTimeOut.inSeconds) return false;
    return true;
  }

  static Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  // =============================================
  static double? _lat;
  static double? _lang;
  static gg.Placemark? _place;

  static Future<gg.Placemark> getMyLocationFromPlaces(double lat, double lang) async {
    if (_lat == lat && lang == _lang && _place != null) return _place!;
    List<gg.Placemark> newPlace = await gg.placemarkFromCoordinates(lat, lang);
    _lat = lat;
    _lang = _lang;
    _place = newPlace[newPlace.length > 1 ? 1 : 0];
    return newPlace[newPlace.length > 1 ? 1 : 0];
  }
}

extension LocationDataEX on Position? {
  bool isNull() => (this == null || this?.longitude == null || this?.latitude == null);
}
