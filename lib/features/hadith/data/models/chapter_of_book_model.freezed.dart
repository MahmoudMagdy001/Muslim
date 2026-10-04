// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_of_book_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChapterOfBookModel {

 String get id; String get chapterNameAr; String get chapterNumber; String get chapterNameEn;
/// Create a copy of ChapterOfBookModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterOfBookModelCopyWith<ChapterOfBookModel> get copyWith => _$ChapterOfBookModelCopyWithImpl<ChapterOfBookModel>(this as ChapterOfBookModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChapterOfBookModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterOfBookModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.chapterNameAr, _this.chapterNameAr) || other.chapterNameAr == _this.chapterNameAr)&&(identical(other.chapterNumber, _this.chapterNumber) || other.chapterNumber == _this.chapterNumber)&&(identical(other.chapterNameEn, _this.chapterNameEn) || other.chapterNameEn == _this.chapterNameEn));
}


@override
int get hashCode {
  final _this = this as ChapterOfBookModel;
  return Object.hash(runtimeType,_this.id,_this.chapterNameAr,_this.chapterNumber,_this.chapterNameEn);
}

@override
String toString() {
  final _this = this as ChapterOfBookModel;
  return 'ChapterOfBookModel(id: ${_this.id}, chapterNameAr: ${_this.chapterNameAr}, chapterNumber: ${_this.chapterNumber}, chapterNameEn: ${_this.chapterNameEn})';
}


}

/// @nodoc
abstract mixin class $ChapterOfBookModelCopyWith<$Res>  {
  factory $ChapterOfBookModelCopyWith(ChapterOfBookModel value, $Res Function(ChapterOfBookModel) _then) = _$ChapterOfBookModelCopyWithImpl;
@useResult
$Res call({
 String id, String chapterNameAr, String chapterNumber, String chapterNameEn
});




}
/// @nodoc
class _$ChapterOfBookModelCopyWithImpl<$Res>
    implements $ChapterOfBookModelCopyWith<$Res> {
  _$ChapterOfBookModelCopyWithImpl(this._self, this._then);

  final ChapterOfBookModel _self;
  final $Res Function(ChapterOfBookModel) _then;

/// Create a copy of ChapterOfBookModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? chapterNameAr = null,Object? chapterNumber = null,Object? chapterNameEn = null,}) {
  return _then(ChapterOfBookModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,chapterNameAr: null == chapterNameAr ? _self.chapterNameAr : chapterNameAr // ignore: cast_nullable_to_non_nullable
as String,chapterNumber: null == chapterNumber ? _self.chapterNumber : chapterNumber // ignore: cast_nullable_to_non_nullable
as String,chapterNameEn: null == chapterNameEn ? _self.chapterNameEn : chapterNameEn // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChapterOfBookModel].
extension ChapterOfBookModelPatterns on ChapterOfBookModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChapterOfBookModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChapterOfBookModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChapterOfBookModel value)  $default,){
final _that = this;
switch (_that) {
case _ChapterOfBookModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChapterOfBookModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChapterOfBookModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String chapterNameAr,  String chapterNumber,  String chapterNameEn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChapterOfBookModel() when $default != null:
return $default(_that.id,_that.chapterNameAr,_that.chapterNumber,_that.chapterNameEn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String chapterNameAr,  String chapterNumber,  String chapterNameEn)  $default,) {final _that = this;
switch (_that) {
case _ChapterOfBookModel():
return $default(_that.id,_that.chapterNameAr,_that.chapterNumber,_that.chapterNameEn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String chapterNameAr,  String chapterNumber,  String chapterNameEn)?  $default,) {final _that = this;
switch (_that) {
case _ChapterOfBookModel() when $default != null:
return $default(_that.id,_that.chapterNameAr,_that.chapterNumber,_that.chapterNameEn);case _:
  return null;

}
}

}

/// @nodoc


class _ChapterOfBookModel extends ChapterOfBookModel {
  const _ChapterOfBookModel({required this.id, required this.chapterNameAr, required this.chapterNumber, required this.chapterNameEn}): super._();
  

@override final  String id;
@override final  String chapterNameAr;
@override final  String chapterNumber;
@override final  String chapterNameEn;

/// Create a copy of ChapterOfBookModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterOfBookModelCopyWith<_ChapterOfBookModel> get copyWith => __$ChapterOfBookModelCopyWithImpl<_ChapterOfBookModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterOfBookModel&&(identical(other.id, id) || other.id == id)&&(identical(other.chapterNameAr, chapterNameAr) || other.chapterNameAr == chapterNameAr)&&(identical(other.chapterNumber, chapterNumber) || other.chapterNumber == chapterNumber)&&(identical(other.chapterNameEn, chapterNameEn) || other.chapterNameEn == chapterNameEn));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,chapterNameAr,chapterNumber,chapterNameEn);
}

@override
String toString() {
    return 'ChapterOfBookModel(id: $id, chapterNameAr: $chapterNameAr, chapterNumber: $chapterNumber, chapterNameEn: $chapterNameEn)';
}


}

/// @nodoc
abstract mixin class _$ChapterOfBookModelCopyWith<$Res> implements $ChapterOfBookModelCopyWith<$Res> {
  factory _$ChapterOfBookModelCopyWith(_ChapterOfBookModel value, $Res Function(_ChapterOfBookModel) _then) = __$ChapterOfBookModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String chapterNameAr, String chapterNumber, String chapterNameEn
});




}
/// @nodoc
class __$ChapterOfBookModelCopyWithImpl<$Res>
    implements _$ChapterOfBookModelCopyWith<$Res> {
  __$ChapterOfBookModelCopyWithImpl(this._self, this._then);

  final _ChapterOfBookModel _self;
  final $Res Function(_ChapterOfBookModel) _then;

/// Create a copy of ChapterOfBookModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? chapterNameAr = null,Object? chapterNumber = null,Object? chapterNameEn = null,}) {
  return _then(_ChapterOfBookModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,chapterNameAr: null == chapterNameAr ? _self.chapterNameAr : chapterNameAr // ignore: cast_nullable_to_non_nullable
as String,chapterNumber: null == chapterNumber ? _self.chapterNumber : chapterNumber // ignore: cast_nullable_to_non_nullable
as String,chapterNameEn: null == chapterNameEn ? _self.chapterNameEn : chapterNameEn // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
