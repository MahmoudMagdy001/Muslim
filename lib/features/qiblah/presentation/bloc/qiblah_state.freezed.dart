// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qiblah_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QiblahState {

 QiblahStatus get status; double get qiblahAngle; double get headingAngle; bool get isAligned; String? get message;
/// Create a copy of QiblahState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QiblahStateCopyWith<QiblahState> get copyWith => _$QiblahStateCopyWithImpl<QiblahState>(this as QiblahState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as QiblahState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QiblahState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.qiblahAngle, _this.qiblahAngle) || other.qiblahAngle == _this.qiblahAngle)&&(identical(other.headingAngle, _this.headingAngle) || other.headingAngle == _this.headingAngle)&&(identical(other.isAligned, _this.isAligned) || other.isAligned == _this.isAligned)&&(identical(other.message, _this.message) || other.message == _this.message));
}


@override
int get hashCode {
  final _this = this as QiblahState;
  return Object.hash(runtimeType,_this.status,_this.qiblahAngle,_this.headingAngle,_this.isAligned,_this.message);
}

@override
String toString() {
  final _this = this as QiblahState;
  return 'QiblahState(status: ${_this.status}, qiblahAngle: ${_this.qiblahAngle}, headingAngle: ${_this.headingAngle}, isAligned: ${_this.isAligned}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $QiblahStateCopyWith<$Res>  {
  factory $QiblahStateCopyWith(QiblahState value, $Res Function(QiblahState) _then) = _$QiblahStateCopyWithImpl;
@useResult
$Res call({
 QiblahStatus status, double qiblahAngle, double headingAngle, bool isAligned, String? message
});




}
/// @nodoc
class _$QiblahStateCopyWithImpl<$Res>
    implements $QiblahStateCopyWith<$Res> {
  _$QiblahStateCopyWithImpl(this._self, this._then);

  final QiblahState _self;
  final $Res Function(QiblahState) _then;

/// Create a copy of QiblahState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? qiblahAngle = null,Object? headingAngle = null,Object? isAligned = null,Object? message = freezed,}) {
  return _then(QiblahState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QiblahStatus,qiblahAngle: null == qiblahAngle ? _self.qiblahAngle : qiblahAngle // ignore: cast_nullable_to_non_nullable
as double,headingAngle: null == headingAngle ? _self.headingAngle : headingAngle // ignore: cast_nullable_to_non_nullable
as double,isAligned: null == isAligned ? _self.isAligned : isAligned // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QiblahState].
extension QiblahStatePatterns on QiblahState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QiblahState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QiblahState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QiblahState value)  $default,){
final _that = this;
switch (_that) {
case _QiblahState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QiblahState value)?  $default,){
final _that = this;
switch (_that) {
case _QiblahState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QiblahStatus status,  double qiblahAngle,  double headingAngle,  bool isAligned,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QiblahState() when $default != null:
return $default(_that.status,_that.qiblahAngle,_that.headingAngle,_that.isAligned,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QiblahStatus status,  double qiblahAngle,  double headingAngle,  bool isAligned,  String? message)  $default,) {final _that = this;
switch (_that) {
case _QiblahState():
return $default(_that.status,_that.qiblahAngle,_that.headingAngle,_that.isAligned,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QiblahStatus status,  double qiblahAngle,  double headingAngle,  bool isAligned,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _QiblahState() when $default != null:
return $default(_that.status,_that.qiblahAngle,_that.headingAngle,_that.isAligned,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _QiblahState implements QiblahState {
  const _QiblahState({this.status = QiblahStatus.initial, this.qiblahAngle = 0.0, this.headingAngle = 0.0, this.isAligned = false, this.message});
  

@override@JsonKey() final  QiblahStatus status;
@override@JsonKey() final  double qiblahAngle;
@override@JsonKey() final  double headingAngle;
@override@JsonKey() final  bool isAligned;
@override final  String? message;

/// Create a copy of QiblahState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QiblahStateCopyWith<_QiblahState> get copyWith => __$QiblahStateCopyWithImpl<_QiblahState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QiblahState&&(identical(other.status, status) || other.status == status)&&(identical(other.qiblahAngle, qiblahAngle) || other.qiblahAngle == qiblahAngle)&&(identical(other.headingAngle, headingAngle) || other.headingAngle == headingAngle)&&(identical(other.isAligned, isAligned) || other.isAligned == isAligned)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,qiblahAngle,headingAngle,isAligned,message);
}

@override
String toString() {
    return 'QiblahState(status: $status, qiblahAngle: $qiblahAngle, headingAngle: $headingAngle, isAligned: $isAligned, message: $message)';
}


}

/// @nodoc
abstract mixin class _$QiblahStateCopyWith<$Res> implements $QiblahStateCopyWith<$Res> {
  factory _$QiblahStateCopyWith(_QiblahState value, $Res Function(_QiblahState) _then) = __$QiblahStateCopyWithImpl;
@override @useResult
$Res call({
 QiblahStatus status, double qiblahAngle, double headingAngle, bool isAligned, String? message
});




}
/// @nodoc
class __$QiblahStateCopyWithImpl<$Res>
    implements _$QiblahStateCopyWith<$Res> {
  __$QiblahStateCopyWithImpl(this._self, this._then);

  final _QiblahState _self;
  final $Res Function(_QiblahState) _then;

/// Create a copy of QiblahState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? qiblahAngle = null,Object? headingAngle = null,Object? isAligned = null,Object? message = freezed,}) {
  return _then(_QiblahState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QiblahStatus,qiblahAngle: null == qiblahAngle ? _self.qiblahAngle : qiblahAngle // ignore: cast_nullable_to_non_nullable
as double,headingAngle: null == headingAngle ? _self.headingAngle : headingAngle // ignore: cast_nullable_to_non_nullable
as double,isAligned: null == isAligned ? _self.isAligned : isAligned // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
