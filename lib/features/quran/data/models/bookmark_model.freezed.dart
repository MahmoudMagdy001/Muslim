// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmark_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AyahBookmark {

 int get surahNumber; int get ayahNumber; int get timestampMs; String get ayahText;
/// Create a copy of AyahBookmark
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AyahBookmarkCopyWith<AyahBookmark> get copyWith => _$AyahBookmarkCopyWithImpl<AyahBookmark>(this as AyahBookmark, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AyahBookmark;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AyahBookmark&&(identical(other.surahNumber, _this.surahNumber) || other.surahNumber == _this.surahNumber)&&(identical(other.ayahNumber, _this.ayahNumber) || other.ayahNumber == _this.ayahNumber)&&(identical(other.timestampMs, _this.timestampMs) || other.timestampMs == _this.timestampMs)&&(identical(other.ayahText, _this.ayahText) || other.ayahText == _this.ayahText));
}


@override
int get hashCode {
  final _this = this as AyahBookmark;
  return Object.hash(runtimeType,_this.surahNumber,_this.ayahNumber,_this.timestampMs,_this.ayahText);
}

@override
String toString() {
  final _this = this as AyahBookmark;
  return 'AyahBookmark(surahNumber: ${_this.surahNumber}, ayahNumber: ${_this.ayahNumber}, timestampMs: ${_this.timestampMs}, ayahText: ${_this.ayahText})';
}


}

/// @nodoc
abstract mixin class $AyahBookmarkCopyWith<$Res>  {
  factory $AyahBookmarkCopyWith(AyahBookmark value, $Res Function(AyahBookmark) _then) = _$AyahBookmarkCopyWithImpl;
@useResult
$Res call({
 int surahNumber, int ayahNumber, int timestampMs, String ayahText
});




}
/// @nodoc
class _$AyahBookmarkCopyWithImpl<$Res>
    implements $AyahBookmarkCopyWith<$Res> {
  _$AyahBookmarkCopyWithImpl(this._self, this._then);

  final AyahBookmark _self;
  final $Res Function(AyahBookmark) _then;

/// Create a copy of AyahBookmark
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surahNumber = null,Object? ayahNumber = null,Object? timestampMs = null,Object? ayahText = null,}) {
  return _then(AyahBookmark(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,ayahNumber: null == ayahNumber ? _self.ayahNumber : ayahNumber // ignore: cast_nullable_to_non_nullable
as int,timestampMs: null == timestampMs ? _self.timestampMs : timestampMs // ignore: cast_nullable_to_non_nullable
as int,ayahText: null == ayahText ? _self.ayahText : ayahText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AyahBookmark].
extension AyahBookmarkPatterns on AyahBookmark {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AyahBookmark value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AyahBookmark() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AyahBookmark value)  $default,){
final _that = this;
switch (_that) {
case _AyahBookmark():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AyahBookmark value)?  $default,){
final _that = this;
switch (_that) {
case _AyahBookmark() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int surahNumber,  int ayahNumber,  int timestampMs,  String ayahText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AyahBookmark() when $default != null:
return $default(_that.surahNumber,_that.ayahNumber,_that.timestampMs,_that.ayahText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int surahNumber,  int ayahNumber,  int timestampMs,  String ayahText)  $default,) {final _that = this;
switch (_that) {
case _AyahBookmark():
return $default(_that.surahNumber,_that.ayahNumber,_that.timestampMs,_that.ayahText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int surahNumber,  int ayahNumber,  int timestampMs,  String ayahText)?  $default,) {final _that = this;
switch (_that) {
case _AyahBookmark() when $default != null:
return $default(_that.surahNumber,_that.ayahNumber,_that.timestampMs,_that.ayahText);case _:
  return null;

}
}

}

/// @nodoc


class _AyahBookmark extends AyahBookmark {
  const _AyahBookmark({required this.surahNumber, required this.ayahNumber, required this.timestampMs, required this.ayahText}): super._();
  

@override final  int surahNumber;
@override final  int ayahNumber;
@override final  int timestampMs;
@override final  String ayahText;

/// Create a copy of AyahBookmark
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AyahBookmarkCopyWith<_AyahBookmark> get copyWith => __$AyahBookmarkCopyWithImpl<_AyahBookmark>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AyahBookmark&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.ayahNumber, ayahNumber) || other.ayahNumber == ayahNumber)&&(identical(other.timestampMs, timestampMs) || other.timestampMs == timestampMs)&&(identical(other.ayahText, ayahText) || other.ayahText == ayahText));
}


@override
int get hashCode {
    return Object.hash(runtimeType,surahNumber,ayahNumber,timestampMs,ayahText);
}

@override
String toString() {
    return 'AyahBookmark(surahNumber: $surahNumber, ayahNumber: $ayahNumber, timestampMs: $timestampMs, ayahText: $ayahText)';
}


}

/// @nodoc
abstract mixin class _$AyahBookmarkCopyWith<$Res> implements $AyahBookmarkCopyWith<$Res> {
  factory _$AyahBookmarkCopyWith(_AyahBookmark value, $Res Function(_AyahBookmark) _then) = __$AyahBookmarkCopyWithImpl;
@override @useResult
$Res call({
 int surahNumber, int ayahNumber, int timestampMs, String ayahText
});




}
/// @nodoc
class __$AyahBookmarkCopyWithImpl<$Res>
    implements _$AyahBookmarkCopyWith<$Res> {
  __$AyahBookmarkCopyWithImpl(this._self, this._then);

  final _AyahBookmark _self;
  final $Res Function(_AyahBookmark) _then;

/// Create a copy of AyahBookmark
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surahNumber = null,Object? ayahNumber = null,Object? timestampMs = null,Object? ayahText = null,}) {
  return _then(_AyahBookmark(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,ayahNumber: null == ayahNumber ? _self.ayahNumber : ayahNumber // ignore: cast_nullable_to_non_nullable
as int,timestampMs: null == timestampMs ? _self.timestampMs : timestampMs // ignore: cast_nullable_to_non_nullable
as int,ayahText: null == ayahText ? _self.ayahText : ayahText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
