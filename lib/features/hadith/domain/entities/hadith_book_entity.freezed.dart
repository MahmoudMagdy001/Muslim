// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hadith_book_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HadithBookEntity {

 String get id; String get bookName; String get writerName; String get hadithCount; String get chapterCount; String get writerDeath; String get bookSlug;
/// Create a copy of HadithBookEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HadithBookEntityCopyWith<HadithBookEntity> get copyWith => _$HadithBookEntityCopyWithImpl<HadithBookEntity>(this as HadithBookEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HadithBookEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HadithBookEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.bookName, _this.bookName) || other.bookName == _this.bookName)&&(identical(other.writerName, _this.writerName) || other.writerName == _this.writerName)&&(identical(other.hadithCount, _this.hadithCount) || other.hadithCount == _this.hadithCount)&&(identical(other.chapterCount, _this.chapterCount) || other.chapterCount == _this.chapterCount)&&(identical(other.writerDeath, _this.writerDeath) || other.writerDeath == _this.writerDeath)&&(identical(other.bookSlug, _this.bookSlug) || other.bookSlug == _this.bookSlug));
}


@override
int get hashCode {
  final _this = this as HadithBookEntity;
  return Object.hash(runtimeType,_this.id,_this.bookName,_this.writerName,_this.hadithCount,_this.chapterCount,_this.writerDeath,_this.bookSlug);
}

@override
String toString() {
  final _this = this as HadithBookEntity;
  return 'HadithBookEntity(id: ${_this.id}, bookName: ${_this.bookName}, writerName: ${_this.writerName}, hadithCount: ${_this.hadithCount}, chapterCount: ${_this.chapterCount}, writerDeath: ${_this.writerDeath}, bookSlug: ${_this.bookSlug})';
}


}

/// @nodoc
abstract mixin class $HadithBookEntityCopyWith<$Res>  {
  factory $HadithBookEntityCopyWith(HadithBookEntity value, $Res Function(HadithBookEntity) _then) = _$HadithBookEntityCopyWithImpl;
@useResult
$Res call({
 String id, String bookName, String writerName, String hadithCount, String chapterCount, String writerDeath, String bookSlug
});




}
/// @nodoc
class _$HadithBookEntityCopyWithImpl<$Res>
    implements $HadithBookEntityCopyWith<$Res> {
  _$HadithBookEntityCopyWithImpl(this._self, this._then);

  final HadithBookEntity _self;
  final $Res Function(HadithBookEntity) _then;

/// Create a copy of HadithBookEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookName = null,Object? writerName = null,Object? hadithCount = null,Object? chapterCount = null,Object? writerDeath = null,Object? bookSlug = null,}) {
  return _then(HadithBookEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookName: null == bookName ? _self.bookName : bookName // ignore: cast_nullable_to_non_nullable
as String,writerName: null == writerName ? _self.writerName : writerName // ignore: cast_nullable_to_non_nullable
as String,hadithCount: null == hadithCount ? _self.hadithCount : hadithCount // ignore: cast_nullable_to_non_nullable
as String,chapterCount: null == chapterCount ? _self.chapterCount : chapterCount // ignore: cast_nullable_to_non_nullable
as String,writerDeath: null == writerDeath ? _self.writerDeath : writerDeath // ignore: cast_nullable_to_non_nullable
as String,bookSlug: null == bookSlug ? _self.bookSlug : bookSlug // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HadithBookEntity].
extension HadithBookEntityPatterns on HadithBookEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HadithBookEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HadithBookEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HadithBookEntity value)  $default,){
final _that = this;
switch (_that) {
case _HadithBookEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HadithBookEntity value)?  $default,){
final _that = this;
switch (_that) {
case _HadithBookEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String bookName,  String writerName,  String hadithCount,  String chapterCount,  String writerDeath,  String bookSlug)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HadithBookEntity() when $default != null:
return $default(_that.id,_that.bookName,_that.writerName,_that.hadithCount,_that.chapterCount,_that.writerDeath,_that.bookSlug);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String bookName,  String writerName,  String hadithCount,  String chapterCount,  String writerDeath,  String bookSlug)  $default,) {final _that = this;
switch (_that) {
case _HadithBookEntity():
return $default(_that.id,_that.bookName,_that.writerName,_that.hadithCount,_that.chapterCount,_that.writerDeath,_that.bookSlug);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String bookName,  String writerName,  String hadithCount,  String chapterCount,  String writerDeath,  String bookSlug)?  $default,) {final _that = this;
switch (_that) {
case _HadithBookEntity() when $default != null:
return $default(_that.id,_that.bookName,_that.writerName,_that.hadithCount,_that.chapterCount,_that.writerDeath,_that.bookSlug);case _:
  return null;

}
}

}

/// @nodoc


class _HadithBookEntity implements HadithBookEntity {
  const _HadithBookEntity({required this.id, required this.bookName, required this.writerName, required this.hadithCount, required this.chapterCount, required this.writerDeath, required this.bookSlug});
  

@override final  String id;
@override final  String bookName;
@override final  String writerName;
@override final  String hadithCount;
@override final  String chapterCount;
@override final  String writerDeath;
@override final  String bookSlug;

/// Create a copy of HadithBookEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HadithBookEntityCopyWith<_HadithBookEntity> get copyWith => __$HadithBookEntityCopyWithImpl<_HadithBookEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HadithBookEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.bookName, bookName) || other.bookName == bookName)&&(identical(other.writerName, writerName) || other.writerName == writerName)&&(identical(other.hadithCount, hadithCount) || other.hadithCount == hadithCount)&&(identical(other.chapterCount, chapterCount) || other.chapterCount == chapterCount)&&(identical(other.writerDeath, writerDeath) || other.writerDeath == writerDeath)&&(identical(other.bookSlug, bookSlug) || other.bookSlug == bookSlug));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,bookName,writerName,hadithCount,chapterCount,writerDeath,bookSlug);
}

@override
String toString() {
    return 'HadithBookEntity(id: $id, bookName: $bookName, writerName: $writerName, hadithCount: $hadithCount, chapterCount: $chapterCount, writerDeath: $writerDeath, bookSlug: $bookSlug)';
}


}

/// @nodoc
abstract mixin class _$HadithBookEntityCopyWith<$Res> implements $HadithBookEntityCopyWith<$Res> {
  factory _$HadithBookEntityCopyWith(_HadithBookEntity value, $Res Function(_HadithBookEntity) _then) = __$HadithBookEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String bookName, String writerName, String hadithCount, String chapterCount, String writerDeath, String bookSlug
});




}
/// @nodoc
class __$HadithBookEntityCopyWithImpl<$Res>
    implements _$HadithBookEntityCopyWith<$Res> {
  __$HadithBookEntityCopyWithImpl(this._self, this._then);

  final _HadithBookEntity _self;
  final $Res Function(_HadithBookEntity) _then;

/// Create a copy of HadithBookEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookName = null,Object? writerName = null,Object? hadithCount = null,Object? chapterCount = null,Object? writerDeath = null,Object? bookSlug = null,}) {
  return _then(_HadithBookEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookName: null == bookName ? _self.bookName : bookName // ignore: cast_nullable_to_non_nullable
as String,writerName: null == writerName ? _self.writerName : writerName // ignore: cast_nullable_to_non_nullable
as String,hadithCount: null == hadithCount ? _self.hadithCount : hadithCount // ignore: cast_nullable_to_non_nullable
as String,chapterCount: null == chapterCount ? _self.chapterCount : chapterCount // ignore: cast_nullable_to_non_nullable
as String,writerDeath: null == writerDeath ? _self.writerDeath : writerDeath // ignore: cast_nullable_to_non_nullable
as String,bookSlug: null == bookSlug ? _self.bookSlug : bookSlug // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
