// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchResult {

 int get surahNumber; int get verseNumber; String get surahName; String get ayahText; bool get isSurah;
/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultCopyWith<SearchResult> get copyWith => _$SearchResultCopyWithImpl<SearchResult>(this as SearchResult, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SearchResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResult&&(identical(other.surahNumber, _this.surahNumber) || other.surahNumber == _this.surahNumber)&&(identical(other.verseNumber, _this.verseNumber) || other.verseNumber == _this.verseNumber)&&(identical(other.surahName, _this.surahName) || other.surahName == _this.surahName)&&(identical(other.ayahText, _this.ayahText) || other.ayahText == _this.ayahText)&&(identical(other.isSurah, _this.isSurah) || other.isSurah == _this.isSurah));
}


@override
int get hashCode {
  final _this = this as SearchResult;
  return Object.hash(runtimeType,_this.surahNumber,_this.verseNumber,_this.surahName,_this.ayahText,_this.isSurah);
}

@override
String toString() {
  final _this = this as SearchResult;
  return 'SearchResult(surahNumber: ${_this.surahNumber}, verseNumber: ${_this.verseNumber}, surahName: ${_this.surahName}, ayahText: ${_this.ayahText}, isSurah: ${_this.isSurah})';
}


}

/// @nodoc
abstract mixin class $SearchResultCopyWith<$Res>  {
  factory $SearchResultCopyWith(SearchResult value, $Res Function(SearchResult) _then) = _$SearchResultCopyWithImpl;
@useResult
$Res call({
 int surahNumber, int verseNumber, String surahName, String ayahText, bool isSurah
});




}
/// @nodoc
class _$SearchResultCopyWithImpl<$Res>
    implements $SearchResultCopyWith<$Res> {
  _$SearchResultCopyWithImpl(this._self, this._then);

  final SearchResult _self;
  final $Res Function(SearchResult) _then;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surahNumber = null,Object? verseNumber = null,Object? surahName = null,Object? ayahText = null,Object? isSurah = null,}) {
  return _then(SearchResult(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,verseNumber: null == verseNumber ? _self.verseNumber : verseNumber // ignore: cast_nullable_to_non_nullable
as int,surahName: null == surahName ? _self.surahName : surahName // ignore: cast_nullable_to_non_nullable
as String,ayahText: null == ayahText ? _self.ayahText : ayahText // ignore: cast_nullable_to_non_nullable
as String,isSurah: null == isSurah ? _self.isSurah : isSurah // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchResult].
extension SearchResultPatterns on SearchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchResult value)  $default,){
final _that = this;
switch (_that) {
case _SearchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchResult value)?  $default,){
final _that = this;
switch (_that) {
case _SearchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int surahNumber,  int verseNumber,  String surahName,  String ayahText,  bool isSurah)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchResult() when $default != null:
return $default(_that.surahNumber,_that.verseNumber,_that.surahName,_that.ayahText,_that.isSurah);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int surahNumber,  int verseNumber,  String surahName,  String ayahText,  bool isSurah)  $default,) {final _that = this;
switch (_that) {
case _SearchResult():
return $default(_that.surahNumber,_that.verseNumber,_that.surahName,_that.ayahText,_that.isSurah);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int surahNumber,  int verseNumber,  String surahName,  String ayahText,  bool isSurah)?  $default,) {final _that = this;
switch (_that) {
case _SearchResult() when $default != null:
return $default(_that.surahNumber,_that.verseNumber,_that.surahName,_that.ayahText,_that.isSurah);case _:
  return null;

}
}

}

/// @nodoc


class _SearchResult implements SearchResult {
  const _SearchResult({required this.surahNumber, required this.verseNumber, required this.surahName, required this.ayahText, this.isSurah = false});
  

@override final  int surahNumber;
@override final  int verseNumber;
@override final  String surahName;
@override final  String ayahText;
@override@JsonKey() final  bool isSurah;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResultCopyWith<_SearchResult> get copyWith => __$SearchResultCopyWithImpl<_SearchResult>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResult&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.verseNumber, verseNumber) || other.verseNumber == verseNumber)&&(identical(other.surahName, surahName) || other.surahName == surahName)&&(identical(other.ayahText, ayahText) || other.ayahText == ayahText)&&(identical(other.isSurah, isSurah) || other.isSurah == isSurah));
}


@override
int get hashCode {
    return Object.hash(runtimeType,surahNumber,verseNumber,surahName,ayahText,isSurah);
}

@override
String toString() {
    return 'SearchResult(surahNumber: $surahNumber, verseNumber: $verseNumber, surahName: $surahName, ayahText: $ayahText, isSurah: $isSurah)';
}


}

/// @nodoc
abstract mixin class _$SearchResultCopyWith<$Res> implements $SearchResultCopyWith<$Res> {
  factory _$SearchResultCopyWith(_SearchResult value, $Res Function(_SearchResult) _then) = __$SearchResultCopyWithImpl;
@override @useResult
$Res call({
 int surahNumber, int verseNumber, String surahName, String ayahText, bool isSurah
});




}
/// @nodoc
class __$SearchResultCopyWithImpl<$Res>
    implements _$SearchResultCopyWith<$Res> {
  __$SearchResultCopyWithImpl(this._self, this._then);

  final _SearchResult _self;
  final $Res Function(_SearchResult) _then;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surahNumber = null,Object? verseNumber = null,Object? surahName = null,Object? ayahText = null,Object? isSurah = null,}) {
  return _then(_SearchResult(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,verseNumber: null == verseNumber ? _self.verseNumber : verseNumber // ignore: cast_nullable_to_non_nullable
as int,surahName: null == surahName ? _self.surahName : surahName // ignore: cast_nullable_to_non_nullable
as String,ayahText: null == ayahText ? _self.ayahText : ayahText // ignore: cast_nullable_to_non_nullable
as String,isSurah: null == isSurah ? _self.isSurah : isSurah // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
