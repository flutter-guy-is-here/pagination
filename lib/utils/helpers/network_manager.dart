import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager {
  static final Connectivity _connectivity = Connectivity();

  static Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result.any((element) => element == ConnectivityResult.none)) {
        return false;
      } else {
        return true;
      }
    } catch (_) {
      return false;
    }
  }
}
