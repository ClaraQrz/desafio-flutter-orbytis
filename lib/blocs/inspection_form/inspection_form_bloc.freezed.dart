// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inspection_form_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InspectionFormEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is InspectionFormEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'InspectionFormEvent()';
}


}

/// @nodoc
class $InspectionFormEventCopyWith<$Res>  {
$InspectionFormEventCopyWith(InspectionFormEvent _, $Res Function(InspectionFormEvent) __);
}


/// Adds pattern-matching-related methods to [InspectionFormEvent].
extension InspectionFormEventPatterns on InspectionFormEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PhotoSourceSelected value)?  photoSourceSelected,TResult Function( PhotoRemoved value)?  photoRemoved,TResult Function( DraftSubmitted value)?  draftSubmitted,TResult Function( InspectionConcluded value)?  concluded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PhotoSourceSelected() when photoSourceSelected != null:
return photoSourceSelected(_that);case PhotoRemoved() when photoRemoved != null:
return photoRemoved(_that);case DraftSubmitted() when draftSubmitted != null:
return draftSubmitted(_that);case InspectionConcluded() when concluded != null:
return concluded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PhotoSourceSelected value)  photoSourceSelected,required TResult Function( PhotoRemoved value)  photoRemoved,required TResult Function( DraftSubmitted value)  draftSubmitted,required TResult Function( InspectionConcluded value)  concluded,}){
final _that = this;
switch (_that) {
case PhotoSourceSelected():
return photoSourceSelected(_that);case PhotoRemoved():
return photoRemoved(_that);case DraftSubmitted():
return draftSubmitted(_that);case InspectionConcluded():
return concluded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PhotoSourceSelected value)?  photoSourceSelected,TResult? Function( PhotoRemoved value)?  photoRemoved,TResult? Function( DraftSubmitted value)?  draftSubmitted,TResult? Function( InspectionConcluded value)?  concluded,}){
final _that = this;
switch (_that) {
case PhotoSourceSelected() when photoSourceSelected != null:
return photoSourceSelected(_that);case PhotoRemoved() when photoRemoved != null:
return photoRemoved(_that);case DraftSubmitted() when draftSubmitted != null:
return draftSubmitted(_that);case InspectionConcluded() when concluded != null:
return concluded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ImageSource source)?  photoSourceSelected,TResult Function()?  photoRemoved,TResult Function( String observation,  double? latitude,  double? longitude)?  draftSubmitted,TResult Function( String observation,  double? latitude,  double? longitude)?  concluded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PhotoSourceSelected() when photoSourceSelected != null:
return photoSourceSelected(_that.source);case PhotoRemoved() when photoRemoved != null:
return photoRemoved();case DraftSubmitted() when draftSubmitted != null:
return draftSubmitted(_that.observation,_that.latitude,_that.longitude);case InspectionConcluded() when concluded != null:
return concluded(_that.observation,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ImageSource source)  photoSourceSelected,required TResult Function()  photoRemoved,required TResult Function( String observation,  double? latitude,  double? longitude)  draftSubmitted,required TResult Function( String observation,  double? latitude,  double? longitude)  concluded,}) {final _that = this;
switch (_that) {
case PhotoSourceSelected():
return photoSourceSelected(_that.source);case PhotoRemoved():
return photoRemoved();case DraftSubmitted():
return draftSubmitted(_that.observation,_that.latitude,_that.longitude);case InspectionConcluded():
return concluded(_that.observation,_that.latitude,_that.longitude);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ImageSource source)?  photoSourceSelected,TResult? Function()?  photoRemoved,TResult? Function( String observation,  double? latitude,  double? longitude)?  draftSubmitted,TResult? Function( String observation,  double? latitude,  double? longitude)?  concluded,}) {final _that = this;
switch (_that) {
case PhotoSourceSelected() when photoSourceSelected != null:
return photoSourceSelected(_that.source);case PhotoRemoved() when photoRemoved != null:
return photoRemoved();case DraftSubmitted() when draftSubmitted != null:
return draftSubmitted(_that.observation,_that.latitude,_that.longitude);case InspectionConcluded() when concluded != null:
return concluded(_that.observation,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc


class PhotoSourceSelected implements InspectionFormEvent {
  const PhotoSourceSelected(this.source);
  

 final  ImageSource source;

/// Create a copy of InspectionFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoSourceSelectedCopyWith<PhotoSourceSelected> get copyWith => _$PhotoSourceSelectedCopyWithImpl<PhotoSourceSelected>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoSourceSelected&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode {
    return Object.hash(runtimeType,source);
}

@override
String toString() {
    return 'InspectionFormEvent.photoSourceSelected(source: $source)';
}


}

/// @nodoc
abstract mixin class $PhotoSourceSelectedCopyWith<$Res> implements $InspectionFormEventCopyWith<$Res> {
  factory $PhotoSourceSelectedCopyWith(PhotoSourceSelected value, $Res Function(PhotoSourceSelected) _then) = _$PhotoSourceSelectedCopyWithImpl;
@useResult
$Res call({
 ImageSource source
});




}
/// @nodoc
class _$PhotoSourceSelectedCopyWithImpl<$Res>
    implements $PhotoSourceSelectedCopyWith<$Res> {
  _$PhotoSourceSelectedCopyWithImpl(this._self, this._then);

  final PhotoSourceSelected _self;
  final $Res Function(PhotoSourceSelected) _then;

/// Create a copy of InspectionFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? source = null,}) {
  return _then(PhotoSourceSelected(
null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ImageSource,
  ));
}


}

/// @nodoc


class PhotoRemoved implements InspectionFormEvent {
  const PhotoRemoved();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoRemoved);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'InspectionFormEvent.photoRemoved()';
}


}




/// @nodoc


class DraftSubmitted implements InspectionFormEvent {
  const DraftSubmitted({required this.observation, this.latitude, this.longitude});
  

 final  String observation;
 final  double? latitude;
 final  double? longitude;

/// Create a copy of InspectionFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftSubmittedCopyWith<DraftSubmitted> get copyWith => _$DraftSubmittedCopyWithImpl<DraftSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftSubmitted&&(identical(other.observation, observation) || other.observation == observation)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode {
    return Object.hash(runtimeType,observation,latitude,longitude);
}

@override
String toString() {
    return 'InspectionFormEvent.draftSubmitted(observation: $observation, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $DraftSubmittedCopyWith<$Res> implements $InspectionFormEventCopyWith<$Res> {
  factory $DraftSubmittedCopyWith(DraftSubmitted value, $Res Function(DraftSubmitted) _then) = _$DraftSubmittedCopyWithImpl;
@useResult
$Res call({
 String observation, double? latitude, double? longitude
});




}
/// @nodoc
class _$DraftSubmittedCopyWithImpl<$Res>
    implements $DraftSubmittedCopyWith<$Res> {
  _$DraftSubmittedCopyWithImpl(this._self, this._then);

  final DraftSubmitted _self;
  final $Res Function(DraftSubmitted) _then;

/// Create a copy of InspectionFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? observation = null,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(DraftSubmitted(
observation: null == observation ? _self.observation : observation // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc


class InspectionConcluded implements InspectionFormEvent {
  const InspectionConcluded({required this.observation, this.latitude, this.longitude});
  

 final  String observation;
 final  double? latitude;
 final  double? longitude;

/// Create a copy of InspectionFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InspectionConcludedCopyWith<InspectionConcluded> get copyWith => _$InspectionConcludedCopyWithImpl<InspectionConcluded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is InspectionConcluded&&(identical(other.observation, observation) || other.observation == observation)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode {
    return Object.hash(runtimeType,observation,latitude,longitude);
}

@override
String toString() {
    return 'InspectionFormEvent.concluded(observation: $observation, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $InspectionConcludedCopyWith<$Res> implements $InspectionFormEventCopyWith<$Res> {
  factory $InspectionConcludedCopyWith(InspectionConcluded value, $Res Function(InspectionConcluded) _then) = _$InspectionConcludedCopyWithImpl;
@useResult
$Res call({
 String observation, double? latitude, double? longitude
});




}
/// @nodoc
class _$InspectionConcludedCopyWithImpl<$Res>
    implements $InspectionConcludedCopyWith<$Res> {
  _$InspectionConcludedCopyWithImpl(this._self, this._then);

  final InspectionConcluded _self;
  final $Res Function(InspectionConcluded) _then;

/// Create a copy of InspectionFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? observation = null,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(InspectionConcluded(
observation: null == observation ? _self.observation : observation // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$InspectionFormState {

 InspectionFormStatus get status; String? get photoPath; String? get message;
/// Create a copy of InspectionFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InspectionFormStateCopyWith<InspectionFormState> get copyWith => _$InspectionFormStateCopyWithImpl<InspectionFormState>(this as InspectionFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as InspectionFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InspectionFormState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.photoPath, _this.photoPath) || other.photoPath == _this.photoPath)&&(identical(other.message, _this.message) || other.message == _this.message));
}


@override
int get hashCode {
  final _this = this as InspectionFormState;
  return Object.hash(runtimeType,_this.status,_this.photoPath,_this.message);
}

@override
String toString() {
  final _this = this as InspectionFormState;
  return 'InspectionFormState(status: ${_this.status}, photoPath: ${_this.photoPath}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $InspectionFormStateCopyWith<$Res>  {
  factory $InspectionFormStateCopyWith(InspectionFormState value, $Res Function(InspectionFormState) _then) = _$InspectionFormStateCopyWithImpl;
@useResult
$Res call({
 InspectionFormStatus status, String? photoPath, String? message
});




}
/// @nodoc
class _$InspectionFormStateCopyWithImpl<$Res>
    implements $InspectionFormStateCopyWith<$Res> {
  _$InspectionFormStateCopyWithImpl(this._self, this._then);

  final InspectionFormState _self;
  final $Res Function(InspectionFormState) _then;

/// Create a copy of InspectionFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? photoPath = freezed,Object? message = freezed,}) {
  return _then(InspectionFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InspectionFormStatus,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InspectionFormState].
extension InspectionFormStatePatterns on InspectionFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InspectionFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InspectionFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InspectionFormState value)  $default,){
final _that = this;
switch (_that) {
case _InspectionFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InspectionFormState value)?  $default,){
final _that = this;
switch (_that) {
case _InspectionFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InspectionFormStatus status,  String? photoPath,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InspectionFormState() when $default != null:
return $default(_that.status,_that.photoPath,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InspectionFormStatus status,  String? photoPath,  String? message)  $default,) {final _that = this;
switch (_that) {
case _InspectionFormState():
return $default(_that.status,_that.photoPath,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InspectionFormStatus status,  String? photoPath,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _InspectionFormState() when $default != null:
return $default(_that.status,_that.photoPath,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _InspectionFormState extends InspectionFormState {
  const _InspectionFormState({this.status = InspectionFormStatus.idle, this.photoPath, this.message}): super._();
  

@override@JsonKey() final  InspectionFormStatus status;
@override final  String? photoPath;
@override final  String? message;

/// Create a copy of InspectionFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InspectionFormStateCopyWith<_InspectionFormState> get copyWith => __$InspectionFormStateCopyWithImpl<_InspectionFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InspectionFormState&&(identical(other.status, status) || other.status == status)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,photoPath,message);
}

@override
String toString() {
    return 'InspectionFormState(status: $status, photoPath: $photoPath, message: $message)';
}


}

/// @nodoc
abstract mixin class _$InspectionFormStateCopyWith<$Res> implements $InspectionFormStateCopyWith<$Res> {
  factory _$InspectionFormStateCopyWith(_InspectionFormState value, $Res Function(_InspectionFormState) _then) = __$InspectionFormStateCopyWithImpl;
@override @useResult
$Res call({
 InspectionFormStatus status, String? photoPath, String? message
});




}
/// @nodoc
class __$InspectionFormStateCopyWithImpl<$Res>
    implements _$InspectionFormStateCopyWith<$Res> {
  __$InspectionFormStateCopyWithImpl(this._self, this._then);

  final _InspectionFormState _self;
  final $Res Function(_InspectionFormState) _then;

/// Create a copy of InspectionFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? photoPath = freezed,Object? message = freezed,}) {
  return _then(_InspectionFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InspectionFormStatus,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
