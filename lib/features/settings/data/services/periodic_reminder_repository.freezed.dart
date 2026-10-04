// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'periodic_reminder_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PeriodicReminderSettings {

 bool get enabled; int get intervalMinutes;
/// Create a copy of PeriodicReminderSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodicReminderSettingsCopyWith<PeriodicReminderSettings> get copyWith => _$PeriodicReminderSettingsCopyWithImpl<PeriodicReminderSettings>(this as PeriodicReminderSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PeriodicReminderSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodicReminderSettings&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.intervalMinutes, _this.intervalMinutes) || other.intervalMinutes == _this.intervalMinutes));
}


@override
int get hashCode {
  final _this = this as PeriodicReminderSettings;
  return Object.hash(runtimeType,_this.enabled,_this.intervalMinutes);
}

@override
String toString() {
  final _this = this as PeriodicReminderSettings;
  return 'PeriodicReminderSettings(enabled: ${_this.enabled}, intervalMinutes: ${_this.intervalMinutes})';
}


}

/// @nodoc
abstract mixin class $PeriodicReminderSettingsCopyWith<$Res>  {
  factory $PeriodicReminderSettingsCopyWith(PeriodicReminderSettings value, $Res Function(PeriodicReminderSettings) _then) = _$PeriodicReminderSettingsCopyWithImpl;
@useResult
$Res call({
 bool enabled, int intervalMinutes
});




}
/// @nodoc
class _$PeriodicReminderSettingsCopyWithImpl<$Res>
    implements $PeriodicReminderSettingsCopyWith<$Res> {
  _$PeriodicReminderSettingsCopyWithImpl(this._self, this._then);

  final PeriodicReminderSettings _self;
  final $Res Function(PeriodicReminderSettings) _then;

/// Create a copy of PeriodicReminderSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? intervalMinutes = null,}) {
  return _then(PeriodicReminderSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,intervalMinutes: null == intervalMinutes ? _self.intervalMinutes : intervalMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PeriodicReminderSettings].
extension PeriodicReminderSettingsPatterns on PeriodicReminderSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodicReminderSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodicReminderSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodicReminderSettings value)  $default,){
final _that = this;
switch (_that) {
case _PeriodicReminderSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodicReminderSettings value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodicReminderSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  int intervalMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodicReminderSettings() when $default != null:
return $default(_that.enabled,_that.intervalMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  int intervalMinutes)  $default,) {final _that = this;
switch (_that) {
case _PeriodicReminderSettings():
return $default(_that.enabled,_that.intervalMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  int intervalMinutes)?  $default,) {final _that = this;
switch (_that) {
case _PeriodicReminderSettings() when $default != null:
return $default(_that.enabled,_that.intervalMinutes);case _:
  return null;

}
}

}

/// @nodoc


class _PeriodicReminderSettings implements PeriodicReminderSettings {
  const _PeriodicReminderSettings({this.enabled = PeriodicReminderConstants.defaultEnabled, this.intervalMinutes = PeriodicReminderConstants.defaultIntervalMinutes});
  

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  int intervalMinutes;

/// Create a copy of PeriodicReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeriodicReminderSettingsCopyWith<_PeriodicReminderSettings> get copyWith => __$PeriodicReminderSettingsCopyWithImpl<_PeriodicReminderSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodicReminderSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.intervalMinutes, intervalMinutes) || other.intervalMinutes == intervalMinutes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,enabled,intervalMinutes);
}

@override
String toString() {
    return 'PeriodicReminderSettings(enabled: $enabled, intervalMinutes: $intervalMinutes)';
}


}

/// @nodoc
abstract mixin class _$PeriodicReminderSettingsCopyWith<$Res> implements $PeriodicReminderSettingsCopyWith<$Res> {
  factory _$PeriodicReminderSettingsCopyWith(_PeriodicReminderSettings value, $Res Function(_PeriodicReminderSettings) _then) = __$PeriodicReminderSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, int intervalMinutes
});




}
/// @nodoc
class __$PeriodicReminderSettingsCopyWithImpl<$Res>
    implements _$PeriodicReminderSettingsCopyWith<$Res> {
  __$PeriodicReminderSettingsCopyWithImpl(this._self, this._then);

  final _PeriodicReminderSettings _self;
  final $Res Function(_PeriodicReminderSettings) _then;

/// Create a copy of PeriodicReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? intervalMinutes = null,}) {
  return _then(_PeriodicReminderSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,intervalMinutes: null == intervalMinutes ? _self.intervalMinutes : intervalMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
