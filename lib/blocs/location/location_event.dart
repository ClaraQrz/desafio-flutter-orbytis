part of 'location_bloc.dart';

@freezed
sealed class LocationEvent with _$LocationEvent {
  const factory LocationEvent.requested() = LocationRequested;

  const factory LocationEvent.updated({
    required double latitude,
    required double longitude,
  }) = LocationUpdated;

  const factory LocationEvent.failed(String message) = LocationFailed;

  const factory LocationEvent.confirmed() = LocationConfirmed;

  const factory LocationEvent.manuallySet({
    required double latitude,
    required double longitude,
  }) = LocationManuallySet;

  const factory LocationEvent.routeRequested() = LocationRouteRequested;
}