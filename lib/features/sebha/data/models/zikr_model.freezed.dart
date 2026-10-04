// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zikr_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ZikrModel {

 String get id; String get textAr; String get textEn; int get count; bool get isCustom;
/// Create a copy of ZikrModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZikrModelCopyWith<ZikrModel> get copyWith => _$ZikrModelCopyWithImpl<ZikrModel>(this as ZikrModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ZikrModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZikrModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.textAr, _this.textAr) || other.textAr == _this.textAr)&&(identical(other.textEn, _this.textEn) || other.textEn == _this.textEn)&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.isCustom, _this.isCustom) || other.isCustom == _this.isCustom));
}


@override
int get hashCode {
  final _this = this as ZikrModel;
  return Object.hash(runtimeType,_this.id,_this.textAr,_this.textEn,_this.count,_this.isCustom);
}

@override
String toString() {
  final _this = this as ZikrModel;
  return 'ZikrModel(id: ${_this.id}, textAr: ${_this.textAr}, textEn: ${_this.textEn}, count: ${_this.count}, isCustom: ${_this.isCustom})';
}


}

/// @nodoc
abstract mixin class $ZikrModelCopyWith<$Res>  {
  factory $ZikrModelCopyWith(ZikrModel value, $Res Function(ZikrModel) _then) = _$ZikrModelCopyWithImpl;
@useResult
$Res call({
 String id, String textAr, String textEn, int count, bool isCustom
});




}
/// @nodoc
class _$ZikrModelCopyWithImpl<$Res>
    implements $ZikrModelCopyWith<$Res> {
  _$ZikrModelCopyWithImpl(this._self, this._then);

  final ZikrModel _self;
  final $Res Function(ZikrModel) _then;

/// Create a copy of ZikrModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? textAr = null,Object? textEn = null,Object? count = null,Object? isCustom = null,}) {
  return _then(ZikrModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,textAr: null == textAr ? _self.textAr : textAr // ignore: cast_nullable_to_non_nullable
as String,textEn: null == textEn ? _self.textEn : textEn // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ZikrModel].
extension ZikrModelPatterns on ZikrModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZikrModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZikrModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZikrModel value)  $default,){
final _that = this;
switch (_that) {
case _ZikrModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZikrModel value)?  $default,){
final _that = this;
switch (_that) {
case _ZikrModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String textAr,  String textEn,  int count,  bool isCustom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZikrModel() when $default != null:
return $default(_that.id,_that.textAr,_that.textEn,_that.count,_that.isCustom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String textAr,  String textEn,  int count,  bool isCustom)  $default,) {final _that = this;
switch (_that) {
case _ZikrModel():
return $default(_that.id,_that.textAr,_that.textEn,_that.count,_that.isCustom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String textAr,  String textEn,  int count,  bool isCustom)?  $default,) {final _that = this;
switch (_that) {
case _ZikrModel() when $default != null:
return $default(_that.id,_that.textAr,_that.textEn,_that.count,_that.isCustom);case _:
  return null;

}
}

}

/// @nodoc


class _ZikrModel extends ZikrModel {
  const _ZikrModel({required this.id, required this.textAr, required this.textEn, required this.count, this.isCustom = false}): super._();
  

@override final  String id;
@override final  String textAr;
@override final  String textEn;
@override final  int count;
@override@JsonKey() final  bool isCustom;

/// Create a copy of ZikrModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZikrModelCopyWith<_ZikrModel> get copyWith => __$ZikrModelCopyWithImpl<_ZikrModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZikrModel&&(identical(other.id, id) || other.id == id)&&(identical(other.textAr, textAr) || other.textAr == textAr)&&(identical(other.textEn, textEn) || other.textEn == textEn)&&(identical(other.count, count) || other.count == count)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,textAr,textEn,count,isCustom);
}

@override
String toString() {
    return 'ZikrModel(id: $id, textAr: $textAr, textEn: $textEn, count: $count, isCustom: $isCustom)';
}


}

/// @nodoc
abstract mixin class _$ZikrModelCopyWith<$Res> implements $ZikrModelCopyWith<$Res> {
  factory _$ZikrModelCopyWith(_ZikrModel value, $Res Function(_ZikrModel) _then) = __$ZikrModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String textAr, String textEn, int count, bool isCustom
});




}
/// @nodoc
class __$ZikrModelCopyWithImpl<$Res>
    implements _$ZikrModelCopyWith<$Res> {
  __$ZikrModelCopyWithImpl(this._self, this._then);

  final _ZikrModel _self;
  final $Res Function(_ZikrModel) _then;

/// Create a copy of ZikrModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? textAr = null,Object? textEn = null,Object? count = null,Object? isCustom = null,}) {
  return _then(_ZikrModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,textAr: null == textAr ? _self.textAr : textAr // ignore: cast_nullable_to_non_nullable
as String,textEn: null == textEn ? _self.textEn : textEn // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
