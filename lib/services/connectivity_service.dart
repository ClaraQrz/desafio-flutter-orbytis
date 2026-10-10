import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  ConnectivityService({required Uri checkUri, InternetConnection? connection})
      : _connection = connection ??
            InternetConnection.createInstance(
              useDefaultOptions: false,
              customCheckOptions: [
                InternetCheckOption(
                  uri: checkUri,
                  responseStatusFn: (response) => response.statusCode < 500,
                ),
              ],
            );

  final InternetConnection _connection;

  Future<bool> isOnline() => _connection.hasInternetAccess;

  Stream<bool> get onChanged => _connection.onStatusChange.map(
    (status) => status == InternetStatus.connected,
  );

  void dispose() => _connection.dispose();
}