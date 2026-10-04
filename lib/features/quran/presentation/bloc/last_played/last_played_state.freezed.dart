// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'last_played_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LastPlayedState {

 Map<String, dynamic>? get lastPlayed;
/// Create a copy of LastPlayedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LastPlayedStateCopyWith<LastPlayedState> get copyWith => _$LastPlayedStateCopyWithImpl<LastPlayedState>(this as LastPlayedState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LastPlayedState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LastPlayedState&&const DeepCollectionEquality().equals(other.lastPlayed, _this.lastPlayed));
}


@override
int get hashCode {
  final _this = this as LastPlayedState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.lastPlayed));
}

@override
String toString() {
  final _this = this as LastPlayedState;
  return 'LastPlayedState(lastPlayed: ${_this.lastPlayed})';
}


}

/// @nodoc
abstract mixin class $LastPlayedStateCopyWith<$Res>  {
  factory $LastPlayedStateCopyWith(LastPlayedState value, $Res Function(LastPlayedState) _then) = _$LastPlayedStateCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic>? lastPlayed
});




}
/// @nodoc
class _$LastPlayedStateCopyWithImpl<$Res>
    implements $LastPlayedStateCopyWith<$Res> {
  _$LastPlayedStateCopyWithImpl(this._self, this._then);

  final LastPlayedState _self;
  final $Res Function(LastPlayedState) _then;

/// Create a copy of LastPlayedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastPlayed = freezed,}) {
  return _then(LastPlayedState(
lastPlayed: freezed == lastPlayed ? _self.lastPlayed : lastPlayed // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [LastPlayedState].
extension LastPlayedStatePatterns on LastPlayedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LastPlayedState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LastPlayedState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LastPlayedState value)  $default,){
final _that = this;
switch (_that) {
case _LastPlayedState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LastPlayedState value)?  $default,){
final _that = this;
switch (_that) {
case _LastPlayedState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, dynamic>? lastPlayed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LastPlayedState() when $default != null:
return $default(_that.lastPlayed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, dynamic>? lastPlayed)  $default,) {final _that = this;
switch (_that) {
case _LastPlayedState():
return $default(_that.lastPlayed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, dynamic>? lastPlayed)?  $default,) {final _that = this;
switch (_that) {
case _LastPlayedState() when $default != null:
return $default(_that.lastPlayed);case _:
  return null;

}
}

}

/// @nodoc


class _LastPlayedState implements LastPlayedState {
  const _LastPlayedState({ Map<String, dynamic>? lastPlayed}): _lastPlayed = lastPlayed;
  

 final  Map<String, dynamic>? _lastPlayed;
@override Map<String, dynamic>? get lastPlayed {
  final value = _lastPlayed;
  if (value == null) return null;
  if (_lastPlayed is EqualUnmodifiableMapView) return _lastPlayed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of LastPlayedState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LastPlayedStateCopyWith<_LastPlayedState> get copyWith => __$LastPlayedStateCopyWithImpl<_LastPlayedState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LastPlayedState&&const DeepCollectionEquality().equals(other.lastPlayed, _lastPlayed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_lastPlayed));
}

@override
String toString() {
    return 'LastPlayedState(lastPlayed: $lastPlayed)';
}


}

/// @nodoc
abstract mixin class _$LastPlayedStateCopyWith<$Res> implements $LastPlayedStateCopyWith<$Res> {
  factory _$LastPlayedStateCopyWith(_LastPlayedState value, $Res Function(_LastPlayedState) _then) = __$LastPlayedStateCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic>? lastPlayed
});




}
/// @nodoc
class __$LastPlayedStateCopyWithImpl<$Res>
    implements _$LastPlayedStateCopyWith<$Res> {
  __$LastPlayedStateCopyWithImpl(this._self, this._then);

  final _LastPlayedState _self;
  final $Res Function(_LastPlayedState) _then;

/// Create a copy of LastPlayedState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastPlayed = freezed,}) {
  return _then(_LastPlayedState(
lastPlayed: freezed == lastPlayed ? _self._lastPlayed : lastPlayed // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
