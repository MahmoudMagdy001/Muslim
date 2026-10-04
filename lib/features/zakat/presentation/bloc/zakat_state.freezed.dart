// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zakat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ZakatState {

 ZakatRequestStatus get status; double get goldPricePerGram; String? get errorMessage;
/// Create a copy of ZakatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZakatStateCopyWith<ZakatState> get copyWith => _$ZakatStateCopyWithImpl<ZakatState>(this as ZakatState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ZakatState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZakatState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.goldPricePerGram, _this.goldPricePerGram) || other.goldPricePerGram == _this.goldPricePerGram)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as ZakatState;
  return Object.hash(runtimeType,_this.status,_this.goldPricePerGram,_this.errorMessage);
}

@override
String toString() {
  final _this = this as ZakatState;
  return 'ZakatState(status: ${_this.status}, goldPricePerGram: ${_this.goldPricePerGram}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $ZakatStateCopyWith<$Res>  {
  factory $ZakatStateCopyWith(ZakatState value, $Res Function(ZakatState) _then) = _$ZakatStateCopyWithImpl;
@useResult
$Res call({
 ZakatRequestStatus status, double goldPricePerGram, String? errorMessage
});




}
/// @nodoc
class _$ZakatStateCopyWithImpl<$Res>
    implements $ZakatStateCopyWith<$Res> {
  _$ZakatStateCopyWithImpl(this._self, this._then);

  final ZakatState _self;
  final $Res Function(ZakatState) _then;

/// Create a copy of ZakatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? goldPricePerGram = null,Object? errorMessage = freezed,}) {
  return _then(ZakatState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ZakatRequestStatus,goldPricePerGram: null == goldPricePerGram ? _self.goldPricePerGram : goldPricePerGram // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ZakatState].
extension ZakatStatePatterns on ZakatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZakatState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZakatState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZakatState value)  $default,){
final _that = this;
switch (_that) {
case _ZakatState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZakatState value)?  $default,){
final _that = this;
switch (_that) {
case _ZakatState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ZakatRequestStatus status,  double goldPricePerGram,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZakatState() when $default != null:
return $default(_that.status,_that.goldPricePerGram,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ZakatRequestStatus status,  double goldPricePerGram,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ZakatState():
return $default(_that.status,_that.goldPricePerGram,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ZakatRequestStatus status,  double goldPricePerGram,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ZakatState() when $default != null:
return $default(_that.status,_that.goldPricePerGram,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ZakatState extends ZakatState {
  const _ZakatState({this.status = ZakatRequestStatus.initial, this.goldPricePerGram = 0.0, this.errorMessage}): super._();
  

@override@JsonKey() final  ZakatRequestStatus status;
@override@JsonKey() final  double goldPricePerGram;
@override final  String? errorMessage;

/// Create a copy of ZakatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZakatStateCopyWith<_ZakatState> get copyWith => __$ZakatStateCopyWithImpl<_ZakatState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZakatState&&(identical(other.status, status) || other.status == status)&&(identical(other.goldPricePerGram, goldPricePerGram) || other.goldPricePerGram == goldPricePerGram)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,goldPricePerGram,errorMessage);
}

@override
String toString() {
    return 'ZakatState(status: $status, goldPricePerGram: $goldPricePerGram, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ZakatStateCopyWith<$Res> implements $ZakatStateCopyWith<$Res> {
  factory _$ZakatStateCopyWith(_ZakatState value, $Res Function(_ZakatState) _then) = __$ZakatStateCopyWithImpl;
@override @useResult
$Res call({
 ZakatRequestStatus status, double goldPricePerGram, String? errorMessage
});




}
/// @nodoc
class __$ZakatStateCopyWithImpl<$Res>
    implements _$ZakatStateCopyWith<$Res> {
  __$ZakatStateCopyWithImpl(this._self, this._then);

  final _ZakatState _self;
  final $Res Function(_ZakatState) _then;

/// Create a copy of ZakatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? goldPricePerGram = null,Object? errorMessage = freezed,}) {
  return _then(_ZakatState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ZakatRequestStatus,goldPricePerGram: null == goldPricePerGram ? _self.goldPricePerGram : goldPricePerGram // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
