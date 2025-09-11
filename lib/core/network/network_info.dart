// lib/core/network/network_info.dart

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<bool> get hasInternetAccess;
  Stream<ConnectivityResult> get onConnectivityChanged;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl({
    required this.connectivity,
    required this.connectionChecker,
  });

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Future<bool> get hasInternetAccess async {
    try {
      if (!await isConnected) return false;
      return await connectionChecker.hasConnection;
    } catch (e) {
      print('Error checking internet access: $e');
      return false;
    }
  }

  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      connectivity.onConnectivityChanged;
}