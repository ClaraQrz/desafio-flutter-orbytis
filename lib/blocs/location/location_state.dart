part of 'location_bloc.dart';

enum LocationStatus { initial, loading, success, failure }

@freezed
abstract class LocationState with _$LocationState {
  const LocationState._();

  const factory LocationState({
    @Default(LocationStatus.initial) LocationStatus status,

    double? currentLatitude,
    double? currentLongitude,

    double? latitude,
    double? longitude,

    double? distanceMeters,

    @Default(false) bool isInRange,

    @Default(false) bool isManual,

    @Default(<LatLng>[]) List<LatLng> route,
    String? error,
  }) = _LocationState;

  bool get isLoading => status == LocationStatus.loading;
  bool get hasCurrent => currentLatitude != null && currentLongitude != null;
  bool get hasLocation => latitude != null && longitude != null;
}