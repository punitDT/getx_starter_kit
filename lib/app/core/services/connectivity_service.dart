import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  Future<void> init() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionState(result);
    _subscription = _connectivity.onConnectivityChanged.listen(_updateConnectionState);
  }

  void _updateConnectionState(List<ConnectivityResult> result) {
    final hasConnection = result.any((element) => element != ConnectivityResult.none);
    isConnected.value = hasConnection;
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
