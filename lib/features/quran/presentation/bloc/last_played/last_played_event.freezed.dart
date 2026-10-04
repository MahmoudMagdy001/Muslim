// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'last_played_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LastPlayedEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LastPlayedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LastPlayedEvent()';
}


}

/// @nodoc
class $LastPlayedEventCopyWith<$Res>  {
$LastPlayedEventCopyWith(LastPlayedEvent _, $Res Function(LastPlayedEvent) __);
}


/// Adds pattern-matching-related methods to [LastPlayedEvent].
extension LastPlayedEventPatterns on LastPlayedEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LastPlayedInitialize value)?  initialize,TResult Function( LastPlayedDataReceived value)?  dataReceived,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LastPlayedInitialize() when initialize != null:
return initialize(_that);case LastPlayedDataReceived() when dataReceived != null:
return dataReceived(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LastPlayedInitialize value)  initialize,required TResult Function( LastPlayedDataReceived value)  dataReceived,}){
final _that = this;
switch (_that) {
case LastPlayedInitialize():
return initialize(_that);case LastPlayedDataReceived():
return dataReceived(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LastPlayedInitialize value)?  initialize,TResult? Function( LastPlayedDataReceived value)?  dataReceived,}){
final _that = this;
switch (_that) {
case LastPlayedInitialize() when initialize != null:
return initialize(_that);case LastPlayedDataReceived() when dataReceived != null:
return dataReceived(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialize,TResult Function( Map<String, dynamic>? data)?  dataReceived,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LastPlayedInitialize() when initialize != null:
return initialize();case LastPlayedDataReceived() when dataReceived != null:
return dataReceived(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialize,required TResult Function( Map<String, dynamic>? data)  dataReceived,}) {final _that = this;
switch (_that) {
case LastPlayedInitialize():
return initialize();case LastPlayedDataReceived():
return dataReceived(_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialize,TResult? Function( Map<String, dynamic>? data)?  dataReceived,}) {final _that = this;
switch (_that) {
case LastPlayedInitialize() when initialize != null:
return initialize();case LastPlayedDataReceived() when dataReceived != null:
return dataReceived(_that.data);case _:
  return null;

}
}

}

/// @nodoc


class LastPlayedInitialize implements LastPlayedEvent {
  const LastPlayedInitialize();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LastPlayedInitialize);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LastPlayedEvent.initialize()';
}


}




/// @nodoc


class LastPlayedDataReceived implements LastPlayedEvent {
  const LastPlayedDataReceived( Map<String, dynamic>? data): _data = data;
  

 final  Map<String, dynamic>? _data;
 Map<String, dynamic>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of LastPlayedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LastPlayedDataReceivedCopyWith<LastPlayedDataReceived> get copyWith => _$LastPlayedDataReceivedCopyWithImpl<LastPlayedDataReceived>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LastPlayedDataReceived&&const DeepCollectionEquality().equals(other.data, _data));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));
}

@override
String toString() {
    return 'LastPlayedEvent.dataReceived(data: $data)';
}


}

/// @nodoc
abstract mixin class $LastPlayedDataReceivedCopyWith<$Res> implements $LastPlayedEventCopyWith<$Res> {
  factory $LastPlayedDataReceivedCopyWith(LastPlayedDataReceived value, $Res Function(LastPlayedDataReceived) _then) = _$LastPlayedDataReceivedCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic>? data
});




}
/// @nodoc
class _$LastPlayedDataReceivedCopyWithImpl<$Res>
    implements $LastPlayedDataReceivedCopyWith<$Res> {
  _$LastPlayedDataReceivedCopyWithImpl(this._self, this._then);

  final LastPlayedDataReceived _self;
  final $Res Function(LastPlayedDataReceived) _then;

/// Create a copy of LastPlayedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(LastPlayedDataReceived(
freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
