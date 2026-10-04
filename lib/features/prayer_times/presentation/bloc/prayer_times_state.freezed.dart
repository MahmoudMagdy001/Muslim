// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_times_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrayerTimesState {

 RequestStatus get status; LocalPrayerTimes? get localPrayerTimes; PrayerType? get nextPrayer; Duration? get timeLeft; DateTime? get previousPrayerDateTime; DateTime? get lastUpdated; String? get city; String? get message; PrayerNotificationSettings get notificationSettings;
/// Create a copy of PrayerTimesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerTimesStateCopyWith<PrayerTimesState> get copyWith => _$PrayerTimesStateCopyWithImpl<PrayerTimesState>(this as PrayerTimesState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PrayerTimesState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerTimesState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.localPrayerTimes, _this.localPrayerTimes) || other.localPrayerTimes == _this.localPrayerTimes)&&(identical(other.nextPrayer, _this.nextPrayer) || other.nextPrayer == _this.nextPrayer)&&(identical(other.timeLeft, _this.timeLeft) || other.timeLeft == _this.timeLeft)&&(identical(other.previousPrayerDateTime, _this.previousPrayerDateTime) || other.previousPrayerDateTime == _this.previousPrayerDateTime)&&(identical(other.lastUpdated, _this.lastUpdated) || other.lastUpdated == _this.lastUpdated)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.notificationSettings, _this.notificationSettings) || other.notificationSettings == _this.notificationSettings));
}


@override
int get hashCode {
  final _this = this as PrayerTimesState;
  return Object.hash(runtimeType,_this.status,_this.localPrayerTimes,_this.nextPrayer,_this.timeLeft,_this.previousPrayerDateTime,_this.lastUpdated,_this.city,_this.message,_this.notificationSettings);
}

@override
String toString() {
  final _this = this as PrayerTimesState;
  return 'PrayerTimesState(status: ${_this.status}, localPrayerTimes: ${_this.localPrayerTimes}, nextPrayer: ${_this.nextPrayer}, timeLeft: ${_this.timeLeft}, previousPrayerDateTime: ${_this.previousPrayerDateTime}, lastUpdated: ${_this.lastUpdated}, city: ${_this.city}, message: ${_this.message}, notificationSettings: ${_this.notificationSettings})';
}


}

/// @nodoc
abstract mixin class $PrayerTimesStateCopyWith<$Res>  {
  factory $PrayerTimesStateCopyWith(PrayerTimesState value, $Res Function(PrayerTimesState) _then) = _$PrayerTimesStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, LocalPrayerTimes? localPrayerTimes, PrayerType? nextPrayer, Duration? timeLeft, DateTime? previousPrayerDateTime, DateTime? lastUpdated, String? city, String? message, PrayerNotificationSettings notificationSettings
});


$LocalPrayerTimesCopyWith<$Res>? get localPrayerTimes;$PrayerNotificationSettingsCopyWith<$Res> get notificationSettings;

}
/// @nodoc
class _$PrayerTimesStateCopyWithImpl<$Res>
    implements $PrayerTimesStateCopyWith<$Res> {
  _$PrayerTimesStateCopyWithImpl(this._self, this._then);

  final PrayerTimesState _self;
  final $Res Function(PrayerTimesState) _then;

/// Create a copy of PrayerTimesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? localPrayerTimes = freezed,Object? nextPrayer = freezed,Object? timeLeft = freezed,Object? previousPrayerDateTime = freezed,Object? lastUpdated = freezed,Object? city = freezed,Object? message = freezed,Object? notificationSettings = null,}) {
  return _then(PrayerTimesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,localPrayerTimes: freezed == localPrayerTimes ? _self.localPrayerTimes : localPrayerTimes // ignore: cast_nullable_to_non_nullable
as LocalPrayerTimes?,nextPrayer: freezed == nextPrayer ? _self.nextPrayer : nextPrayer // ignore: cast_nullable_to_non_nullable
as PrayerType?,timeLeft: freezed == timeLeft ? _self.timeLeft : timeLeft // ignore: cast_nullable_to_non_nullable
as Duration?,previousPrayerDateTime: freezed == previousPrayerDateTime ? _self.previousPrayerDateTime : previousPrayerDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,notificationSettings: null == notificationSettings ? _self.notificationSettings : notificationSettings // ignore: cast_nullable_to_non_nullable
as PrayerNotificationSettings,
  ));
}
/// Create a copy of PrayerTimesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalPrayerTimesCopyWith<$Res>? get localPrayerTimes {
    if (_self.localPrayerTimes == null) {
    return null;
  }

  return $LocalPrayerTimesCopyWith<$Res>(_self.localPrayerTimes!, (value) {
    return _then(_self.copyWith(localPrayerTimes: value));
  });
}/// Create a copy of PrayerTimesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrayerNotificationSettingsCopyWith<$Res> get notificationSettings {
  
  return $PrayerNotificationSettingsCopyWith<$Res>(_self.notificationSettings, (value) {
    return _then(_self.copyWith(notificationSettings: value));
  });
}
}


/// Adds pattern-matching-related methods to [PrayerTimesState].
extension PrayerTimesStatePatterns on PrayerTimesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerTimesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerTimesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerTimesState value)  $default,){
final _that = this;
switch (_that) {
case _PrayerTimesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerTimesState value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerTimesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  LocalPrayerTimes? localPrayerTimes,  PrayerType? nextPrayer,  Duration? timeLeft,  DateTime? previousPrayerDateTime,  DateTime? lastUpdated,  String? city,  String? message,  PrayerNotificationSettings notificationSettings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerTimesState() when $default != null:
return $default(_that.status,_that.localPrayerTimes,_that.nextPrayer,_that.timeLeft,_that.previousPrayerDateTime,_that.lastUpdated,_that.city,_that.message,_that.notificationSettings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  LocalPrayerTimes? localPrayerTimes,  PrayerType? nextPrayer,  Duration? timeLeft,  DateTime? previousPrayerDateTime,  DateTime? lastUpdated,  String? city,  String? message,  PrayerNotificationSettings notificationSettings)  $default,) {final _that = this;
switch (_that) {
case _PrayerTimesState():
return $default(_that.status,_that.localPrayerTimes,_that.nextPrayer,_that.timeLeft,_that.previousPrayerDateTime,_that.lastUpdated,_that.city,_that.message,_that.notificationSettings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  LocalPrayerTimes? localPrayerTimes,  PrayerType? nextPrayer,  Duration? timeLeft,  DateTime? previousPrayerDateTime,  DateTime? lastUpdated,  String? city,  String? message,  PrayerNotificationSettings notificationSettings)?  $default,) {final _that = this;
switch (_that) {
case _PrayerTimesState() when $default != null:
return $default(_that.status,_that.localPrayerTimes,_that.nextPrayer,_that.timeLeft,_that.previousPrayerDateTime,_that.lastUpdated,_that.city,_that.message,_that.notificationSettings);case _:
  return null;

}
}

}

/// @nodoc


class _PrayerTimesState implements PrayerTimesState {
  const _PrayerTimesState({this.status = RequestStatus.initial, this.localPrayerTimes, this.nextPrayer, this.timeLeft, this.previousPrayerDateTime, this.lastUpdated, this.city, this.message, this.notificationSettings = const PrayerNotificationSettings()});
  

@override@JsonKey() final  RequestStatus status;
@override final  LocalPrayerTimes? localPrayerTimes;
@override final  PrayerType? nextPrayer;
@override final  Duration? timeLeft;
@override final  DateTime? previousPrayerDateTime;
@override final  DateTime? lastUpdated;
@override final  String? city;
@override final  String? message;
@override@JsonKey() final  PrayerNotificationSettings notificationSettings;

/// Create a copy of PrayerTimesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerTimesStateCopyWith<_PrayerTimesState> get copyWith => __$PrayerTimesStateCopyWithImpl<_PrayerTimesState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerTimesState&&(identical(other.status, status) || other.status == status)&&(identical(other.localPrayerTimes, localPrayerTimes) || other.localPrayerTimes == localPrayerTimes)&&(identical(other.nextPrayer, nextPrayer) || other.nextPrayer == nextPrayer)&&(identical(other.timeLeft, timeLeft) || other.timeLeft == timeLeft)&&(identical(other.previousPrayerDateTime, previousPrayerDateTime) || other.previousPrayerDateTime == previousPrayerDateTime)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.city, city) || other.city == city)&&(identical(other.message, message) || other.message == message)&&(identical(other.notificationSettings, notificationSettings) || other.notificationSettings == notificationSettings));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,localPrayerTimes,nextPrayer,timeLeft,previousPrayerDateTime,lastUpdated,city,message,notificationSettings);
}

@override
String toString() {
    return 'PrayerTimesState(status: $status, localPrayerTimes: $localPrayerTimes, nextPrayer: $nextPrayer, timeLeft: $timeLeft, previousPrayerDateTime: $previousPrayerDateTime, lastUpdated: $lastUpdated, city: $city, message: $message, notificationSettings: $notificationSettings)';
}


}

/// @nodoc
abstract mixin class _$PrayerTimesStateCopyWith<$Res> implements $PrayerTimesStateCopyWith<$Res> {
  factory _$PrayerTimesStateCopyWith(_PrayerTimesState value, $Res Function(_PrayerTimesState) _then) = __$PrayerTimesStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, LocalPrayerTimes? localPrayerTimes, PrayerType? nextPrayer, Duration? timeLeft, DateTime? previousPrayerDateTime, DateTime? lastUpdated, String? city, String? message, PrayerNotificationSettings notificationSettings
});


@override $LocalPrayerTimesCopyWith<$Res>? get localPrayerTimes;@override $PrayerNotificationSettingsCopyWith<$Res> get notificationSettings;

}
/// @nodoc
class __$PrayerTimesStateCopyWithImpl<$Res>
    implements _$PrayerTimesStateCopyWith<$Res> {
  __$PrayerTimesStateCopyWithImpl(this._self, this._then);

  final _PrayerTimesState _self;
  final $Res Function(_PrayerTimesState) _then;

/// Create a copy of PrayerTimesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? localPrayerTimes = freezed,Object? nextPrayer = freezed,Object? timeLeft = freezed,Object? previousPrayerDateTime = freezed,Object? lastUpdated = freezed,Object? city = freezed,Object? message = freezed,Object? notificationSettings = null,}) {
  return _then(_PrayerTimesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,localPrayerTimes: freezed == localPrayerTimes ? _self.localPrayerTimes : localPrayerTimes // ignore: cast_nullable_to_non_nullable
as LocalPrayerTimes?,nextPrayer: freezed == nextPrayer ? _self.nextPrayer : nextPrayer // ignore: cast_nullable_to_non_nullable
as PrayerType?,timeLeft: freezed == timeLeft ? _self.timeLeft : timeLeft // ignore: cast_nullable_to_non_nullable
as Duration?,previousPrayerDateTime: freezed == previousPrayerDateTime ? _self.previousPrayerDateTime : previousPrayerDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,notificationSettings: null == notificationSettings ? _self.notificationSettings : notificationSettings // ignore: cast_nullable_to_non_nullable
as PrayerNotificationSettings,
  ));
}

/// Create a copy of PrayerTimesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalPrayerTimesCopyWith<$Res>? get localPrayerTimes {
    if (_self.localPrayerTimes == null) {
    return null;
  }

  return $LocalPrayerTimesCopyWith<$Res>(_self.localPrayerTimes!, (value) {
    return _then(_self.copyWith(localPrayerTimes: value));
  });
}/// Create a copy of PrayerTimesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrayerNotificationSettingsCopyWith<$Res> get notificationSettings {
  
  return $PrayerNotificationSettingsCopyWith<$Res>(_self.notificationSettings, (value) {
    return _then(_self.copyWith(notificationSettings: value));
  });
}
}

// dart format on
