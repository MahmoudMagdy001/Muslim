// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'periodic_reminder_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PeriodicReminderEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodicReminderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PeriodicReminderEvent()';
}


}

/// @nodoc
class $PeriodicReminderEventCopyWith<$Res>  {
$PeriodicReminderEventCopyWith(PeriodicReminderEvent _, $Res Function(PeriodicReminderEvent) __);
}


/// Adds pattern-matching-related methods to [PeriodicReminderEvent].
extension PeriodicReminderEventPatterns on PeriodicReminderEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PeriodicReminderLoadSettings value)?  loadSettings,TResult Function( PeriodicReminderToggleEnabled value)?  toggleEnabled,TResult Function( PeriodicReminderSetInterval value)?  setInterval,TResult Function( PeriodicReminderRescheduleIfEnabled value)?  rescheduleIfEnabled,TResult Function( PeriodicReminderCancelAndReset value)?  cancelAndReset,TResult Function( PeriodicReminderRefresh value)?  refresh,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PeriodicReminderLoadSettings() when loadSettings != null:
return loadSettings(_that);case PeriodicReminderToggleEnabled() when toggleEnabled != null:
return toggleEnabled(_that);case PeriodicReminderSetInterval() when setInterval != null:
return setInterval(_that);case PeriodicReminderRescheduleIfEnabled() when rescheduleIfEnabled != null:
return rescheduleIfEnabled(_that);case PeriodicReminderCancelAndReset() when cancelAndReset != null:
return cancelAndReset(_that);case PeriodicReminderRefresh() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PeriodicReminderLoadSettings value)  loadSettings,required TResult Function( PeriodicReminderToggleEnabled value)  toggleEnabled,required TResult Function( PeriodicReminderSetInterval value)  setInterval,required TResult Function( PeriodicReminderRescheduleIfEnabled value)  rescheduleIfEnabled,required TResult Function( PeriodicReminderCancelAndReset value)  cancelAndReset,required TResult Function( PeriodicReminderRefresh value)  refresh,}){
final _that = this;
switch (_that) {
case PeriodicReminderLoadSettings():
return loadSettings(_that);case PeriodicReminderToggleEnabled():
return toggleEnabled(_that);case PeriodicReminderSetInterval():
return setInterval(_that);case PeriodicReminderRescheduleIfEnabled():
return rescheduleIfEnabled(_that);case PeriodicReminderCancelAndReset():
return cancelAndReset(_that);case PeriodicReminderRefresh():
return refresh(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PeriodicReminderLoadSettings value)?  loadSettings,TResult? Function( PeriodicReminderToggleEnabled value)?  toggleEnabled,TResult? Function( PeriodicReminderSetInterval value)?  setInterval,TResult? Function( PeriodicReminderRescheduleIfEnabled value)?  rescheduleIfEnabled,TResult? Function( PeriodicReminderCancelAndReset value)?  cancelAndReset,TResult? Function( PeriodicReminderRefresh value)?  refresh,}){
final _that = this;
switch (_that) {
case PeriodicReminderLoadSettings() when loadSettings != null:
return loadSettings(_that);case PeriodicReminderToggleEnabled() when toggleEnabled != null:
return toggleEnabled(_that);case PeriodicReminderSetInterval() when setInterval != null:
return setInterval(_that);case PeriodicReminderRescheduleIfEnabled() when rescheduleIfEnabled != null:
return rescheduleIfEnabled(_that);case PeriodicReminderCancelAndReset() when cancelAndReset != null:
return cancelAndReset(_that);case PeriodicReminderRefresh() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadSettings,TResult Function( bool enabled)?  toggleEnabled,TResult Function( int minutes)?  setInterval,TResult Function()?  rescheduleIfEnabled,TResult Function()?  cancelAndReset,TResult Function()?  refresh,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PeriodicReminderLoadSettings() when loadSettings != null:
return loadSettings();case PeriodicReminderToggleEnabled() when toggleEnabled != null:
return toggleEnabled(_that.enabled);case PeriodicReminderSetInterval() when setInterval != null:
return setInterval(_that.minutes);case PeriodicReminderRescheduleIfEnabled() when rescheduleIfEnabled != null:
return rescheduleIfEnabled();case PeriodicReminderCancelAndReset() when cancelAndReset != null:
return cancelAndReset();case PeriodicReminderRefresh() when refresh != null:
return refresh();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadSettings,required TResult Function( bool enabled)  toggleEnabled,required TResult Function( int minutes)  setInterval,required TResult Function()  rescheduleIfEnabled,required TResult Function()  cancelAndReset,required TResult Function()  refresh,}) {final _that = this;
switch (_that) {
case PeriodicReminderLoadSettings():
return loadSettings();case PeriodicReminderToggleEnabled():
return toggleEnabled(_that.enabled);case PeriodicReminderSetInterval():
return setInterval(_that.minutes);case PeriodicReminderRescheduleIfEnabled():
return rescheduleIfEnabled();case PeriodicReminderCancelAndReset():
return cancelAndReset();case PeriodicReminderRefresh():
return refresh();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadSettings,TResult? Function( bool enabled)?  toggleEnabled,TResult? Function( int minutes)?  setInterval,TResult? Function()?  rescheduleIfEnabled,TResult? Function()?  cancelAndReset,TResult? Function()?  refresh,}) {final _that = this;
switch (_that) {
case PeriodicReminderLoadSettings() when loadSettings != null:
return loadSettings();case PeriodicReminderToggleEnabled() when toggleEnabled != null:
return toggleEnabled(_that.enabled);case PeriodicReminderSetInterval() when setInterval != null:
return setInterval(_that.minutes);case PeriodicReminderRescheduleIfEnabled() when rescheduleIfEnabled != null:
return rescheduleIfEnabled();case PeriodicReminderCancelAndReset() when cancelAndReset != null:
return cancelAndReset();case PeriodicReminderRefresh() when refresh != null:
return refresh();case _:
  return null;

}
}

}

/// @nodoc


class PeriodicReminderLoadSettings implements PeriodicReminderEvent {
  const PeriodicReminderLoadSettings();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodicReminderLoadSettings);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PeriodicReminderEvent.loadSettings()';
}


}




/// @nodoc


class PeriodicReminderToggleEnabled implements PeriodicReminderEvent {
  const PeriodicReminderToggleEnabled({required this.enabled});
  

 final  bool enabled;

/// Create a copy of PeriodicReminderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodicReminderToggleEnabledCopyWith<PeriodicReminderToggleEnabled> get copyWith => _$PeriodicReminderToggleEnabledCopyWithImpl<PeriodicReminderToggleEnabled>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodicReminderToggleEnabled&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode {
    return Object.hash(runtimeType,enabled);
}

@override
String toString() {
    return 'PeriodicReminderEvent.toggleEnabled(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $PeriodicReminderToggleEnabledCopyWith<$Res> implements $PeriodicReminderEventCopyWith<$Res> {
  factory $PeriodicReminderToggleEnabledCopyWith(PeriodicReminderToggleEnabled value, $Res Function(PeriodicReminderToggleEnabled) _then) = _$PeriodicReminderToggleEnabledCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class _$PeriodicReminderToggleEnabledCopyWithImpl<$Res>
    implements $PeriodicReminderToggleEnabledCopyWith<$Res> {
  _$PeriodicReminderToggleEnabledCopyWithImpl(this._self, this._then);

  final PeriodicReminderToggleEnabled _self;
  final $Res Function(PeriodicReminderToggleEnabled) _then;

/// Create a copy of PeriodicReminderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(PeriodicReminderToggleEnabled(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class PeriodicReminderSetInterval implements PeriodicReminderEvent {
  const PeriodicReminderSetInterval(this.minutes);
  

 final  int minutes;

/// Create a copy of PeriodicReminderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodicReminderSetIntervalCopyWith<PeriodicReminderSetInterval> get copyWith => _$PeriodicReminderSetIntervalCopyWithImpl<PeriodicReminderSetInterval>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodicReminderSetInterval&&(identical(other.minutes, minutes) || other.minutes == minutes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,minutes);
}

@override
String toString() {
    return 'PeriodicReminderEvent.setInterval(minutes: $minutes)';
}


}

/// @nodoc
abstract mixin class $PeriodicReminderSetIntervalCopyWith<$Res> implements $PeriodicReminderEventCopyWith<$Res> {
  factory $PeriodicReminderSetIntervalCopyWith(PeriodicReminderSetInterval value, $Res Function(PeriodicReminderSetInterval) _then) = _$PeriodicReminderSetIntervalCopyWithImpl;
@useResult
$Res call({
 int minutes
});




}
/// @nodoc
class _$PeriodicReminderSetIntervalCopyWithImpl<$Res>
    implements $PeriodicReminderSetIntervalCopyWith<$Res> {
  _$PeriodicReminderSetIntervalCopyWithImpl(this._self, this._then);

  final PeriodicReminderSetInterval _self;
  final $Res Function(PeriodicReminderSetInterval) _then;

/// Create a copy of PeriodicReminderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? minutes = null,}) {
  return _then(PeriodicReminderSetInterval(
null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class PeriodicReminderRescheduleIfEnabled implements PeriodicReminderEvent {
  const PeriodicReminderRescheduleIfEnabled();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodicReminderRescheduleIfEnabled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PeriodicReminderEvent.rescheduleIfEnabled()';
}


}




/// @nodoc


class PeriodicReminderCancelAndReset implements PeriodicReminderEvent {
  const PeriodicReminderCancelAndReset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodicReminderCancelAndReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PeriodicReminderEvent.cancelAndReset()';
}


}




/// @nodoc


class PeriodicReminderRefresh implements PeriodicReminderEvent {
  const PeriodicReminderRefresh();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodicReminderRefresh);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PeriodicReminderEvent.refresh()';
}


}




// dart format on
