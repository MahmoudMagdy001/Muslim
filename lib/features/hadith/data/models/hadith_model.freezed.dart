// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hadith_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HadithModel {

 String get id; String get hadithNumber; String get hadithArabic; String get hadithEnglish; String get headingArabic; String get headingEnglish; String get status;
/// Create a copy of HadithModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HadithModelCopyWith<HadithModel> get copyWith => _$HadithModelCopyWithImpl<HadithModel>(this as HadithModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HadithModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HadithModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.hadithNumber, _this.hadithNumber) || other.hadithNumber == _this.hadithNumber)&&(identical(other.hadithArabic, _this.hadithArabic) || other.hadithArabic == _this.hadithArabic)&&(identical(other.hadithEnglish, _this.hadithEnglish) || other.hadithEnglish == _this.hadithEnglish)&&(identical(other.headingArabic, _this.headingArabic) || other.headingArabic == _this.headingArabic)&&(identical(other.headingEnglish, _this.headingEnglish) || other.headingEnglish == _this.headingEnglish)&&(identical(other.status, _this.status) || other.status == _this.status));
}


@override
int get hashCode {
  final _this = this as HadithModel;
  return Object.hash(runtimeType,_this.id,_this.hadithNumber,_this.hadithArabic,_this.hadithEnglish,_this.headingArabic,_this.headingEnglish,_this.status);
}

@override
String toString() {
  final _this = this as HadithModel;
  return 'HadithModel(id: ${_this.id}, hadithNumber: ${_this.hadithNumber}, hadithArabic: ${_this.hadithArabic}, hadithEnglish: ${_this.hadithEnglish}, headingArabic: ${_this.headingArabic}, headingEnglish: ${_this.headingEnglish}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $HadithModelCopyWith<$Res>  {
  factory $HadithModelCopyWith(HadithModel value, $Res Function(HadithModel) _then) = _$HadithModelCopyWithImpl;
@useResult
$Res call({
 String id, String hadithNumber, String hadithArabic, String hadithEnglish, String headingArabic, String headingEnglish, String status
});




}
/// @nodoc
class _$HadithModelCopyWithImpl<$Res>
    implements $HadithModelCopyWith<$Res> {
  _$HadithModelCopyWithImpl(this._self, this._then);

  final HadithModel _self;
  final $Res Function(HadithModel) _then;

/// Create a copy of HadithModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? hadithNumber = null,Object? hadithArabic = null,Object? hadithEnglish = null,Object? headingArabic = null,Object? headingEnglish = null,Object? status = null,}) {
  return _then(HadithModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hadithNumber: null == hadithNumber ? _self.hadithNumber : hadithNumber // ignore: cast_nullable_to_non_nullable
as String,hadithArabic: null == hadithArabic ? _self.hadithArabic : hadithArabic // ignore: cast_nullable_to_non_nullable
as String,hadithEnglish: null == hadithEnglish ? _self.hadithEnglish : hadithEnglish // ignore: cast_nullable_to_non_nullable
as String,headingArabic: null == headingArabic ? _self.headingArabic : headingArabic // ignore: cast_nullable_to_non_nullable
as String,headingEnglish: null == headingEnglish ? _self.headingEnglish : headingEnglish // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HadithModel].
extension HadithModelPatterns on HadithModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HadithModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HadithModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HadithModel value)  $default,){
final _that = this;
switch (_that) {
case _HadithModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HadithModel value)?  $default,){
final _that = this;
switch (_that) {
case _HadithModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String hadithNumber,  String hadithArabic,  String hadithEnglish,  String headingArabic,  String headingEnglish,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HadithModel() when $default != null:
return $default(_that.id,_that.hadithNumber,_that.hadithArabic,_that.hadithEnglish,_that.headingArabic,_that.headingEnglish,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String hadithNumber,  String hadithArabic,  String hadithEnglish,  String headingArabic,  String headingEnglish,  String status)  $default,) {final _that = this;
switch (_that) {
case _HadithModel():
return $default(_that.id,_that.hadithNumber,_that.hadithArabic,_that.hadithEnglish,_that.headingArabic,_that.headingEnglish,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String hadithNumber,  String hadithArabic,  String hadithEnglish,  String headingArabic,  String headingEnglish,  String status)?  $default,) {final _that = this;
switch (_that) {
case _HadithModel() when $default != null:
return $default(_that.id,_that.hadithNumber,_that.hadithArabic,_that.hadithEnglish,_that.headingArabic,_that.headingEnglish,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _HadithModel extends HadithModel {
  const _HadithModel({required this.id, required this.hadithNumber, required this.hadithArabic, required this.hadithEnglish, required this.headingArabic, required this.headingEnglish, required this.status}): super._();
  

@override final  String id;
@override final  String hadithNumber;
@override final  String hadithArabic;
@override final  String hadithEnglish;
@override final  String headingArabic;
@override final  String headingEnglish;
@override final  String status;

/// Create a copy of HadithModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HadithModelCopyWith<_HadithModel> get copyWith => __$HadithModelCopyWithImpl<_HadithModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HadithModel&&(identical(other.id, id) || other.id == id)&&(identical(other.hadithNumber, hadithNumber) || other.hadithNumber == hadithNumber)&&(identical(other.hadithArabic, hadithArabic) || other.hadithArabic == hadithArabic)&&(identical(other.hadithEnglish, hadithEnglish) || other.hadithEnglish == hadithEnglish)&&(identical(other.headingArabic, headingArabic) || other.headingArabic == headingArabic)&&(identical(other.headingEnglish, headingEnglish) || other.headingEnglish == headingEnglish)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,hadithNumber,hadithArabic,hadithEnglish,headingArabic,headingEnglish,status);
}

@override
String toString() {
    return 'HadithModel(id: $id, hadithNumber: $hadithNumber, hadithArabic: $hadithArabic, hadithEnglish: $hadithEnglish, headingArabic: $headingArabic, headingEnglish: $headingEnglish, status: $status)';
}


}

/// @nodoc
abstract mixin class _$HadithModelCopyWith<$Res> implements $HadithModelCopyWith<$Res> {
  factory _$HadithModelCopyWith(_HadithModel value, $Res Function(_HadithModel) _then) = __$HadithModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String hadithNumber, String hadithArabic, String hadithEnglish, String headingArabic, String headingEnglish, String status
});




}
/// @nodoc
class __$HadithModelCopyWithImpl<$Res>
    implements _$HadithModelCopyWith<$Res> {
  __$HadithModelCopyWithImpl(this._self, this._then);

  final _HadithModel _self;
  final $Res Function(_HadithModel) _then;

/// Create a copy of HadithModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? hadithNumber = null,Object? hadithArabic = null,Object? hadithEnglish = null,Object? headingArabic = null,Object? headingEnglish = null,Object? status = null,}) {
  return _then(_HadithModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hadithNumber: null == hadithNumber ? _self.hadithNumber : hadithNumber // ignore: cast_nullable_to_non_nullable
as String,hadithArabic: null == hadithArabic ? _self.hadithArabic : hadithArabic // ignore: cast_nullable_to_non_nullable
as String,hadithEnglish: null == hadithEnglish ? _self.hadithEnglish : hadithEnglish // ignore: cast_nullable_to_non_nullable
as String,headingArabic: null == headingArabic ? _self.headingArabic : headingArabic // ignore: cast_nullable_to_non_nullable
as String,headingEnglish: null == headingEnglish ? _self.headingEnglish : headingEnglish // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
