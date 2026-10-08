// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LocationEvent()';
}


}

/// @nodoc
class $LocationEventCopyWith<$Res>  {
$LocationEventCopyWith(LocationEvent _, $Res Function(LocationEvent) __);
}


/// Adds pattern-matching-related methods to [LocationEvent].
extension LocationEventPatterns on LocationEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LocationRequested value)?  requested,TResult Function( LocationUpdated value)?  updated,TResult Function( LocationFailed value)?  failed,TResult Function( LocationConfirmed value)?  confirmed,TResult Function( LocationManuallySet value)?  manuallySet,TResult Function( LocationRouteRequested value)?  routeRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LocationRequested() when requested != null:
return requested(_that);case LocationUpdated() when updated != null:
return updated(_that);case LocationFailed() when failed != null:
return failed(_that);case LocationConfirmed() when confirmed != null:
return confirmed(_that);case LocationManuallySet() when manuallySet != null:
return manuallySet(_that);case LocationRouteRequested() when routeRequested != null:
return routeRequested(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LocationRequested value)  requested,required TResult Function( LocationUpdated value)  updated,required TResult Function( LocationFailed value)  failed,required TResult Function( LocationConfirmed value)  confirmed,required TResult Function( LocationManuallySet value)  manuallySet,required TResult Function( LocationRouteRequested value)  routeRequested,}){
final _that = this;
switch (_that) {
case LocationRequested():
return requested(_that);case LocationUpdated():
return updated(_that);case LocationFailed():
return failed(_that);case LocationConfirmed():
return confirmed(_that);case LocationManuallySet():
return manuallySet(_that);case LocationRouteRequested():
return routeRequested(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LocationRequested value)?  requested,TResult? Function( LocationUpdated value)?  updated,TResult? Function( LocationFailed value)?  failed,TResult? Function( LocationConfirmed value)?  confirmed,TResult? Function( LocationManuallySet value)?  manuallySet,TResult? Function( LocationRouteRequested value)?  routeRequested,}){
final _that = this;
switch (_that) {
case LocationRequested() when requested != null:
return requested(_that);case LocationUpdated() when updated != null:
return updated(_that);case LocationFailed() when failed != null:
return failed(_that);case LocationConfirmed() when confirmed != null:
return confirmed(_that);case LocationManuallySet() when manuallySet != null:
return manuallySet(_that);case LocationRouteRequested() when routeRequested != null:
return routeRequested(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  requested,TResult Function( double latitude,  double longitude)?  updated,TResult Function( String message)?  failed,TResult Function()?  confirmed,TResult Function( double latitude,  double longitude)?  manuallySet,TResult Function()?  routeRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LocationRequested() when requested != null:
return requested();case LocationUpdated() when updated != null:
return updated(_that.latitude,_that.longitude);case LocationFailed() when failed != null:
return failed(_that.message);case LocationConfirmed() when confirmed != null:
return confirmed();case LocationManuallySet() when manuallySet != null:
return manuallySet(_that.latitude,_that.longitude);case LocationRouteRequested() when routeRequested != null:
return routeRequested();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  requested,required TResult Function( double latitude,  double longitude)  updated,required TResult Function( String message)  failed,required TResult Function()  confirmed,required TResult Function( double latitude,  double longitude)  manuallySet,required TResult Function()  routeRequested,}) {final _that = this;
switch (_that) {
case LocationRequested():
return requested();case LocationUpdated():
return updated(_that.latitude,_that.longitude);case LocationFailed():
return failed(_that.message);case LocationConfirmed():
return confirmed();case LocationManuallySet():
return manuallySet(_that.latitude,_that.longitude);case LocationRouteRequested():
return routeRequested();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  requested,TResult? Function( double latitude,  double longitude)?  updated,TResult? Function( String message)?  failed,TResult? Function()?  confirmed,TResult? Function( double latitude,  double longitude)?  manuallySet,TResult? Function()?  routeRequested,}) {final _that = this;
switch (_that) {
case LocationRequested() when requested != null:
return requested();case LocationUpdated() when updated != null:
return updated(_that.latitude,_that.longitude);case LocationFailed() when failed != null:
return failed(_that.message);case LocationConfirmed() when confirmed != null:
return confirmed();case LocationManuallySet() when manuallySet != null:
return manuallySet(_that.latitude,_that.longitude);case LocationRouteRequested() when routeRequested != null:
return routeRequested();case _:
  return null;

}
}

}

/// @nodoc


class LocationRequested implements LocationEvent {
  const LocationRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LocationEvent.requested()';
}


}




/// @nodoc


class LocationUpdated implements LocationEvent {
  const LocationUpdated({required this.latitude, required this.longitude});
  

 final  double latitude;
 final  double longitude;

/// Create a copy of LocationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationUpdatedCopyWith<LocationUpdated> get copyWith => _$LocationUpdatedCopyWithImpl<LocationUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationUpdated&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode {
    return Object.hash(runtimeType,latitude,longitude);
}

@override
String toString() {
    return 'LocationEvent.updated(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $LocationUpdatedCopyWith<$Res> implements $LocationEventCopyWith<$Res> {
  factory $LocationUpdatedCopyWith(LocationUpdated value, $Res Function(LocationUpdated) _then) = _$LocationUpdatedCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class _$LocationUpdatedCopyWithImpl<$Res>
    implements $LocationUpdatedCopyWith<$Res> {
  _$LocationUpdatedCopyWithImpl(this._self, this._then);

  final LocationUpdated _self;
  final $Res Function(LocationUpdated) _then;

/// Create a copy of LocationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(LocationUpdated(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class LocationFailed implements LocationEvent {
  const LocationFailed(this.message);
  

 final  String message;

/// Create a copy of LocationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationFailedCopyWith<LocationFailed> get copyWith => _$LocationFailedCopyWithImpl<LocationFailed>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'LocationEvent.failed(message: $message)';
}


}

/// @nodoc
abstract mixin class $LocationFailedCopyWith<$Res> implements $LocationEventCopyWith<$Res> {
  factory $LocationFailedCopyWith(LocationFailed value, $Res Function(LocationFailed) _then) = _$LocationFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$LocationFailedCopyWithImpl<$Res>
    implements $LocationFailedCopyWith<$Res> {
  _$LocationFailedCopyWithImpl(this._self, this._then);

  final LocationFailed _self;
  final $Res Function(LocationFailed) _then;

/// Create a copy of LocationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(LocationFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LocationConfirmed implements LocationEvent {
  const LocationConfirmed();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationConfirmed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LocationEvent.confirmed()';
}


}




/// @nodoc


class LocationManuallySet implements LocationEvent {
  const LocationManuallySet({required this.latitude, required this.longitude});
  

 final  double latitude;
 final  double longitude;

/// Create a copy of LocationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationManuallySetCopyWith<LocationManuallySet> get copyWith => _$LocationManuallySetCopyWithImpl<LocationManuallySet>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationManuallySet&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode {
    return Object.hash(runtimeType,latitude,longitude);
}

@override
String toString() {
    return 'LocationEvent.manuallySet(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $LocationManuallySetCopyWith<$Res> implements $LocationEventCopyWith<$Res> {
  factory $LocationManuallySetCopyWith(LocationManuallySet value, $Res Function(LocationManuallySet) _then) = _$LocationManuallySetCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class _$LocationManuallySetCopyWithImpl<$Res>
    implements $LocationManuallySetCopyWith<$Res> {
  _$LocationManuallySetCopyWithImpl(this._self, this._then);

  final LocationManuallySet _self;
  final $Res Function(LocationManuallySet) _then;

/// Create a copy of LocationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(LocationManuallySet(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class LocationRouteRequested implements LocationEvent {
  const LocationRouteRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationRouteRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LocationEvent.routeRequested()';
}


}




/// @nodoc
mixin _$LocationState {

 LocationStatus get status; double? get currentLatitude; double? get currentLongitude; double? get latitude; double? get longitude; double? get distanceMeters; bool get isInRange; bool get isManual; List<LatLng> get route; String? get error;
/// Create a copy of LocationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationStateCopyWith<LocationState> get copyWith => _$LocationStateCopyWithImpl<LocationState>(this as LocationState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LocationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.currentLatitude, _this.currentLatitude) || other.currentLatitude == _this.currentLatitude)&&(identical(other.currentLongitude, _this.currentLongitude) || other.currentLongitude == _this.currentLongitude)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.distanceMeters, _this.distanceMeters) || other.distanceMeters == _this.distanceMeters)&&(identical(other.isInRange, _this.isInRange) || other.isInRange == _this.isInRange)&&(identical(other.isManual, _this.isManual) || other.isManual == _this.isManual)&&const DeepCollectionEquality().equals(other.route, _this.route)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as LocationState;
  return Object.hash(runtimeType,_this.status,_this.currentLatitude,_this.currentLongitude,_this.latitude,_this.longitude,_this.distanceMeters,_this.isInRange,_this.isManual,const DeepCollectionEquality().hash(_this.route),_this.error);
}

@override
String toString() {
  final _this = this as LocationState;
  return 'LocationState(status: ${_this.status}, currentLatitude: ${_this.currentLatitude}, currentLongitude: ${_this.currentLongitude}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, distanceMeters: ${_this.distanceMeters}, isInRange: ${_this.isInRange}, isManual: ${_this.isManual}, route: ${_this.route}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $LocationStateCopyWith<$Res>  {
  factory $LocationStateCopyWith(LocationState value, $Res Function(LocationState) _then) = _$LocationStateCopyWithImpl;
@useResult
$Res call({
 LocationStatus status, double? currentLatitude, double? currentLongitude, double? latitude, double? longitude, double? distanceMeters, bool isInRange, bool isManual, List<LatLng> route, String? error
});




}
/// @nodoc
class _$LocationStateCopyWithImpl<$Res>
    implements $LocationStateCopyWith<$Res> {
  _$LocationStateCopyWithImpl(this._self, this._then);

  final LocationState _self;
  final $Res Function(LocationState) _then;

/// Create a copy of LocationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? currentLatitude = freezed,Object? currentLongitude = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? distanceMeters = freezed,Object? isInRange = null,Object? isManual = null,Object? route = null,Object? error = freezed,}) {
  return _then(LocationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LocationStatus,currentLatitude: freezed == currentLatitude ? _self.currentLatitude : currentLatitude // ignore: cast_nullable_to_non_nullable
as double?,currentLongitude: freezed == currentLongitude ? _self.currentLongitude : currentLongitude // ignore: cast_nullable_to_non_nullable
as double?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double?,isInRange: null == isInRange ? _self.isInRange : isInRange // ignore: cast_nullable_to_non_nullable
as bool,isManual: null == isManual ? _self.isManual : isManual // ignore: cast_nullable_to_non_nullable
as bool,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as List<LatLng>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationState].
extension LocationStatePatterns on LocationState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationState value)  $default,){
final _that = this;
switch (_that) {
case _LocationState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationState value)?  $default,){
final _that = this;
switch (_that) {
case _LocationState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocationStatus status,  double? currentLatitude,  double? currentLongitude,  double? latitude,  double? longitude,  double? distanceMeters,  bool isInRange,  bool isManual,  List<LatLng> route,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationState() when $default != null:
return $default(_that.status,_that.currentLatitude,_that.currentLongitude,_that.latitude,_that.longitude,_that.distanceMeters,_that.isInRange,_that.isManual,_that.route,_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocationStatus status,  double? currentLatitude,  double? currentLongitude,  double? latitude,  double? longitude,  double? distanceMeters,  bool isInRange,  bool isManual,  List<LatLng> route,  String? error)  $default,) {final _that = this;
switch (_that) {
case _LocationState():
return $default(_that.status,_that.currentLatitude,_that.currentLongitude,_that.latitude,_that.longitude,_that.distanceMeters,_that.isInRange,_that.isManual,_that.route,_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocationStatus status,  double? currentLatitude,  double? currentLongitude,  double? latitude,  double? longitude,  double? distanceMeters,  bool isInRange,  bool isManual,  List<LatLng> route,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _LocationState() when $default != null:
return $default(_that.status,_that.currentLatitude,_that.currentLongitude,_that.latitude,_that.longitude,_that.distanceMeters,_that.isInRange,_that.isManual,_that.route,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _LocationState extends LocationState {
  const _LocationState({this.status = LocationStatus.initial, this.currentLatitude, this.currentLongitude, this.latitude, this.longitude, this.distanceMeters, this.isInRange = false, this.isManual = false,  List<LatLng> route = const <LatLng>[], this.error}): _route = route,super._();
  

@override@JsonKey() final  LocationStatus status;
@override final  double? currentLatitude;
@override final  double? currentLongitude;
@override final  double? latitude;
@override final  double? longitude;
@override final  double? distanceMeters;
@override@JsonKey() final  bool isInRange;
@override@JsonKey() final  bool isManual;
 final  List<LatLng> _route;
@override@JsonKey() List<LatLng> get route {
  if (_route is EqualUnmodifiableListView) return _route;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_route);
}

@override final  String? error;

/// Create a copy of LocationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationStateCopyWith<_LocationState> get copyWith => __$LocationStateCopyWithImpl<_LocationState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationState&&(identical(other.status, status) || other.status == status)&&(identical(other.currentLatitude, currentLatitude) || other.currentLatitude == currentLatitude)&&(identical(other.currentLongitude, currentLongitude) || other.currentLongitude == currentLongitude)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.isInRange, isInRange) || other.isInRange == isInRange)&&(identical(other.isManual, isManual) || other.isManual == isManual)&&const DeepCollectionEquality().equals(other.route, _route)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,currentLatitude,currentLongitude,latitude,longitude,distanceMeters,isInRange,isManual,const DeepCollectionEquality().hash(_route),error);
}

@override
String toString() {
    return 'LocationState(status: $status, currentLatitude: $currentLatitude, currentLongitude: $currentLongitude, latitude: $latitude, longitude: $longitude, distanceMeters: $distanceMeters, isInRange: $isInRange, isManual: $isManual, route: $route, error: $error)';
}


}

/// @nodoc
abstract mixin class _$LocationStateCopyWith<$Res> implements $LocationStateCopyWith<$Res> {
  factory _$LocationStateCopyWith(_LocationState value, $Res Function(_LocationState) _then) = __$LocationStateCopyWithImpl;
@override @useResult
$Res call({
 LocationStatus status, double? currentLatitude, double? currentLongitude, double? latitude, double? longitude, double? distanceMeters, bool isInRange, bool isManual, List<LatLng> route, String? error
});




}
/// @nodoc
class __$LocationStateCopyWithImpl<$Res>
    implements _$LocationStateCopyWith<$Res> {
  __$LocationStateCopyWithImpl(this._self, this._then);

  final _LocationState _self;
  final $Res Function(_LocationState) _then;

/// Create a copy of LocationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? currentLatitude = freezed,Object? currentLongitude = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? distanceMeters = freezed,Object? isInRange = null,Object? isManual = null,Object? route = null,Object? error = freezed,}) {
  return _then(_LocationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LocationStatus,currentLatitude: freezed == currentLatitude ? _self.currentLatitude : currentLatitude // ignore: cast_nullable_to_non_nullable
as double?,currentLongitude: freezed == currentLongitude ? _self.currentLongitude : currentLongitude // ignore: cast_nullable_to_non_nullable
as double?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double?,isInRange: null == isInRange ? _self.isInRange : isInRange // ignore: cast_nullable_to_non_nullable
as bool,isManual: null == isManual ? _self.isManual : isManual // ignore: cast_nullable_to_non_nullable
as bool,route: null == route ? _self._route : route // ignore: cast_nullable_to_non_nullable
as List<LatLng>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
