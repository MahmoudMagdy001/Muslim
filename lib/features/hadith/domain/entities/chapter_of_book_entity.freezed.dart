// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_of_book_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChapterOfBookEntity {

 String get id; String get chapterNameAr; String get chapterNameEn; String get chapterNumber;
/// Create a copy of ChapterOfBookEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterOfBookEntityCopyWith<ChapterOfBookEntity> get copyWith => _$ChapterOfBookEntityCopyWithImpl<ChapterOfBookEntity>(this as ChapterOfBookEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChapterOfBookEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterOfBookEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.chapterNameAr, _this.chapterNameAr) || other.chapterNameAr == _this.chapterNameAr)&&(identical(other.chapterNameEn, _this.chapterNameEn) || other.chapterNameEn == _this.chapterNameEn)&&(identical(other.chapterNumber, _this.chapterNumber) || other.chapterNumber == _this.chapterNumber));
}


@override
int get hashCode {
  final _this = this as ChapterOfBookEntity;
  return Object.hash(runtimeType,_this.id,_this.chapterNameAr,_this.chapterNameEn,_this.chapterNumber);
}

@override
String toString() {
  final _this = this as ChapterOfBookEntity;
  return 'ChapterOfBookEntity(id: ${_this.id}, chapterNameAr: ${_this.chapterNameAr}, chapterNameEn: ${_this.chapterNameEn}, chapterNumber: ${_this.chapterNumber})';
}


}

/// @nodoc
abstract mixin class $ChapterOfBookEntityCopyWith<$Res>  {
  factory $ChapterOfBookEntityCopyWith(ChapterOfBookEntity value, $Res Function(ChapterOfBookEntity) _then) = _$ChapterOfBookEntityCopyWithImpl;
@useResult
$Res call({
 String id, String chapterNameAr, String chapterNameEn, String chapterNumber
});




}
/// @nodoc
class _$ChapterOfBookEntityCopyWithImpl<$Res>
    implements $ChapterOfBookEntityCopyWith<$Res> {
  _$ChapterOfBookEntityCopyWithImpl(this._self, this._then);

  final ChapterOfBookEntity _self;
  final $Res Function(ChapterOfBookEntity) _then;

/// Create a copy of ChapterOfBookEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? chapterNameAr = null,Object? chapterNameEn = null,Object? chapterNumber = null,}) {
  return _then(ChapterOfBookEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,chapterNameAr: null == chapterNameAr ? _self.chapterNameAr : chapterNameAr // ignore: cast_nullable_to_non_nullable
as String,chapterNameEn: null == chapterNameEn ? _self.chapterNameEn : chapterNameEn // ignore: cast_nullable_to_non_nullable
as String,chapterNumber: null == chapterNumber ? _self.chapterNumber : chapterNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChapterOfBookEntity].
extension ChapterOfBookEntityPatterns on ChapterOfBookEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChapterOfBookEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChapterOfBookEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChapterOfBookEntity value)  $default,){
final _that = this;
switch (_that) {
case _ChapterOfBookEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChapterOfBookEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ChapterOfBookEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String chapterNameAr,  String chapterNameEn,  String chapterNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChapterOfBookEntity() when $default != null:
return $default(_that.id,_that.chapterNameAr,_that.chapterNameEn,_that.chapterNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String chapterNameAr,  String chapterNameEn,  String chapterNumber)  $default,) {final _that = this;
switch (_that) {
case _ChapterOfBookEntity():
return $default(_that.id,_that.chapterNameAr,_that.chapterNameEn,_that.chapterNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String chapterNameAr,  String chapterNameEn,  String chapterNumber)?  $default,) {final _that = this;
switch (_that) {
case _ChapterOfBookEntity() when $default != null:
return $default(_that.id,_that.chapterNameAr,_that.chapterNameEn,_that.chapterNumber);case _:
  return null;

}
}

}

/// @nodoc


class _ChapterOfBookEntity implements ChapterOfBookEntity {
  const _ChapterOfBookEntity({required this.id, required this.chapterNameAr, required this.chapterNameEn, required this.chapterNumber});
  

@override final  String id;
@override final  String chapterNameAr;
@override final  String chapterNameEn;
@override final  String chapterNumber;

/// Create a copy of ChapterOfBookEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterOfBookEntityCopyWith<_ChapterOfBookEntity> get copyWith => __$ChapterOfBookEntityCopyWithImpl<_ChapterOfBookEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterOfBookEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.chapterNameAr, chapterNameAr) || other.chapterNameAr == chapterNameAr)&&(identical(other.chapterNameEn, chapterNameEn) || other.chapterNameEn == chapterNameEn)&&(identical(other.chapterNumber, chapterNumber) || other.chapterNumber == chapterNumber));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,chapterNameAr,chapterNameEn,chapterNumber);
}

@override
String toString() {
    return 'ChapterOfBookEntity(id: $id, chapterNameAr: $chapterNameAr, chapterNameEn: $chapterNameEn, chapterNumber: $chapterNumber)';
}


}

/// @nodoc
abstract mixin class _$ChapterOfBookEntityCopyWith<$Res> implements $ChapterOfBookEntityCopyWith<$Res> {
  factory _$ChapterOfBookEntityCopyWith(_ChapterOfBookEntity value, $Res Function(_ChapterOfBookEntity) _then) = __$ChapterOfBookEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String chapterNameAr, String chapterNameEn, String chapterNumber
});




}
/// @nodoc
class __$ChapterOfBookEntityCopyWithImpl<$Res>
    implements _$ChapterOfBookEntityCopyWith<$Res> {
  __$ChapterOfBookEntityCopyWithImpl(this._self, this._then);

  final _ChapterOfBookEntity _self;
  final $Res Function(_ChapterOfBookEntity) _then;

/// Create a copy of ChapterOfBookEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? chapterNameAr = null,Object? chapterNameEn = null,Object? chapterNumber = null,}) {
  return _then(_ChapterOfBookEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,chapterNameAr: null == chapterNameAr ? _self.chapterNameAr : chapterNameAr // ignore: cast_nullable_to_non_nullable
as String,chapterNameEn: null == chapterNameEn ? _self.chapterNameEn : chapterNameEn // ignore: cast_nullable_to_non_nullable
as String,chapterNumber: null == chapterNumber ? _self.chapterNumber : chapterNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
