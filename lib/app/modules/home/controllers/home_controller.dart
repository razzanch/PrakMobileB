import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  // Observables
  var currentPosition = Rxn<Position>();
  var locationMessage = "Mencari Lat dan Long...".obs;
  var isLoading = false.obs;

  // Get current location
  Future<void> getCurrentLocation() async {
    isLoading.value = true;
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw Exception('Location service not enabled');
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied forever');
      }

      // Get position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      currentPosition.value = position;
      locationMessage.value =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    } catch (e) {
      locationMessage.value = 'Gagal mendapatkan lokasi';
    } finally {
      isLoading.value = false;
    }
  }

  // Open Google Maps
  void openGoogleMaps() {
    if (currentPosition.value != null) {
      final url =
          'https://www.google.com/maps?q=${currentPosition.value!.latitude},${currentPosition.value!.longitude}';
      _launchURL(url);
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
