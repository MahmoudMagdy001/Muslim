// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qiblah_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QiblahEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is QiblahEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'QiblahEvent()';
}


}

/// @nodoc
class $QiblahEventCopyWith<$Res>  {
$QiblahEventCopyWith(QiblahEvent _, $Res Function(QiblahEvent) __);
}


/// Adds pattern-matching-related methods to [QiblahEvent].
extension QiblahEventPatterns on QiblahEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( QiblahInit value)?  init,TResult Function( QiblahLocationStatusChanged value)?  locationStatusChanged,TResult Function( QiblahStartCompass value)?  startCompass,TResult Function( QiblahDataReceived value)?  qiblahDataReceived,TResult Function( QiblahLocationDisabled value)?  locationDisabled,TResult Function( QiblahErrorOccurred value)?  errorOccurred,required TResult orElse(),}){
final _that = this;
switch (_that) {
case QiblahInit() when init != null:
return init(_that);case QiblahLocationStatusChanged() when locationStatusChanged != null:
return locationStatusChanged(_that);case QiblahStartCompass() when startCompass != null:
return startCompass(_that);case QiblahDataReceived() when qiblahDataReceived != null:
return qiblahDataReceived(_that);case QiblahLocationDisabled() when locationDisabled != null:
return locationDisabled(_that);case QiblahErrorOccurred() when errorOccurred != null:
return errorOccurred(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( QiblahInit value)  init,required TResult Function( QiblahLocationStatusChanged value)  locationStatusChanged,required TResult Function( QiblahStartCompass value)  startCompass,required TResult Function( QiblahDataReceived value)  qiblahDataReceived,required TResult Function( QiblahLocationDisabled value)  locationDisabled,required TResult Function( QiblahErrorOccurred value)  errorOccurred,}){
final _that = this;
switch (_that) {
case QiblahInit():
return init(_that);case QiblahLocationStatusChanged():
return locationStatusChanged(_that);case QiblahStartCompass():
return startCompass(_that);case QiblahDataReceived():
return qiblahDataReceived(_that);case QiblahLocationDisabled():
return locationDisabled(_that);case QiblahErrorOccurred():
return errorOccurred(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( QiblahInit value)?  init,TResult? Function( QiblahLocationStatusChanged value)?  locationStatusChanged,TResult? Function( QiblahStartCompass value)?  startCompass,TResult? Function( QiblahDataReceived value)?  qiblahDataReceived,TResult? Function( QiblahLocationDisabled value)?  locationDisabled,TResult? Function( QiblahErrorOccurred value)?  errorOccurred,}){
final _that = this;
switch (_that) {
case QiblahInit() when init != null:
return init(_that);case QiblahLocationStatusChanged() when locationStatusChanged != null:
return locationStatusChanged(_that);case QiblahStartCompass() when startCompass != null:
return startCompass(_that);case QiblahDataReceived() when qiblahDataReceived != null:
return qiblahDataReceived(_that);case QiblahLocationDisabled() when locationDisabled != null:
return locationDisabled(_that);case QiblahErrorOccurred() when errorOccurred != null:
return errorOccurred(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  init,TResult Function( ServiceStatus status)?  locationStatusChanged,TResult Function()?  startCompass,TResult Function( QiblahDirectionEntity data)?  qiblahDataReceived,TResult Function()?  locationDisabled,TResult Function( String message)?  errorOccurred,required TResult orElse(),}) {final _that = this;
switch (_that) {
case QiblahInit() when init != null:
return init();case QiblahLocationStatusChanged() when locationStatusChanged != null:
return locationStatusChanged(_that.status);case QiblahStartCompass() when startCompass != null:
return startCompass();case QiblahDataReceived() when qiblahDataReceived != null:
return qiblahDataReceived(_that.data);case QiblahLocationDisabled() when locationDisabled != null:
return locationDisabled();case QiblahErrorOccurred() when errorOccurred != null:
return errorOccurred(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  init,required TResult Function( ServiceStatus status)  locationStatusChanged,required TResult Function()  startCompass,required TResult Function( QiblahDirectionEntity data)  qiblahDataReceived,required TResult Function()  locationDisabled,required TResult Function( String message)  errorOccurred,}) {final _that = this;
switch (_that) {
case QiblahInit():
return init();case QiblahLocationStatusChanged():
return locationStatusChanged(_that.status);case QiblahStartCompass():
return startCompass();case QiblahDataReceived():
return qiblahDataReceived(_that.data);case QiblahLocationDisabled():
return locationDisabled();case QiblahErrorOccurred():
return errorOccurred(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  init,TResult? Function( ServiceStatus status)?  locationStatusChanged,TResult? Function()?  startCompass,TResult? Function( QiblahDirectionEntity data)?  qiblahDataReceived,TResult? Function()?  locationDisabled,TResult? Function( String message)?  errorOccurred,}) {final _that = this;
switch (_that) {
case QiblahInit() when init != null:
return init();case QiblahLocationStatusChanged() when locationStatusChanged != null:
return locationStatusChanged(_that.status);case QiblahStartCompass() when startCompass != null:
return startCompass();case QiblahDataReceived() when qiblahDataReceived != null:
return qiblahDataReceived(_that.data);case QiblahLocationDisabled() when locationDisabled != null:
return locationDisabled();case QiblahErrorOccurred() when errorOccurred != null:
return errorOccurred(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class QiblahInit implements QiblahEvent {
  const QiblahInit();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is QiblahInit);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'QiblahEvent.init()';
}


}




/// @nodoc


class QiblahLocationStatusChanged implements QiblahEvent {
  const QiblahLocationStatusChanged(this.status);
  

 final  ServiceStatus status;

/// Create a copy of QiblahEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QiblahLocationStatusChangedCopyWith<QiblahLocationStatusChanged> get copyWith => _$QiblahLocationStatusChangedCopyWithImpl<QiblahLocationStatusChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is QiblahLocationStatusChanged&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status);
}

@override
String toString() {
    return 'QiblahEvent.locationStatusChanged(status: $status)';
}


}

/// @nodoc
abstract mixin class $QiblahLocationStatusChangedCopyWith<$Res> implements $QiblahEventCopyWith<$Res> {
  factory $QiblahLocationStatusChangedCopyWith(QiblahLocationStatusChanged value, $Res Function(QiblahLocationStatusChanged) _then) = _$QiblahLocationStatusChangedCopyWithImpl;
@useResult
$Res call({
 ServiceStatus status
});




}
/// @nodoc
class _$QiblahLocationStatusChangedCopyWithImpl<$Res>
    implements $QiblahLocationStatusChangedCopyWith<$Res> {
  _$QiblahLocationStatusChangedCopyWithImpl(this._self, this._then);

  final QiblahLocationStatusChanged _self;
  final $Res Function(QiblahLocationStatusChanged) _then;

/// Create a copy of QiblahEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(QiblahLocationStatusChanged(
null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ServiceStatus,
  ));
}


}

/// @nodoc


class QiblahStartCompass implements QiblahEvent {
  const QiblahStartCompass();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is QiblahStartCompass);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'QiblahEvent.startCompass()';
}


}




/// @nodoc


class QiblahDataReceived implements QiblahEvent {
  const QiblahDataReceived(this.data);
  

 final  QiblahDirectionEntity data;

/// Create a copy of QiblahEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QiblahDataReceivedCopyWith<QiblahDataReceived> get copyWith => _$QiblahDataReceivedCopyWithImpl<QiblahDataReceived>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is QiblahDataReceived&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode {
    return Object.hash(runtimeType,data);
}

@override
String toString() {
    return 'QiblahEvent.qiblahDataReceived(data: $data)';
}


}

/// @nodoc
abstract mixin class $QiblahDataReceivedCopyWith<$Res> implements $QiblahEventCopyWith<$Res> {
  factory $QiblahDataReceivedCopyWith(QiblahDataReceived value, $Res Function(QiblahDataReceived) _then) = _$QiblahDataReceivedCopyWithImpl;
@useResult
$Res call({
 QiblahDirectionEntity data
});


$QiblahDirectionEntityCopyWith<$Res> get data;

}
/// @nodoc
class _$QiblahDataReceivedCopyWithImpl<$Res>
    implements $QiblahDataReceivedCopyWith<$Res> {
  _$QiblahDataReceivedCopyWithImpl(this._self, this._then);

  final QiblahDataReceived _self;
  final $Res Function(QiblahDataReceived) _then;

/// Create a copy of QiblahEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(QiblahDataReceived(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as QiblahDirectionEntity,
  ));
}

/// Create a copy of QiblahEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QiblahDirectionEntityCopyWith<$Res> get data {
  
  return $QiblahDirectionEntityCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class QiblahLocationDisabled implements QiblahEvent {
  const QiblahLocationDisabled();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is QiblahLocationDisabled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'QiblahEvent.locationDisabled()';
}


}




/// @nodoc


class QiblahErrorOccurred implements QiblahEvent {
  const QiblahErrorOccurred(this.message);
  

 final  String message;

/// Create a copy of QiblahEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QiblahErrorOccurredCopyWith<QiblahErrorOccurred> get copyWith => _$QiblahErrorOccurredCopyWithImpl<QiblahErrorOccurred>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is QiblahErrorOccurred&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'QiblahEvent.errorOccurred(message: $message)';
}


}

/// @nodoc
abstract mixin class $QiblahErrorOccurredCopyWith<$Res> implements $QiblahEventCopyWith<$Res> {
  factory $QiblahErrorOccurredCopyWith(QiblahErrorOccurred value, $Res Function(QiblahErrorOccurred) _then) = _$QiblahErrorOccurredCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$QiblahErrorOccurredCopyWithImpl<$Res>
    implements $QiblahErrorOccurredCopyWith<$Res> {
  _$QiblahErrorOccurredCopyWithImpl(this._self, this._then);

  final QiblahErrorOccurred _self;
  final $Res Function(QiblahErrorOccurred) _then;

/// Create a copy of QiblahEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(QiblahErrorOccurred(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
