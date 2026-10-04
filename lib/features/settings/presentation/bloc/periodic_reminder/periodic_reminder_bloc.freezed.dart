// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'periodic_reminder_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PeriodicReminderState {

 bool get enabled; int get intervalMinutes; bool get isLoading; String? get error;
/// Create a copy of PeriodicReminderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodicReminderStateCopyWith<PeriodicReminderState> get copyWith => _$PeriodicReminderStateCopyWithImpl<PeriodicReminderState>(this as PeriodicReminderState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PeriodicReminderState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodicReminderState&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.intervalMinutes, _this.intervalMinutes) || other.intervalMinutes == _this.intervalMinutes)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as PeriodicReminderState;
  return Object.hash(runtimeType,_this.enabled,_this.intervalMinutes,_this.isLoading,_this.error);
}

@override
String toString() {
  final _this = this as PeriodicReminderState;
  return 'PeriodicReminderState(enabled: ${_this.enabled}, intervalMinutes: ${_this.intervalMinutes}, isLoading: ${_this.isLoading}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $PeriodicReminderStateCopyWith<$Res>  {
  factory $PeriodicReminderStateCopyWith(PeriodicReminderState value, $Res Function(PeriodicReminderState) _then) = _$PeriodicReminderStateCopyWithImpl;
@useResult
$Res call({
 bool enabled, int intervalMinutes, bool isLoading, String? error
});




}
/// @nodoc
class _$PeriodicReminderStateCopyWithImpl<$Res>
    implements $PeriodicReminderStateCopyWith<$Res> {
  _$PeriodicReminderStateCopyWithImpl(this._self, this._then);

  final PeriodicReminderState _self;
  final $Res Function(PeriodicReminderState) _then;

/// Create a copy of PeriodicReminderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? intervalMinutes = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(PeriodicReminderState(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,intervalMinutes: null == intervalMinutes ? _self.intervalMinutes : intervalMinutes // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PeriodicReminderState].
extension PeriodicReminderStatePatterns on PeriodicReminderState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodicReminderState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodicReminderState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodicReminderState value)  $default,){
final _that = this;
switch (_that) {
case _PeriodicReminderState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodicReminderState value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodicReminderState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  int intervalMinutes,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodicReminderState() when $default != null:
return $default(_that.enabled,_that.intervalMinutes,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  int intervalMinutes,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _PeriodicReminderState():
return $default(_that.enabled,_that.intervalMinutes,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  int intervalMinutes,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _PeriodicReminderState() when $default != null:
return $default(_that.enabled,_that.intervalMinutes,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _PeriodicReminderState implements PeriodicReminderState {
  const _PeriodicReminderState({this.enabled = PeriodicReminderConstants.defaultEnabled, this.intervalMinutes = PeriodicReminderConstants.defaultIntervalMinutes, this.isLoading = false, this.error});
  

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  int intervalMinutes;
@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of PeriodicReminderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeriodicReminderStateCopyWith<_PeriodicReminderState> get copyWith => __$PeriodicReminderStateCopyWithImpl<_PeriodicReminderState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodicReminderState&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.intervalMinutes, intervalMinutes) || other.intervalMinutes == intervalMinutes)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,enabled,intervalMinutes,isLoading,error);
}

@override
String toString() {
    return 'PeriodicReminderState(enabled: $enabled, intervalMinutes: $intervalMinutes, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PeriodicReminderStateCopyWith<$Res> implements $PeriodicReminderStateCopyWith<$Res> {
  factory _$PeriodicReminderStateCopyWith(_PeriodicReminderState value, $Res Function(_PeriodicReminderState) _then) = __$PeriodicReminderStateCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, int intervalMinutes, bool isLoading, String? error
});




}
/// @nodoc
class __$PeriodicReminderStateCopyWithImpl<$Res>
    implements _$PeriodicReminderStateCopyWith<$Res> {
  __$PeriodicReminderStateCopyWithImpl(this._self, this._then);

  final _PeriodicReminderState _self;
  final $Res Function(_PeriodicReminderState) _then;

/// Create a copy of PeriodicReminderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? intervalMinutes = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_PeriodicReminderState(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,intervalMinutes: null == intervalMinutes ? _self.intervalMinutes : intervalMinutes // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
