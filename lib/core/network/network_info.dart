import 'package:connectivity/connectivity.dart';
abstract class NetworkInfo {
  Future<bool> get isConnected;

}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl(this._connectivity);
  @override
  Future<bool> get isConnected async {
    return await _connectivity.checkConnectivity() != ConnectivityResult.none;
  }

}