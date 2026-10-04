// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qiblah_direction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QiblahDirectionModel {

 double get qiblah; double get direction; double get offset;
/// Create a copy of QiblahDirectionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QiblahDirectionModelCopyWith<QiblahDirectionModel> get copyWith => _$QiblahDirectionModelCopyWithImpl<QiblahDirectionModel>(this as QiblahDirectionModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as QiblahDirectionModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QiblahDirectionModel&&(identical(other.qiblah, _this.qiblah) || other.qiblah == _this.qiblah)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.offset, _this.offset) || other.offset == _this.offset));
}


@override
int get hashCode {
  final _this = this as QiblahDirectionModel;
  return Object.hash(runtimeType,_this.qiblah,_this.direction,_this.offset);
}

@override
String toString() {
  final _this = this as QiblahDirectionModel;
  return 'QiblahDirectionModel(qiblah: ${_this.qiblah}, direction: ${_this.direction}, offset: ${_this.offset})';
}


}

/// @nodoc
abstract mixin class $QiblahDirectionModelCopyWith<$Res>  {
  factory $QiblahDirectionModelCopyWith(QiblahDirectionModel value, $Res Function(QiblahDirectionModel) _then) = _$QiblahDirectionModelCopyWithImpl;
@useResult
$Res call({
 double qiblah, double direction, double offset
});




}
/// @nodoc
class _$QiblahDirectionModelCopyWithImpl<$Res>
    implements $QiblahDirectionModelCopyWith<$Res> {
  _$QiblahDirectionModelCopyWithImpl(this._self, this._then);

  final QiblahDirectionModel _self;
  final $Res Function(QiblahDirectionModel) _then;

/// Create a copy of QiblahDirectionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? qiblah = null,Object? direction = null,Object? offset = null,}) {
  return _then(QiblahDirectionModel(
qiblah: null == qiblah ? _self.qiblah : qiblah // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as double,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [QiblahDirectionModel].
extension QiblahDirectionModelPatterns on QiblahDirectionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QiblahDirectionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QiblahDirectionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QiblahDirectionModel value)  $default,){
final _that = this;
switch (_that) {
case _QiblahDirectionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QiblahDirectionModel value)?  $default,){
final _that = this;
switch (_that) {
case _QiblahDirectionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double qiblah,  double direction,  double offset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QiblahDirectionModel() when $default != null:
return $default(_that.qiblah,_that.direction,_that.offset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double qiblah,  double direction,  double offset)  $default,) {final _that = this;
switch (_that) {
case _QiblahDirectionModel():
return $default(_that.qiblah,_that.direction,_that.offset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double qiblah,  double direction,  double offset)?  $default,) {final _that = this;
switch (_that) {
case _QiblahDirectionModel() when $default != null:
return $default(_that.qiblah,_that.direction,_that.offset);case _:
  return null;

}
}

}

/// @nodoc


class _QiblahDirectionModel extends QiblahDirectionModel {
  const _QiblahDirectionModel({required this.qiblah, required this.direction, required this.offset}): super._();
  

@override final  double qiblah;
@override final  double direction;
@override final  double offset;

/// Create a copy of QiblahDirectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QiblahDirectionModelCopyWith<_QiblahDirectionModel> get copyWith => __$QiblahDirectionModelCopyWithImpl<_QiblahDirectionModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QiblahDirectionModel&&(identical(other.qiblah, qiblah) || other.qiblah == qiblah)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.offset, offset) || other.offset == offset));
}


@override
int get hashCode {
    return Object.hash(runtimeType,qiblah,direction,offset);
}

@override
String toString() {
    return 'QiblahDirectionModel(qiblah: $qiblah, direction: $direction, offset: $offset)';
}


}

/// @nodoc
abstract mixin class _$QiblahDirectionModelCopyWith<$Res> implements $QiblahDirectionModelCopyWith<$Res> {
  factory _$QiblahDirectionModelCopyWith(_QiblahDirectionModel value, $Res Function(_QiblahDirectionModel) _then) = __$QiblahDirectionModelCopyWithImpl;
@override @useResult
$Res call({
 double qiblah, double direction, double offset
});




}
/// @nodoc
class __$QiblahDirectionModelCopyWithImpl<$Res>
    implements _$QiblahDirectionModelCopyWith<$Res> {
  __$QiblahDirectionModelCopyWithImpl(this._self, this._then);

  final _QiblahDirectionModel _self;
  final $Res Function(_QiblahDirectionModel) _then;

/// Create a copy of QiblahDirectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? qiblah = null,Object? direction = null,Object? offset = null,}) {
  return _then(_QiblahDirectionModel(
qiblah: null == qiblah ? _self.qiblah : qiblah // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as double,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
