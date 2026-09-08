import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  const NetworkInfo(this._connectivity);

  final Connectivity _connectivity;

  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return result.any((element) => element != ConnectivityResult.none);
  }
}
