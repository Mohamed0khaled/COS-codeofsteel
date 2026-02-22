import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Abstract class to check network connectivity.
/// This allows for easy mocking in tests.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Implementation of NetworkInfo using InternetConnectionChecker.
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
