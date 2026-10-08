import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';


class RouteService {
  RouteService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<LatLng>> getRoute({
    required LatLng from,
    required LatLng to,
  }) async {
    final uri = Uri.https(
      'router.project-osrm.org',
      '/route/v1/driving/'
          '${from.longitude},${from.latitude};${to.longitude},${to.latitude}',
      {'overview': 'full', 'geometries': 'geojson'},
    );

    final response = await _client.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode != 200) {
      throw Exception('Rota indisponível (${response.statusCode}).');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final routes = json['routes'] as List<dynamic>?;
    if (routes == null || routes.isEmpty) {
      throw Exception('Nenhuma rota encontrada.');
    }

    final coordinates =
        (routes.first as Map<String, dynamic>)['geometry']['coordinates']
            as List<dynamic>;


    return coordinates
        .map((c) => LatLng((c[1] as num).toDouble(), (c[0] as num).toDouble()))
        .toList();
  }
}