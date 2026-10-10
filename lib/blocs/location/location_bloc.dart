import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../services/route_service.dart';

part 'location_event.dart';
part 'location_state.dart';
part 'location_bloc.freezed.dart';

const kGeofenceRadiusMeters = 50.0;

const _routeRefreshMeters = 50.0;

class LocationBloc extends Bloc<LocationEvent, LocationState> {
    LocationBloc({
    required RouteService routeService,
    this.targetLatitude,
    this.targetLongitude,
    this.radiusMeters = kGeofenceRadiusMeters,
    double? initialLatitude,
    double? initialLongitude,
  })  : _routeService = routeService,
        super(LocationState(
          latitude: initialLatitude,
          longitude: initialLongitude,
        )) {
    on<LocationRequested>(_onRequested);
    on<LocationUpdated>(_onUpdated);
    on<LocationFailed>(_onFailed);
    on<LocationConfirmed>(_onConfirmed);
    on<LocationManuallySet>(_onManuallySet);
    on<LocationRouteRequested>(_onRouteRequested);
  }

  final RouteService _routeService;

  final double? targetLatitude;
  final double? targetLongitude;
  final double radiusMeters;

  StreamSubscription<Position>? _subscription;
  LatLng? _lastRouteOrigin;
  bool _fetchingRoute = false;

  bool get hasTarget => targetLatitude != null && targetLongitude != null;

  Future<void> _onRequested(
      LocationRequested event,
      Emitter<LocationState> emit,
      ) async {
    if (state.isLoading) return;

    await _subscription?.cancel();
    _subscription = null;

    emit(state.copyWith(status: LocationStatus.loading, error: null));

    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw 'Ative o GPS do dispositivo.';
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Permissão de localização negada.';
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw 'Permissão negada permanentemente. Ative nas configurações do sistema.';
      }

      final first = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
      emit(_withPosition(first.latitude, first.longitude));
      _maybeFetchRoute();

      _subscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 2,
        ),
      ).listen(
            (p) => add(LocationUpdated(
          latitude: p.latitude,
          longitude: p.longitude,
        )),
        onError: (Object e) => add(LocationFailed(_messageFor(e))),
      );
    } catch (e) {
      emit(state.copyWith(
        status: LocationStatus.failure,
        error: _messageFor(e),
      ));
    }
  }

  void _onUpdated(LocationUpdated event, Emitter<LocationState> emit) {
    emit(_withPosition(event.latitude, event.longitude));
    _maybeFetchRoute();
  }

  void _onFailed(LocationFailed event, Emitter<LocationState> emit) {
    emit(state.copyWith(status: LocationStatus.failure, error: event.message));
  }

  void _onConfirmed(LocationConfirmed event, Emitter<LocationState> emit) {
    if (!state.hasCurrent) return;
    if (hasTarget && !state.isInRange) return;

    emit(state.copyWith(
      latitude: state.currentLatitude,
      longitude: state.currentLongitude,
      isManual: false,
      error: null,
    ));
  }

  void _onManuallySet(LocationManuallySet event, Emitter<LocationState> emit) {
    if (hasTarget) return;
    emit(state.copyWith(
      latitude: event.latitude,
      longitude: event.longitude,
      isManual: true,
      error: null,
    ));
  }

  Future<void> _onRouteRequested(
      LocationRouteRequested event,
      Emitter<LocationState> emit,
      ) async {
    final lat = state.currentLatitude;
    final lng = state.currentLongitude;
    if (lat == null || lng == null || !hasTarget) {
      _fetchingRoute = false;
      return;
    }

    _lastRouteOrigin = LatLng(lat, lng);
    try {
      final points = await _routeService.getRoute(
        from: LatLng(lat, lng),
        to: LatLng(targetLatitude!, targetLongitude!),
      );
      if (emit.isDone || state.isInRange) return;
      emit(state.copyWith(route: points));
    } catch (_) {
    } finally {
      _fetchingRoute = false;
    }
  }

  LocationState _withPosition(double lat, double lng) {
    double? distance;
    var inRange = true;
    if (hasTarget) {
      distance = Geolocator.distanceBetween(
        lat,
        lng,
        targetLatitude!,
        targetLongitude!,
      );
      inRange = distance <= radiusMeters;
    }

    debugPrint(
      '[GEO] pos=$lat,$lng alvo=$targetLatitude,$targetLongitude '
          'dist=${distance?.toStringAsFixed(1)}m raio=${radiusMeters}m '
          'dentro=$inRange',
    );

    if (inRange) _lastRouteOrigin = null;

    return state.copyWith(
      status: LocationStatus.success,
      currentLatitude: lat,
      currentLongitude: lng,
      distanceMeters: distance,
      isInRange: inRange,
      route: inRange ? const <LatLng>[] : state.route,
      error: null,
    );
  }

  void _maybeFetchRoute() {
    if (!hasTarget || state.isInRange || _fetchingRoute) return;

    final origin = _lastRouteOrigin;
    if (origin != null) {
      final moved = Geolocator.distanceBetween(
        origin.latitude,
        origin.longitude,
        state.currentLatitude!,
        state.currentLongitude!,
      );
      if (moved < _routeRefreshMeters) return;
    }

    _fetchingRoute = true;
    add(const LocationRouteRequested());
  }

  String _messageFor(Object e) {
    if (e is String) return e;
    if (e is TimeoutException) return 'Tempo esgotado ao obter o GPS.';
    return 'Não foi possível obter a localização.';
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}