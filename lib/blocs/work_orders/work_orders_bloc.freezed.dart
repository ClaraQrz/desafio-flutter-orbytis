// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_orders_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkOrdersEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrdersEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'WorkOrdersEvent()';
}


}

/// @nodoc
class $WorkOrdersEventCopyWith<$Res>  {
$WorkOrdersEventCopyWith(WorkOrdersEvent _, $Res Function(WorkOrdersEvent) __);
}


/// Adds pattern-matching-related methods to [WorkOrdersEvent].
extension WorkOrdersEventPatterns on WorkOrdersEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WorkOrdersLoadRequested value)?  loadRequested,TResult Function( WorkOrdersRefreshRequested value)?  refreshRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WorkOrdersLoadRequested() when loadRequested != null:
return loadRequested(_that);case WorkOrdersRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WorkOrdersLoadRequested value)  loadRequested,required TResult Function( WorkOrdersRefreshRequested value)  refreshRequested,}){
final _that = this;
switch (_that) {
case WorkOrdersLoadRequested():
return loadRequested(_that);case WorkOrdersRefreshRequested():
return refreshRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WorkOrdersLoadRequested value)?  loadRequested,TResult? Function( WorkOrdersRefreshRequested value)?  refreshRequested,}){
final _that = this;
switch (_that) {
case WorkOrdersLoadRequested() when loadRequested != null:
return loadRequested(_that);case WorkOrdersRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadRequested,TResult Function()?  refreshRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WorkOrdersLoadRequested() when loadRequested != null:
return loadRequested();case WorkOrdersRefreshRequested() when refreshRequested != null:
return refreshRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadRequested,required TResult Function()  refreshRequested,}) {final _that = this;
switch (_that) {
case WorkOrdersLoadRequested():
return loadRequested();case WorkOrdersRefreshRequested():
return refreshRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadRequested,TResult? Function()?  refreshRequested,}) {final _that = this;
switch (_that) {
case WorkOrdersLoadRequested() when loadRequested != null:
return loadRequested();case WorkOrdersRefreshRequested() when refreshRequested != null:
return refreshRequested();case _:
  return null;

}
}

}

/// @nodoc


class WorkOrdersLoadRequested implements WorkOrdersEvent {
  const WorkOrdersLoadRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrdersLoadRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'WorkOrdersEvent.loadRequested()';
}


}




/// @nodoc


class WorkOrdersRefreshRequested implements WorkOrdersEvent {
  const WorkOrdersRefreshRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrdersRefreshRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'WorkOrdersEvent.refreshRequested()';
}


}




/// @nodoc
mixin _$WorkOrdersState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrdersState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'WorkOrdersState()';
}


}

/// @nodoc
class $WorkOrdersStateCopyWith<$Res>  {
$WorkOrdersStateCopyWith(WorkOrdersState _, $Res Function(WorkOrdersState) __);
}


/// Adds pattern-matching-related methods to [WorkOrdersState].
extension WorkOrdersStatePatterns on WorkOrdersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WorkOrdersLoading value)?  loading,TResult Function( WorkOrdersEmpty value)?  empty,TResult Function( WorkOrdersLoaded value)?  loaded,TResult Function( WorkOrdersFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WorkOrdersLoading() when loading != null:
return loading(_that);case WorkOrdersEmpty() when empty != null:
return empty(_that);case WorkOrdersLoaded() when loaded != null:
return loaded(_that);case WorkOrdersFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WorkOrdersLoading value)  loading,required TResult Function( WorkOrdersEmpty value)  empty,required TResult Function( WorkOrdersLoaded value)  loaded,required TResult Function( WorkOrdersFailure value)  failure,}){
final _that = this;
switch (_that) {
case WorkOrdersLoading():
return loading(_that);case WorkOrdersEmpty():
return empty(_that);case WorkOrdersLoaded():
return loaded(_that);case WorkOrdersFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WorkOrdersLoading value)?  loading,TResult? Function( WorkOrdersEmpty value)?  empty,TResult? Function( WorkOrdersLoaded value)?  loaded,TResult? Function( WorkOrdersFailure value)?  failure,}){
final _that = this;
switch (_that) {
case WorkOrdersLoading() when loading != null:
return loading(_that);case WorkOrdersEmpty() when empty != null:
return empty(_that);case WorkOrdersLoaded() when loaded != null:
return loaded(_that);case WorkOrdersFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  empty,TResult Function( List<WorkOrder> WorkOrders)?  loaded,TResult Function( String message,  bool isSessionExpired)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WorkOrdersLoading() when loading != null:
return loading();case WorkOrdersEmpty() when empty != null:
return empty();case WorkOrdersLoaded() when loaded != null:
return loaded(_that.WorkOrders);case WorkOrdersFailure() when failure != null:
return failure(_that.message,_that.isSessionExpired);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  empty,required TResult Function( List<WorkOrder> WorkOrders)  loaded,required TResult Function( String message,  bool isSessionExpired)  failure,}) {final _that = this;
switch (_that) {
case WorkOrdersLoading():
return loading();case WorkOrdersEmpty():
return empty();case WorkOrdersLoaded():
return loaded(_that.WorkOrders);case WorkOrdersFailure():
return failure(_that.message,_that.isSessionExpired);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  empty,TResult? Function( List<WorkOrder> WorkOrders)?  loaded,TResult? Function( String message,  bool isSessionExpired)?  failure,}) {final _that = this;
switch (_that) {
case WorkOrdersLoading() when loading != null:
return loading();case WorkOrdersEmpty() when empty != null:
return empty();case WorkOrdersLoaded() when loaded != null:
return loaded(_that.WorkOrders);case WorkOrdersFailure() when failure != null:
return failure(_that.message,_that.isSessionExpired);case _:
  return null;

}
}

}

/// @nodoc


class WorkOrdersLoading implements WorkOrdersState {
  const WorkOrdersLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrdersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'WorkOrdersState.loading()';
}


}




/// @nodoc


class WorkOrdersEmpty implements WorkOrdersState {
  const WorkOrdersEmpty();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrdersEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'WorkOrdersState.empty()';
}


}




/// @nodoc


class WorkOrdersLoaded implements WorkOrdersState {
  const WorkOrdersLoaded( List<WorkOrder> WorkOrders): _WorkOrders = WorkOrders;
  

 final  List<WorkOrder> _WorkOrders;
 List<WorkOrder> get WorkOrders {
  if (_WorkOrders is EqualUnmodifiableListView) return _WorkOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_WorkOrders);
}


/// Create a copy of WorkOrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkOrdersLoadedCopyWith<WorkOrdersLoaded> get copyWith => _$WorkOrdersLoadedCopyWithImpl<WorkOrdersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrdersLoaded&&const DeepCollectionEquality().equals(other.WorkOrders, _WorkOrders));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_WorkOrders));
}

@override
String toString() {
    return 'WorkOrdersState.loaded(WorkOrders: $WorkOrders)';
}


}

/// @nodoc
abstract mixin class $WorkOrdersLoadedCopyWith<$Res> implements $WorkOrdersStateCopyWith<$Res> {
  factory $WorkOrdersLoadedCopyWith(WorkOrdersLoaded value, $Res Function(WorkOrdersLoaded) _then) = _$WorkOrdersLoadedCopyWithImpl;
@useResult
$Res call({
 List<WorkOrder> WorkOrders
});




}
/// @nodoc
class _$WorkOrdersLoadedCopyWithImpl<$Res>
    implements $WorkOrdersLoadedCopyWith<$Res> {
  _$WorkOrdersLoadedCopyWithImpl(this._self, this._then);

  final WorkOrdersLoaded _self;
  final $Res Function(WorkOrdersLoaded) _then;

/// Create a copy of WorkOrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? WorkOrders = null,}) {
  return _then(WorkOrdersLoaded(
null == WorkOrders ? _self._WorkOrders : WorkOrders // ignore: cast_nullable_to_non_nullable
as List<WorkOrder>,
  ));
}


}

/// @nodoc


class WorkOrdersFailure implements WorkOrdersState {
  const WorkOrdersFailure({required this.message, this.isSessionExpired = false});
  

 final  String message;
@JsonKey() final  bool isSessionExpired;

/// Create a copy of WorkOrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkOrdersFailureCopyWith<WorkOrdersFailure> get copyWith => _$WorkOrdersFailureCopyWithImpl<WorkOrdersFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkOrdersFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.isSessionExpired, isSessionExpired) || other.isSessionExpired == isSessionExpired));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message,isSessionExpired);
}

@override
String toString() {
    return 'WorkOrdersState.failure(message: $message, isSessionExpired: $isSessionExpired)';
}


}

/// @nodoc
abstract mixin class $WorkOrdersFailureCopyWith<$Res> implements $WorkOrdersStateCopyWith<$Res> {
  factory $WorkOrdersFailureCopyWith(WorkOrdersFailure value, $Res Function(WorkOrdersFailure) _then) = _$WorkOrdersFailureCopyWithImpl;
@useResult
$Res call({
 String message, bool isSessionExpired
});




}
/// @nodoc
class _$WorkOrdersFailureCopyWithImpl<$Res>
    implements $WorkOrdersFailureCopyWith<$Res> {
  _$WorkOrdersFailureCopyWithImpl(this._self, this._then);

  final WorkOrdersFailure _self;
  final $Res Function(WorkOrdersFailure) _then;

/// Create a copy of WorkOrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? isSessionExpired = null,}) {
  return _then(WorkOrdersFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,isSessionExpired: null == isSessionExpired ? _self.isSessionExpired : isSessionExpired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
