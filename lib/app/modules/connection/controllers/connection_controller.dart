import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '../../home/views/home_view.dart';
import '../views/no_connection_view.dart';

class ConnectionController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    // Mendengarkan perubahan konektivitas
    _connectivity.onConnectivityChanged.listen((connectivityResult) {
      _updateConnectionStatus(connectivityResult.first);
    });
  }

  // Fungsi untuk mengupdate status koneksi
  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      // Jika tidak ada koneksi, navigasi ke NoConnectionView
      Get.offAll(() => const NoConnectionView());
    } else {
      // Jika ada koneksi, cek apakah saat ini berada di NoConnectionView
      if (Get.currentRoute == '/NoConnectionView') {
        // Navigasi kembali ke HomeView
        Get.offAll(() => const HomeView());
      }
    }
  }
}
