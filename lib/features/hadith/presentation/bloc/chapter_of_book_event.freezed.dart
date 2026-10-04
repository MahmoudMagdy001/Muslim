// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_of_book_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChapterOfBookEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterOfBookEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ChapterOfBookEvent()';
}


}

/// @nodoc
class $ChapterOfBookEventCopyWith<$Res>  {
$ChapterOfBookEventCopyWith(ChapterOfBookEvent _, $Res Function(ChapterOfBookEvent) __);
}


/// Adds pattern-matching-related methods to [ChapterOfBookEvent].
extension ChapterOfBookEventPatterns on ChapterOfBookEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChapterOfBookLoadChapters value)?  loadChapters,TResult Function( ChapterOfBookUpdateSearchText value)?  updateSearchText,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChapterOfBookLoadChapters() when loadChapters != null:
return loadChapters(_that);case ChapterOfBookUpdateSearchText() when updateSearchText != null:
return updateSearchText(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChapterOfBookLoadChapters value)  loadChapters,required TResult Function( ChapterOfBookUpdateSearchText value)  updateSearchText,}){
final _that = this;
switch (_that) {
case ChapterOfBookLoadChapters():
return loadChapters(_that);case ChapterOfBookUpdateSearchText():
return updateSearchText(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChapterOfBookLoadChapters value)?  loadChapters,TResult? Function( ChapterOfBookUpdateSearchText value)?  updateSearchText,}){
final _that = this;
switch (_that) {
case ChapterOfBookLoadChapters() when loadChapters != null:
return loadChapters(_that);case ChapterOfBookUpdateSearchText() when updateSearchText != null:
return updateSearchText(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String bookSlug)?  loadChapters,TResult Function( String text)?  updateSearchText,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChapterOfBookLoadChapters() when loadChapters != null:
return loadChapters(_that.bookSlug);case ChapterOfBookUpdateSearchText() when updateSearchText != null:
return updateSearchText(_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String bookSlug)  loadChapters,required TResult Function( String text)  updateSearchText,}) {final _that = this;
switch (_that) {
case ChapterOfBookLoadChapters():
return loadChapters(_that.bookSlug);case ChapterOfBookUpdateSearchText():
return updateSearchText(_that.text);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String bookSlug)?  loadChapters,TResult? Function( String text)?  updateSearchText,}) {final _that = this;
switch (_that) {
case ChapterOfBookLoadChapters() when loadChapters != null:
return loadChapters(_that.bookSlug);case ChapterOfBookUpdateSearchText() when updateSearchText != null:
return updateSearchText(_that.text);case _:
  return null;

}
}

}

/// @nodoc


class ChapterOfBookLoadChapters implements ChapterOfBookEvent {
  const ChapterOfBookLoadChapters(this.bookSlug);
  

 final  String bookSlug;

/// Create a copy of ChapterOfBookEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterOfBookLoadChaptersCopyWith<ChapterOfBookLoadChapters> get copyWith => _$ChapterOfBookLoadChaptersCopyWithImpl<ChapterOfBookLoadChapters>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterOfBookLoadChapters&&(identical(other.bookSlug, bookSlug) || other.bookSlug == bookSlug));
}


@override
int get hashCode {
    return Object.hash(runtimeType,bookSlug);
}

@override
String toString() {
    return 'ChapterOfBookEvent.loadChapters(bookSlug: $bookSlug)';
}


}

/// @nodoc
abstract mixin class $ChapterOfBookLoadChaptersCopyWith<$Res> implements $ChapterOfBookEventCopyWith<$Res> {
  factory $ChapterOfBookLoadChaptersCopyWith(ChapterOfBookLoadChapters value, $Res Function(ChapterOfBookLoadChapters) _then) = _$ChapterOfBookLoadChaptersCopyWithImpl;
@useResult
$Res call({
 String bookSlug
});




}
/// @nodoc
class _$ChapterOfBookLoadChaptersCopyWithImpl<$Res>
    implements $ChapterOfBookLoadChaptersCopyWith<$Res> {
  _$ChapterOfBookLoadChaptersCopyWithImpl(this._self, this._then);

  final ChapterOfBookLoadChapters _self;
  final $Res Function(ChapterOfBookLoadChapters) _then;

/// Create a copy of ChapterOfBookEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bookSlug = null,}) {
  return _then(ChapterOfBookLoadChapters(
null == bookSlug ? _self.bookSlug : bookSlug // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChapterOfBookUpdateSearchText implements ChapterOfBookEvent {
  const ChapterOfBookUpdateSearchText(this.text);
  

 final  String text;

/// Create a copy of ChapterOfBookEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterOfBookUpdateSearchTextCopyWith<ChapterOfBookUpdateSearchText> get copyWith => _$ChapterOfBookUpdateSearchTextCopyWithImpl<ChapterOfBookUpdateSearchText>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterOfBookUpdateSearchText&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode {
    return Object.hash(runtimeType,text);
}

@override
String toString() {
    return 'ChapterOfBookEvent.updateSearchText(text: $text)';
}


}

/// @nodoc
abstract mixin class $ChapterOfBookUpdateSearchTextCopyWith<$Res> implements $ChapterOfBookEventCopyWith<$Res> {
  factory $ChapterOfBookUpdateSearchTextCopyWith(ChapterOfBookUpdateSearchText value, $Res Function(ChapterOfBookUpdateSearchText) _then) = _$ChapterOfBookUpdateSearchTextCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$ChapterOfBookUpdateSearchTextCopyWithImpl<$Res>
    implements $ChapterOfBookUpdateSearchTextCopyWith<$Res> {
  _$ChapterOfBookUpdateSearchTextCopyWithImpl(this._self, this._then);

  final ChapterOfBookUpdateSearchText _self;
  final $Res Function(ChapterOfBookUpdateSearchText) _then;

/// Create a copy of ChapterOfBookEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(ChapterOfBookUpdateSearchText(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
