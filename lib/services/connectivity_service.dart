import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  ConnectivityService({InternetConnection? connection})
      : _connection = connection ?? InternetConnection();

  final InternetConnection _connection;

  Future<bool> get isOnline => _connection.hasInternetAccess;

  Stream<bool> get onChanged => _connection.onStatusChange.map(
        (status) => status == InternetStatus.connected,
  );
}