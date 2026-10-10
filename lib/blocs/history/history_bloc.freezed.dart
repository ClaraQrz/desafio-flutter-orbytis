// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HistoryEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HistoryEvent()';
}


}

/// @nodoc
class $HistoryEventCopyWith<$Res>  {
$HistoryEventCopyWith(HistoryEvent _, $Res Function(HistoryEvent) __);
}


/// Adds pattern-matching-related methods to [HistoryEvent].
extension HistoryEventPatterns on HistoryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HistoryLoadRequested value)?  loadRequested,TResult Function( HistoryFilterChanged value)?  filterChanged,TResult Function( HistorySyncRequested value)?  syncRequested,TResult Function( HistoryRetryRequested value)?  retryRequested,TResult Function( HistoryConnectivityChanged value)?  connectivityChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HistoryLoadRequested() when loadRequested != null:
return loadRequested(_that);case HistoryFilterChanged() when filterChanged != null:
return filterChanged(_that);case HistorySyncRequested() when syncRequested != null:
return syncRequested(_that);case HistoryRetryRequested() when retryRequested != null:
return retryRequested(_that);case HistoryConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HistoryLoadRequested value)  loadRequested,required TResult Function( HistoryFilterChanged value)  filterChanged,required TResult Function( HistorySyncRequested value)  syncRequested,required TResult Function( HistoryRetryRequested value)  retryRequested,required TResult Function( HistoryConnectivityChanged value)  connectivityChanged,}){
final _that = this;
switch (_that) {
case HistoryLoadRequested():
return loadRequested(_that);case HistoryFilterChanged():
return filterChanged(_that);case HistorySyncRequested():
return syncRequested(_that);case HistoryRetryRequested():
return retryRequested(_that);case HistoryConnectivityChanged():
return connectivityChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HistoryLoadRequested value)?  loadRequested,TResult? Function( HistoryFilterChanged value)?  filterChanged,TResult? Function( HistorySyncRequested value)?  syncRequested,TResult? Function( HistoryRetryRequested value)?  retryRequested,TResult? Function( HistoryConnectivityChanged value)?  connectivityChanged,}){
final _that = this;
switch (_that) {
case HistoryLoadRequested() when loadRequested != null:
return loadRequested(_that);case HistoryFilterChanged() when filterChanged != null:
return filterChanged(_that);case HistorySyncRequested() when syncRequested != null:
return syncRequested(_that);case HistoryRetryRequested() when retryRequested != null:
return retryRequested(_that);case HistoryConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Completer<void>? completer)?  loadRequested,TResult Function( HistoryFilter filter)?  filterChanged,TResult Function()?  syncRequested,TResult Function( Inspection inspection)?  retryRequested,TResult Function( bool isOnline)?  connectivityChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HistoryLoadRequested() when loadRequested != null:
return loadRequested(_that.completer);case HistoryFilterChanged() when filterChanged != null:
return filterChanged(_that.filter);case HistorySyncRequested() when syncRequested != null:
return syncRequested();case HistoryRetryRequested() when retryRequested != null:
return retryRequested(_that.inspection);case HistoryConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that.isOnline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Completer<void>? completer)  loadRequested,required TResult Function( HistoryFilter filter)  filterChanged,required TResult Function()  syncRequested,required TResult Function( Inspection inspection)  retryRequested,required TResult Function( bool isOnline)  connectivityChanged,}) {final _that = this;
switch (_that) {
case HistoryLoadRequested():
return loadRequested(_that.completer);case HistoryFilterChanged():
return filterChanged(_that.filter);case HistorySyncRequested():
return syncRequested();case HistoryRetryRequested():
return retryRequested(_that.inspection);case HistoryConnectivityChanged():
return connectivityChanged(_that.isOnline);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Completer<void>? completer)?  loadRequested,TResult? Function( HistoryFilter filter)?  filterChanged,TResult? Function()?  syncRequested,TResult? Function( Inspection inspection)?  retryRequested,TResult? Function( bool isOnline)?  connectivityChanged,}) {final _that = this;
switch (_that) {
case HistoryLoadRequested() when loadRequested != null:
return loadRequested(_that.completer);case HistoryFilterChanged() when filterChanged != null:
return filterChanged(_that.filter);case HistorySyncRequested() when syncRequested != null:
return syncRequested();case HistoryRetryRequested() when retryRequested != null:
return retryRequested(_that.inspection);case HistoryConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that.isOnline);case _:
  return null;

}
}

}

/// @nodoc


class HistoryLoadRequested implements HistoryEvent {
  const HistoryLoadRequested({this.completer});
  

 final  Completer<void>? completer;

/// Create a copy of HistoryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryLoadRequestedCopyWith<HistoryLoadRequested> get copyWith => _$HistoryLoadRequestedCopyWithImpl<HistoryLoadRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryLoadRequested&&(identical(other.completer, completer) || other.completer == completer));
}


@override
int get hashCode {
    return Object.hash(runtimeType,completer);
}

@override
String toString() {
    return 'HistoryEvent.loadRequested(completer: $completer)';
}


}

/// @nodoc
abstract mixin class $HistoryLoadRequestedCopyWith<$Res> implements $HistoryEventCopyWith<$Res> {
  factory $HistoryLoadRequestedCopyWith(HistoryLoadRequested value, $Res Function(HistoryLoadRequested) _then) = _$HistoryLoadRequestedCopyWithImpl;
@useResult
$Res call({
 Completer<void>? completer
});




}
/// @nodoc
class _$HistoryLoadRequestedCopyWithImpl<$Res>
    implements $HistoryLoadRequestedCopyWith<$Res> {
  _$HistoryLoadRequestedCopyWithImpl(this._self, this._then);

  final HistoryLoadRequested _self;
  final $Res Function(HistoryLoadRequested) _then;

/// Create a copy of HistoryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? completer = freezed,}) {
  return _then(HistoryLoadRequested(
completer: freezed == completer ? _self.completer : completer // ignore: cast_nullable_to_non_nullable
as Completer<void>?,
  ));
}


}

/// @nodoc


class HistoryFilterChanged implements HistoryEvent {
  const HistoryFilterChanged(this.filter);
  

 final  HistoryFilter filter;

/// Create a copy of HistoryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryFilterChangedCopyWith<HistoryFilterChanged> get copyWith => _$HistoryFilterChangedCopyWithImpl<HistoryFilterChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryFilterChanged&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode {
    return Object.hash(runtimeType,filter);
}

@override
String toString() {
    return 'HistoryEvent.filterChanged(filter: $filter)';
}


}

/// @nodoc
abstract mixin class $HistoryFilterChangedCopyWith<$Res> implements $HistoryEventCopyWith<$Res> {
  factory $HistoryFilterChangedCopyWith(HistoryFilterChanged value, $Res Function(HistoryFilterChanged) _then) = _$HistoryFilterChangedCopyWithImpl;
@useResult
$Res call({
 HistoryFilter filter
});




}
/// @nodoc
class _$HistoryFilterChangedCopyWithImpl<$Res>
    implements $HistoryFilterChangedCopyWith<$Res> {
  _$HistoryFilterChangedCopyWithImpl(this._self, this._then);

  final HistoryFilterChanged _self;
  final $Res Function(HistoryFilterChanged) _then;

/// Create a copy of HistoryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,}) {
  return _then(HistoryFilterChanged(
null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as HistoryFilter,
  ));
}


}

/// @nodoc


class HistorySyncRequested implements HistoryEvent {
  const HistorySyncRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HistorySyncRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HistoryEvent.syncRequested()';
}


}




/// @nodoc


class HistoryRetryRequested implements HistoryEvent {
  const HistoryRetryRequested(this.inspection);
  

 final  Inspection inspection;

/// Create a copy of HistoryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryRetryRequestedCopyWith<HistoryRetryRequested> get copyWith => _$HistoryRetryRequestedCopyWithImpl<HistoryRetryRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryRetryRequested&&(identical(other.inspection, inspection) || other.inspection == inspection));
}


@override
int get hashCode {
    return Object.hash(runtimeType,inspection);
}

@override
String toString() {
    return 'HistoryEvent.retryRequested(inspection: $inspection)';
}


}

/// @nodoc
abstract mixin class $HistoryRetryRequestedCopyWith<$Res> implements $HistoryEventCopyWith<$Res> {
  factory $HistoryRetryRequestedCopyWith(HistoryRetryRequested value, $Res Function(HistoryRetryRequested) _then) = _$HistoryRetryRequestedCopyWithImpl;
@useResult
$Res call({
 Inspection inspection
});




}
/// @nodoc
class _$HistoryRetryRequestedCopyWithImpl<$Res>
    implements $HistoryRetryRequestedCopyWith<$Res> {
  _$HistoryRetryRequestedCopyWithImpl(this._self, this._then);

  final HistoryRetryRequested _self;
  final $Res Function(HistoryRetryRequested) _then;

/// Create a copy of HistoryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? inspection = null,}) {
  return _then(HistoryRetryRequested(
null == inspection ? _self.inspection : inspection // ignore: cast_nullable_to_non_nullable
as Inspection,
  ));
}


}

/// @nodoc


class HistoryConnectivityChanged implements HistoryEvent {
  const HistoryConnectivityChanged(this.isOnline);
  

 final  bool isOnline;

/// Create a copy of HistoryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryConnectivityChangedCopyWith<HistoryConnectivityChanged> get copyWith => _$HistoryConnectivityChangedCopyWithImpl<HistoryConnectivityChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryConnectivityChanged&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isOnline);
}

@override
String toString() {
    return 'HistoryEvent.connectivityChanged(isOnline: $isOnline)';
}


}

/// @nodoc
abstract mixin class $HistoryConnectivityChangedCopyWith<$Res> implements $HistoryEventCopyWith<$Res> {
  factory $HistoryConnectivityChangedCopyWith(HistoryConnectivityChanged value, $Res Function(HistoryConnectivityChanged) _then) = _$HistoryConnectivityChangedCopyWithImpl;
@useResult
$Res call({
 bool isOnline
});




}
/// @nodoc
class _$HistoryConnectivityChangedCopyWithImpl<$Res>
    implements $HistoryConnectivityChangedCopyWith<$Res> {
  _$HistoryConnectivityChangedCopyWithImpl(this._self, this._then);

  final HistoryConnectivityChanged _self;
  final $Res Function(HistoryConnectivityChanged) _then;

/// Create a copy of HistoryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isOnline = null,}) {
  return _then(HistoryConnectivityChanged(
null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$HistoryState {

 bool get isLoading; bool get isSyncing; List<Inspection> get inspections; HistoryFilter get filter; String? get message;
/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryStateCopyWith<HistoryState> get copyWith => _$HistoryStateCopyWithImpl<HistoryState>(this as HistoryState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HistoryState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryState&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.isSyncing, _this.isSyncing) || other.isSyncing == _this.isSyncing)&&const DeepCollectionEquality().equals(other.inspections, _this.inspections)&&(identical(other.filter, _this.filter) || other.filter == _this.filter)&&(identical(other.message, _this.message) || other.message == _this.message));
}


@override
int get hashCode {
  final _this = this as HistoryState;
  return Object.hash(runtimeType,_this.isLoading,_this.isSyncing,const DeepCollectionEquality().hash(_this.inspections),_this.filter,_this.message);
}

@override
String toString() {
  final _this = this as HistoryState;
  return 'HistoryState(isLoading: ${_this.isLoading}, isSyncing: ${_this.isSyncing}, inspections: ${_this.inspections}, filter: ${_this.filter}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $HistoryStateCopyWith<$Res>  {
  factory $HistoryStateCopyWith(HistoryState value, $Res Function(HistoryState) _then) = _$HistoryStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSyncing, List<Inspection> inspections, HistoryFilter filter, String? message
});




}
/// @nodoc
class _$HistoryStateCopyWithImpl<$Res>
    implements $HistoryStateCopyWith<$Res> {
  _$HistoryStateCopyWithImpl(this._self, this._then);

  final HistoryState _self;
  final $Res Function(HistoryState) _then;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSyncing = null,Object? inspections = null,Object? filter = null,Object? message = freezed,}) {
  return _then(HistoryState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,inspections: null == inspections ? _self.inspections : inspections // ignore: cast_nullable_to_non_nullable
as List<Inspection>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as HistoryFilter,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryState].
extension HistoryStatePatterns on HistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryState value)  $default,){
final _that = this;
switch (_that) {
case _HistoryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryState value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isSyncing,  List<Inspection> inspections,  HistoryFilter filter,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
return $default(_that.isLoading,_that.isSyncing,_that.inspections,_that.filter,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isSyncing,  List<Inspection> inspections,  HistoryFilter filter,  String? message)  $default,) {final _that = this;
switch (_that) {
case _HistoryState():
return $default(_that.isLoading,_that.isSyncing,_that.inspections,_that.filter,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isSyncing,  List<Inspection> inspections,  HistoryFilter filter,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _HistoryState() when $default != null:
return $default(_that.isLoading,_that.isSyncing,_that.inspections,_that.filter,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _HistoryState extends HistoryState {
  const _HistoryState({this.isLoading = true, this.isSyncing = false,  List<Inspection> inspections = const <Inspection>[], this.filter = HistoryFilter.all, this.message}): _inspections = inspections,super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSyncing;
 final  List<Inspection> _inspections;
@override@JsonKey() List<Inspection> get inspections {
  if (_inspections is EqualUnmodifiableListView) return _inspections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inspections);
}

@override@JsonKey() final  HistoryFilter filter;
@override final  String? message;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryStateCopyWith<_HistoryState> get copyWith => __$HistoryStateCopyWithImpl<_HistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing)&&const DeepCollectionEquality().equals(other.inspections, _inspections)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isLoading,isSyncing,const DeepCollectionEquality().hash(_inspections),filter,message);
}

@override
String toString() {
    return 'HistoryState(isLoading: $isLoading, isSyncing: $isSyncing, inspections: $inspections, filter: $filter, message: $message)';
}


}

/// @nodoc
abstract mixin class _$HistoryStateCopyWith<$Res> implements $HistoryStateCopyWith<$Res> {
  factory _$HistoryStateCopyWith(_HistoryState value, $Res Function(_HistoryState) _then) = __$HistoryStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSyncing, List<Inspection> inspections, HistoryFilter filter, String? message
});




}
/// @nodoc
class __$HistoryStateCopyWithImpl<$Res>
    implements _$HistoryStateCopyWith<$Res> {
  __$HistoryStateCopyWithImpl(this._self, this._then);

  final _HistoryState _self;
  final $Res Function(_HistoryState) _then;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSyncing = null,Object? inspections = null,Object? filter = null,Object? message = freezed,}) {
  return _then(_HistoryState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,inspections: null == inspections ? _self._inspections : inspections // ignore: cast_nullable_to_non_nullable
as List<Inspection>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as HistoryFilter,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
