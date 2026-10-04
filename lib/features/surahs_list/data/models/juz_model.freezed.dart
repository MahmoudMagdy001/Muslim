// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'juz_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JuzModel {

 int get number; int get startSurah; int get startAyah; int get endSurah; int get endAyah; String get startSurahName; String get endSurahName;
/// Create a copy of JuzModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JuzModelCopyWith<JuzModel> get copyWith => _$JuzModelCopyWithImpl<JuzModel>(this as JuzModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as JuzModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JuzModel&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.startSurah, _this.startSurah) || other.startSurah == _this.startSurah)&&(identical(other.startAyah, _this.startAyah) || other.startAyah == _this.startAyah)&&(identical(other.endSurah, _this.endSurah) || other.endSurah == _this.endSurah)&&(identical(other.endAyah, _this.endAyah) || other.endAyah == _this.endAyah)&&(identical(other.startSurahName, _this.startSurahName) || other.startSurahName == _this.startSurahName)&&(identical(other.endSurahName, _this.endSurahName) || other.endSurahName == _this.endSurahName));
}


@override
int get hashCode {
  final _this = this as JuzModel;
  return Object.hash(runtimeType,_this.number,_this.startSurah,_this.startAyah,_this.endSurah,_this.endAyah,_this.startSurahName,_this.endSurahName);
}

@override
String toString() {
  final _this = this as JuzModel;
  return 'JuzModel(number: ${_this.number}, startSurah: ${_this.startSurah}, startAyah: ${_this.startAyah}, endSurah: ${_this.endSurah}, endAyah: ${_this.endAyah}, startSurahName: ${_this.startSurahName}, endSurahName: ${_this.endSurahName})';
}


}

/// @nodoc
abstract mixin class $JuzModelCopyWith<$Res>  {
  factory $JuzModelCopyWith(JuzModel value, $Res Function(JuzModel) _then) = _$JuzModelCopyWithImpl;
@useResult
$Res call({
 int number, int startSurah, int startAyah, int endSurah, int endAyah, String startSurahName, String endSurahName
});




}
/// @nodoc
class _$JuzModelCopyWithImpl<$Res>
    implements $JuzModelCopyWith<$Res> {
  _$JuzModelCopyWithImpl(this._self, this._then);

  final JuzModel _self;
  final $Res Function(JuzModel) _then;

/// Create a copy of JuzModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? startSurah = null,Object? startAyah = null,Object? endSurah = null,Object? endAyah = null,Object? startSurahName = null,Object? endSurahName = null,}) {
  return _then(JuzModel(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,startSurah: null == startSurah ? _self.startSurah : startSurah // ignore: cast_nullable_to_non_nullable
as int,startAyah: null == startAyah ? _self.startAyah : startAyah // ignore: cast_nullable_to_non_nullable
as int,endSurah: null == endSurah ? _self.endSurah : endSurah // ignore: cast_nullable_to_non_nullable
as int,endAyah: null == endAyah ? _self.endAyah : endAyah // ignore: cast_nullable_to_non_nullable
as int,startSurahName: null == startSurahName ? _self.startSurahName : startSurahName // ignore: cast_nullable_to_non_nullable
as String,endSurahName: null == endSurahName ? _self.endSurahName : endSurahName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JuzModel].
extension JuzModelPatterns on JuzModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JuzModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JuzModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JuzModel value)  $default,){
final _that = this;
switch (_that) {
case _JuzModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JuzModel value)?  $default,){
final _that = this;
switch (_that) {
case _JuzModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number,  int startSurah,  int startAyah,  int endSurah,  int endAyah,  String startSurahName,  String endSurahName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JuzModel() when $default != null:
return $default(_that.number,_that.startSurah,_that.startAyah,_that.endSurah,_that.endAyah,_that.startSurahName,_that.endSurahName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number,  int startSurah,  int startAyah,  int endSurah,  int endAyah,  String startSurahName,  String endSurahName)  $default,) {final _that = this;
switch (_that) {
case _JuzModel():
return $default(_that.number,_that.startSurah,_that.startAyah,_that.endSurah,_that.endAyah,_that.startSurahName,_that.endSurahName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number,  int startSurah,  int startAyah,  int endSurah,  int endAyah,  String startSurahName,  String endSurahName)?  $default,) {final _that = this;
switch (_that) {
case _JuzModel() when $default != null:
return $default(_that.number,_that.startSurah,_that.startAyah,_that.endSurah,_that.endAyah,_that.startSurahName,_that.endSurahName);case _:
  return null;

}
}

}

/// @nodoc


class _JuzModel extends JuzModel {
  const _JuzModel({required this.number, required this.startSurah, required this.startAyah, required this.endSurah, required this.endAyah, this.startSurahName = '', this.endSurahName = ''}): super._();
  

@override final  int number;
@override final  int startSurah;
@override final  int startAyah;
@override final  int endSurah;
@override final  int endAyah;
@override@JsonKey() final  String startSurahName;
@override@JsonKey() final  String endSurahName;

/// Create a copy of JuzModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JuzModelCopyWith<_JuzModel> get copyWith => __$JuzModelCopyWithImpl<_JuzModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JuzModel&&(identical(other.number, number) || other.number == number)&&(identical(other.startSurah, startSurah) || other.startSurah == startSurah)&&(identical(other.startAyah, startAyah) || other.startAyah == startAyah)&&(identical(other.endSurah, endSurah) || other.endSurah == endSurah)&&(identical(other.endAyah, endAyah) || other.endAyah == endAyah)&&(identical(other.startSurahName, startSurahName) || other.startSurahName == startSurahName)&&(identical(other.endSurahName, endSurahName) || other.endSurahName == endSurahName));
}


@override
int get hashCode {
    return Object.hash(runtimeType,number,startSurah,startAyah,endSurah,endAyah,startSurahName,endSurahName);
}

@override
String toString() {
    return 'JuzModel(number: $number, startSurah: $startSurah, startAyah: $startAyah, endSurah: $endSurah, endAyah: $endAyah, startSurahName: $startSurahName, endSurahName: $endSurahName)';
}


}

/// @nodoc
abstract mixin class _$JuzModelCopyWith<$Res> implements $JuzModelCopyWith<$Res> {
  factory _$JuzModelCopyWith(_JuzModel value, $Res Function(_JuzModel) _then) = __$JuzModelCopyWithImpl;
@override @useResult
$Res call({
 int number, int startSurah, int startAyah, int endSurah, int endAyah, String startSurahName, String endSurahName
});




}
/// @nodoc
class __$JuzModelCopyWithImpl<$Res>
    implements _$JuzModelCopyWith<$Res> {
  __$JuzModelCopyWithImpl(this._self, this._then);

  final _JuzModel _self;
  final $Res Function(_JuzModel) _then;

/// Create a copy of JuzModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? startSurah = null,Object? startAyah = null,Object? endSurah = null,Object? endAyah = null,Object? startSurahName = null,Object? endSurahName = null,}) {
  return _then(_JuzModel(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,startSurah: null == startSurah ? _self.startSurah : startSurah // ignore: cast_nullable_to_non_nullable
as int,startAyah: null == startAyah ? _self.startAyah : startAyah // ignore: cast_nullable_to_non_nullable
as int,endSurah: null == endSurah ? _self.endSurah : endSurah // ignore: cast_nullable_to_non_nullable
as int,endAyah: null == endAyah ? _self.endAyah : endAyah // ignore: cast_nullable_to_non_nullable
as int,startSurahName: null == startSurahName ? _self.startSurahName : startSurahName // ignore: cast_nullable_to_non_nullable
as String,endSurahName: null == endSurahName ? _self.endSurahName : endSurahName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
