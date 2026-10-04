// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'azkar_audio_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AzkarAudioState {

 AzkarAudioStatus get status; String? get url;
/// Create a copy of AzkarAudioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AzkarAudioStateCopyWith<AzkarAudioState> get copyWith => _$AzkarAudioStateCopyWithImpl<AzkarAudioState>(this as AzkarAudioState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AzkarAudioState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AzkarAudioState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.url, _this.url) || other.url == _this.url));
}


@override
int get hashCode {
  final _this = this as AzkarAudioState;
  return Object.hash(runtimeType,_this.status,_this.url);
}

@override
String toString() {
  final _this = this as AzkarAudioState;
  return 'AzkarAudioState(status: ${_this.status}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $AzkarAudioStateCopyWith<$Res>  {
  factory $AzkarAudioStateCopyWith(AzkarAudioState value, $Res Function(AzkarAudioState) _then) = _$AzkarAudioStateCopyWithImpl;
@useResult
$Res call({
 AzkarAudioStatus status, String? url
});




}
/// @nodoc
class _$AzkarAudioStateCopyWithImpl<$Res>
    implements $AzkarAudioStateCopyWith<$Res> {
  _$AzkarAudioStateCopyWithImpl(this._self, this._then);

  final AzkarAudioState _self;
  final $Res Function(AzkarAudioState) _then;

/// Create a copy of AzkarAudioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? url = freezed,}) {
  return _then(AzkarAudioState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AzkarAudioStatus,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AzkarAudioState].
extension AzkarAudioStatePatterns on AzkarAudioState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AzkarAudioState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AzkarAudioState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AzkarAudioState value)  $default,){
final _that = this;
switch (_that) {
case _AzkarAudioState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AzkarAudioState value)?  $default,){
final _that = this;
switch (_that) {
case _AzkarAudioState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AzkarAudioStatus status,  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AzkarAudioState() when $default != null:
return $default(_that.status,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AzkarAudioStatus status,  String? url)  $default,) {final _that = this;
switch (_that) {
case _AzkarAudioState():
return $default(_that.status,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AzkarAudioStatus status,  String? url)?  $default,) {final _that = this;
switch (_that) {
case _AzkarAudioState() when $default != null:
return $default(_that.status,_that.url);case _:
  return null;

}
}

}

/// @nodoc


class _AzkarAudioState implements AzkarAudioState {
  const _AzkarAudioState({required this.status, this.url});
  

@override final  AzkarAudioStatus status;
@override final  String? url;

/// Create a copy of AzkarAudioState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AzkarAudioStateCopyWith<_AzkarAudioState> get copyWith => __$AzkarAudioStateCopyWithImpl<_AzkarAudioState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AzkarAudioState&&(identical(other.status, status) || other.status == status)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,url);
}

@override
String toString() {
    return 'AzkarAudioState(status: $status, url: $url)';
}


}

/// @nodoc
abstract mixin class _$AzkarAudioStateCopyWith<$Res> implements $AzkarAudioStateCopyWith<$Res> {
  factory _$AzkarAudioStateCopyWith(_AzkarAudioState value, $Res Function(_AzkarAudioState) _then) = __$AzkarAudioStateCopyWithImpl;
@override @useResult
$Res call({
 AzkarAudioStatus status, String? url
});




}
/// @nodoc
class __$AzkarAudioStateCopyWithImpl<$Res>
    implements _$AzkarAudioStateCopyWith<$Res> {
  __$AzkarAudioStateCopyWithImpl(this._self, this._then);

  final _AzkarAudioState _self;
  final $Res Function(_AzkarAudioState) _then;

/// Create a copy of AzkarAudioState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? url = freezed,}) {
  return _then(_AzkarAudioState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AzkarAudioStatus,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
