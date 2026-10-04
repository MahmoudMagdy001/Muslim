// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_notification_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrayerNotificationSettings {

 bool get fajrEnabled; bool get dhuhrEnabled; bool get asrEnabled; bool get maghribEnabled; bool get ishaEnabled; bool get jumuahEnabled;
/// Create a copy of PrayerNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerNotificationSettingsCopyWith<PrayerNotificationSettings> get copyWith => _$PrayerNotificationSettingsCopyWithImpl<PrayerNotificationSettings>(this as PrayerNotificationSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PrayerNotificationSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerNotificationSettings&&(identical(other.fajrEnabled, _this.fajrEnabled) || other.fajrEnabled == _this.fajrEnabled)&&(identical(other.dhuhrEnabled, _this.dhuhrEnabled) || other.dhuhrEnabled == _this.dhuhrEnabled)&&(identical(other.asrEnabled, _this.asrEnabled) || other.asrEnabled == _this.asrEnabled)&&(identical(other.maghribEnabled, _this.maghribEnabled) || other.maghribEnabled == _this.maghribEnabled)&&(identical(other.ishaEnabled, _this.ishaEnabled) || other.ishaEnabled == _this.ishaEnabled)&&(identical(other.jumuahEnabled, _this.jumuahEnabled) || other.jumuahEnabled == _this.jumuahEnabled));
}


@override
int get hashCode {
  final _this = this as PrayerNotificationSettings;
  return Object.hash(runtimeType,_this.fajrEnabled,_this.dhuhrEnabled,_this.asrEnabled,_this.maghribEnabled,_this.ishaEnabled,_this.jumuahEnabled);
}

@override
String toString() {
  final _this = this as PrayerNotificationSettings;
  return 'PrayerNotificationSettings(fajrEnabled: ${_this.fajrEnabled}, dhuhrEnabled: ${_this.dhuhrEnabled}, asrEnabled: ${_this.asrEnabled}, maghribEnabled: ${_this.maghribEnabled}, ishaEnabled: ${_this.ishaEnabled}, jumuahEnabled: ${_this.jumuahEnabled})';
}


}

/// @nodoc
abstract mixin class $PrayerNotificationSettingsCopyWith<$Res>  {
  factory $PrayerNotificationSettingsCopyWith(PrayerNotificationSettings value, $Res Function(PrayerNotificationSettings) _then) = _$PrayerNotificationSettingsCopyWithImpl;
@useResult
$Res call({
 bool fajrEnabled, bool dhuhrEnabled, bool asrEnabled, bool maghribEnabled, bool ishaEnabled, bool jumuahEnabled
});




}
/// @nodoc
class _$PrayerNotificationSettingsCopyWithImpl<$Res>
    implements $PrayerNotificationSettingsCopyWith<$Res> {
  _$PrayerNotificationSettingsCopyWithImpl(this._self, this._then);

  final PrayerNotificationSettings _self;
  final $Res Function(PrayerNotificationSettings) _then;

/// Create a copy of PrayerNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fajrEnabled = null,Object? dhuhrEnabled = null,Object? asrEnabled = null,Object? maghribEnabled = null,Object? ishaEnabled = null,Object? jumuahEnabled = null,}) {
  return _then(PrayerNotificationSettings(
fajrEnabled: null == fajrEnabled ? _self.fajrEnabled : fajrEnabled // ignore: cast_nullable_to_non_nullable
as bool,dhuhrEnabled: null == dhuhrEnabled ? _self.dhuhrEnabled : dhuhrEnabled // ignore: cast_nullable_to_non_nullable
as bool,asrEnabled: null == asrEnabled ? _self.asrEnabled : asrEnabled // ignore: cast_nullable_to_non_nullable
as bool,maghribEnabled: null == maghribEnabled ? _self.maghribEnabled : maghribEnabled // ignore: cast_nullable_to_non_nullable
as bool,ishaEnabled: null == ishaEnabled ? _self.ishaEnabled : ishaEnabled // ignore: cast_nullable_to_non_nullable
as bool,jumuahEnabled: null == jumuahEnabled ? _self.jumuahEnabled : jumuahEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PrayerNotificationSettings].
extension PrayerNotificationSettingsPatterns on PrayerNotificationSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerNotificationSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerNotificationSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerNotificationSettings value)  $default,){
final _that = this;
switch (_that) {
case _PrayerNotificationSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerNotificationSettings value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerNotificationSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool fajrEnabled,  bool dhuhrEnabled,  bool asrEnabled,  bool maghribEnabled,  bool ishaEnabled,  bool jumuahEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerNotificationSettings() when $default != null:
return $default(_that.fajrEnabled,_that.dhuhrEnabled,_that.asrEnabled,_that.maghribEnabled,_that.ishaEnabled,_that.jumuahEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool fajrEnabled,  bool dhuhrEnabled,  bool asrEnabled,  bool maghribEnabled,  bool ishaEnabled,  bool jumuahEnabled)  $default,) {final _that = this;
switch (_that) {
case _PrayerNotificationSettings():
return $default(_that.fajrEnabled,_that.dhuhrEnabled,_that.asrEnabled,_that.maghribEnabled,_that.ishaEnabled,_that.jumuahEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool fajrEnabled,  bool dhuhrEnabled,  bool asrEnabled,  bool maghribEnabled,  bool ishaEnabled,  bool jumuahEnabled)?  $default,) {final _that = this;
switch (_that) {
case _PrayerNotificationSettings() when $default != null:
return $default(_that.fajrEnabled,_that.dhuhrEnabled,_that.asrEnabled,_that.maghribEnabled,_that.ishaEnabled,_that.jumuahEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _PrayerNotificationSettings extends PrayerNotificationSettings {
  const _PrayerNotificationSettings({this.fajrEnabled = true, this.dhuhrEnabled = true, this.asrEnabled = true, this.maghribEnabled = true, this.ishaEnabled = true, this.jumuahEnabled = true}): super._();
  

@override@JsonKey() final  bool fajrEnabled;
@override@JsonKey() final  bool dhuhrEnabled;
@override@JsonKey() final  bool asrEnabled;
@override@JsonKey() final  bool maghribEnabled;
@override@JsonKey() final  bool ishaEnabled;
@override@JsonKey() final  bool jumuahEnabled;

/// Create a copy of PrayerNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerNotificationSettingsCopyWith<_PrayerNotificationSettings> get copyWith => __$PrayerNotificationSettingsCopyWithImpl<_PrayerNotificationSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerNotificationSettings&&(identical(other.fajrEnabled, fajrEnabled) || other.fajrEnabled == fajrEnabled)&&(identical(other.dhuhrEnabled, dhuhrEnabled) || other.dhuhrEnabled == dhuhrEnabled)&&(identical(other.asrEnabled, asrEnabled) || other.asrEnabled == asrEnabled)&&(identical(other.maghribEnabled, maghribEnabled) || other.maghribEnabled == maghribEnabled)&&(identical(other.ishaEnabled, ishaEnabled) || other.ishaEnabled == ishaEnabled)&&(identical(other.jumuahEnabled, jumuahEnabled) || other.jumuahEnabled == jumuahEnabled));
}


@override
int get hashCode {
    return Object.hash(runtimeType,fajrEnabled,dhuhrEnabled,asrEnabled,maghribEnabled,ishaEnabled,jumuahEnabled);
}

@override
String toString() {
    return 'PrayerNotificationSettings(fajrEnabled: $fajrEnabled, dhuhrEnabled: $dhuhrEnabled, asrEnabled: $asrEnabled, maghribEnabled: $maghribEnabled, ishaEnabled: $ishaEnabled, jumuahEnabled: $jumuahEnabled)';
}


}

/// @nodoc
abstract mixin class _$PrayerNotificationSettingsCopyWith<$Res> implements $PrayerNotificationSettingsCopyWith<$Res> {
  factory _$PrayerNotificationSettingsCopyWith(_PrayerNotificationSettings value, $Res Function(_PrayerNotificationSettings) _then) = __$PrayerNotificationSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool fajrEnabled, bool dhuhrEnabled, bool asrEnabled, bool maghribEnabled, bool ishaEnabled, bool jumuahEnabled
});




}
/// @nodoc
class __$PrayerNotificationSettingsCopyWithImpl<$Res>
    implements _$PrayerNotificationSettingsCopyWith<$Res> {
  __$PrayerNotificationSettingsCopyWithImpl(this._self, this._then);

  final _PrayerNotificationSettings _self;
  final $Res Function(_PrayerNotificationSettings) _then;

/// Create a copy of PrayerNotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fajrEnabled = null,Object? dhuhrEnabled = null,Object? asrEnabled = null,Object? maghribEnabled = null,Object? ishaEnabled = null,Object? jumuahEnabled = null,}) {
  return _then(_PrayerNotificationSettings(
fajrEnabled: null == fajrEnabled ? _self.fajrEnabled : fajrEnabled // ignore: cast_nullable_to_non_nullable
as bool,dhuhrEnabled: null == dhuhrEnabled ? _self.dhuhrEnabled : dhuhrEnabled // ignore: cast_nullable_to_non_nullable
as bool,asrEnabled: null == asrEnabled ? _self.asrEnabled : asrEnabled // ignore: cast_nullable_to_non_nullable
as bool,maghribEnabled: null == maghribEnabled ? _self.maghribEnabled : maghribEnabled // ignore: cast_nullable_to_non_nullable
as bool,ishaEnabled: null == ishaEnabled ? _self.ishaEnabled : ishaEnabled // ignore: cast_nullable_to_non_nullable
as bool,jumuahEnabled: null == jumuahEnabled ? _self.jumuahEnabled : jumuahEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
