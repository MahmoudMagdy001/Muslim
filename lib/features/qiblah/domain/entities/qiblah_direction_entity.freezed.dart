// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qiblah_direction_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QiblahDirectionEntity {

 double get qiblah; double get direction; double get offset;
/// Create a copy of QiblahDirectionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QiblahDirectionEntityCopyWith<QiblahDirectionEntity> get copyWith => _$QiblahDirectionEntityCopyWithImpl<QiblahDirectionEntity>(this as QiblahDirectionEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as QiblahDirectionEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QiblahDirectionEntity&&(identical(other.qiblah, _this.qiblah) || other.qiblah == _this.qiblah)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.offset, _this.offset) || other.offset == _this.offset));
}


@override
int get hashCode {
  final _this = this as QiblahDirectionEntity;
  return Object.hash(runtimeType,_this.qiblah,_this.direction,_this.offset);
}

@override
String toString() {
  final _this = this as QiblahDirectionEntity;
  return 'QiblahDirectionEntity(qiblah: ${_this.qiblah}, direction: ${_this.direction}, offset: ${_this.offset})';
}


}

/// @nodoc
abstract mixin class $QiblahDirectionEntityCopyWith<$Res>  {
  factory $QiblahDirectionEntityCopyWith(QiblahDirectionEntity value, $Res Function(QiblahDirectionEntity) _then) = _$QiblahDirectionEntityCopyWithImpl;
@useResult
$Res call({
 double qiblah, double direction, double offset
});




}
/// @nodoc
class _$QiblahDirectionEntityCopyWithImpl<$Res>
    implements $QiblahDirectionEntityCopyWith<$Res> {
  _$QiblahDirectionEntityCopyWithImpl(this._self, this._then);

  final QiblahDirectionEntity _self;
  final $Res Function(QiblahDirectionEntity) _then;

/// Create a copy of QiblahDirectionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? qiblah = null,Object? direction = null,Object? offset = null,}) {
  return _then(QiblahDirectionEntity(
qiblah: null == qiblah ? _self.qiblah : qiblah // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as double,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [QiblahDirectionEntity].
extension QiblahDirectionEntityPatterns on QiblahDirectionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QiblahDirectionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QiblahDirectionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QiblahDirectionEntity value)  $default,){
final _that = this;
switch (_that) {
case _QiblahDirectionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QiblahDirectionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _QiblahDirectionEntity() when $default != null:
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
case _QiblahDirectionEntity() when $default != null:
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
case _QiblahDirectionEntity():
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
case _QiblahDirectionEntity() when $default != null:
return $default(_that.qiblah,_that.direction,_that.offset);case _:
  return null;

}
}

}

/// @nodoc


class _QiblahDirectionEntity implements QiblahDirectionEntity {
  const _QiblahDirectionEntity({required this.qiblah, required this.direction, required this.offset});
  

@override final  double qiblah;
@override final  double direction;
@override final  double offset;

/// Create a copy of QiblahDirectionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QiblahDirectionEntityCopyWith<_QiblahDirectionEntity> get copyWith => __$QiblahDirectionEntityCopyWithImpl<_QiblahDirectionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QiblahDirectionEntity&&(identical(other.qiblah, qiblah) || other.qiblah == qiblah)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.offset, offset) || other.offset == offset));
}


@override
int get hashCode {
    return Object.hash(runtimeType,qiblah,direction,offset);
}

@override
String toString() {
    return 'QiblahDirectionEntity(qiblah: $qiblah, direction: $direction, offset: $offset)';
}


}

/// @nodoc
abstract mixin class _$QiblahDirectionEntityCopyWith<$Res> implements $QiblahDirectionEntityCopyWith<$Res> {
  factory _$QiblahDirectionEntityCopyWith(_QiblahDirectionEntity value, $Res Function(_QiblahDirectionEntity) _then) = __$QiblahDirectionEntityCopyWithImpl;
@override @useResult
$Res call({
 double qiblah, double direction, double offset
});




}
/// @nodoc
class __$QiblahDirectionEntityCopyWithImpl<$Res>
    implements _$QiblahDirectionEntityCopyWith<$Res> {
  __$QiblahDirectionEntityCopyWithImpl(this._self, this._then);

  final _QiblahDirectionEntity _self;
  final $Res Function(_QiblahDirectionEntity) _then;

/// Create a copy of QiblahDirectionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? qiblah = null,Object? direction = null,Object? offset = null,}) {
  return _then(_QiblahDirectionEntity(
qiblah: null == qiblah ? _self.qiblah : qiblah // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as double,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
