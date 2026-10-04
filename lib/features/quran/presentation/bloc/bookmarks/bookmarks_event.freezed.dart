// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmarks_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookmarksEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is BookmarksEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'BookmarksEvent()';
}


}

/// @nodoc
class $BookmarksEventCopyWith<$Res>  {
$BookmarksEventCopyWith(BookmarksEvent _, $Res Function(BookmarksEvent) __);
}


/// Adds pattern-matching-related methods to [BookmarksEvent].
extension BookmarksEventPatterns on BookmarksEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BookmarksLoad value)?  load,TResult Function( BookmarksAddBookmark value)?  addBookmark,TResult Function( BookmarksRemoveBookmark value)?  removeBookmark,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BookmarksLoad() when load != null:
return load(_that);case BookmarksAddBookmark() when addBookmark != null:
return addBookmark(_that);case BookmarksRemoveBookmark() when removeBookmark != null:
return removeBookmark(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BookmarksLoad value)  load,required TResult Function( BookmarksAddBookmark value)  addBookmark,required TResult Function( BookmarksRemoveBookmark value)  removeBookmark,}){
final _that = this;
switch (_that) {
case BookmarksLoad():
return load(_that);case BookmarksAddBookmark():
return addBookmark(_that);case BookmarksRemoveBookmark():
return removeBookmark(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BookmarksLoad value)?  load,TResult? Function( BookmarksAddBookmark value)?  addBookmark,TResult? Function( BookmarksRemoveBookmark value)?  removeBookmark,}){
final _that = this;
switch (_that) {
case BookmarksLoad() when load != null:
return load(_that);case BookmarksAddBookmark() when addBookmark != null:
return addBookmark(_that);case BookmarksRemoveBookmark() when removeBookmark != null:
return removeBookmark(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function( int surah,  int ayah,  String ayahText)?  addBookmark,TResult Function( int surah,  int ayah)?  removeBookmark,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BookmarksLoad() when load != null:
return load();case BookmarksAddBookmark() when addBookmark != null:
return addBookmark(_that.surah,_that.ayah,_that.ayahText);case BookmarksRemoveBookmark() when removeBookmark != null:
return removeBookmark(_that.surah,_that.ayah);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function( int surah,  int ayah,  String ayahText)  addBookmark,required TResult Function( int surah,  int ayah)  removeBookmark,}) {final _that = this;
switch (_that) {
case BookmarksLoad():
return load();case BookmarksAddBookmark():
return addBookmark(_that.surah,_that.ayah,_that.ayahText);case BookmarksRemoveBookmark():
return removeBookmark(_that.surah,_that.ayah);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function( int surah,  int ayah,  String ayahText)?  addBookmark,TResult? Function( int surah,  int ayah)?  removeBookmark,}) {final _that = this;
switch (_that) {
case BookmarksLoad() when load != null:
return load();case BookmarksAddBookmark() when addBookmark != null:
return addBookmark(_that.surah,_that.ayah,_that.ayahText);case BookmarksRemoveBookmark() when removeBookmark != null:
return removeBookmark(_that.surah,_that.ayah);case _:
  return null;

}
}

}

/// @nodoc


class BookmarksLoad implements BookmarksEvent {
  const BookmarksLoad();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is BookmarksLoad);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'BookmarksEvent.load()';
}


}




/// @nodoc


class BookmarksAddBookmark implements BookmarksEvent {
  const BookmarksAddBookmark({required this.surah, required this.ayah, required this.ayahText});
  

 final  int surah;
 final  int ayah;
 final  String ayahText;

/// Create a copy of BookmarksEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookmarksAddBookmarkCopyWith<BookmarksAddBookmark> get copyWith => _$BookmarksAddBookmarkCopyWithImpl<BookmarksAddBookmark>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is BookmarksAddBookmark&&(identical(other.surah, surah) || other.surah == surah)&&(identical(other.ayah, ayah) || other.ayah == ayah)&&(identical(other.ayahText, ayahText) || other.ayahText == ayahText));
}


@override
int get hashCode {
    return Object.hash(runtimeType,surah,ayah,ayahText);
}

@override
String toString() {
    return 'BookmarksEvent.addBookmark(surah: $surah, ayah: $ayah, ayahText: $ayahText)';
}


}

/// @nodoc
abstract mixin class $BookmarksAddBookmarkCopyWith<$Res> implements $BookmarksEventCopyWith<$Res> {
  factory $BookmarksAddBookmarkCopyWith(BookmarksAddBookmark value, $Res Function(BookmarksAddBookmark) _then) = _$BookmarksAddBookmarkCopyWithImpl;
@useResult
$Res call({
 int surah, int ayah, String ayahText
});




}
/// @nodoc
class _$BookmarksAddBookmarkCopyWithImpl<$Res>
    implements $BookmarksAddBookmarkCopyWith<$Res> {
  _$BookmarksAddBookmarkCopyWithImpl(this._self, this._then);

  final BookmarksAddBookmark _self;
  final $Res Function(BookmarksAddBookmark) _then;

/// Create a copy of BookmarksEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? surah = null,Object? ayah = null,Object? ayahText = null,}) {
  return _then(BookmarksAddBookmark(
surah: null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as int,ayah: null == ayah ? _self.ayah : ayah // ignore: cast_nullable_to_non_nullable
as int,ayahText: null == ayahText ? _self.ayahText : ayahText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class BookmarksRemoveBookmark implements BookmarksEvent {
  const BookmarksRemoveBookmark({required this.surah, required this.ayah});
  

 final  int surah;
 final  int ayah;

/// Create a copy of BookmarksEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookmarksRemoveBookmarkCopyWith<BookmarksRemoveBookmark> get copyWith => _$BookmarksRemoveBookmarkCopyWithImpl<BookmarksRemoveBookmark>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is BookmarksRemoveBookmark&&(identical(other.surah, surah) || other.surah == surah)&&(identical(other.ayah, ayah) || other.ayah == ayah));
}


@override
int get hashCode {
    return Object.hash(runtimeType,surah,ayah);
}

@override
String toString() {
    return 'BookmarksEvent.removeBookmark(surah: $surah, ayah: $ayah)';
}


}

/// @nodoc
abstract mixin class $BookmarksRemoveBookmarkCopyWith<$Res> implements $BookmarksEventCopyWith<$Res> {
  factory $BookmarksRemoveBookmarkCopyWith(BookmarksRemoveBookmark value, $Res Function(BookmarksRemoveBookmark) _then) = _$BookmarksRemoveBookmarkCopyWithImpl;
@useResult
$Res call({
 int surah, int ayah
});




}
/// @nodoc
class _$BookmarksRemoveBookmarkCopyWithImpl<$Res>
    implements $BookmarksRemoveBookmarkCopyWith<$Res> {
  _$BookmarksRemoveBookmarkCopyWithImpl(this._self, this._then);

  final BookmarksRemoveBookmark _self;
  final $Res Function(BookmarksRemoveBookmark) _then;

/// Create a copy of BookmarksEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? surah = null,Object? ayah = null,}) {
  return _then(BookmarksRemoveBookmark(
surah: null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as int,ayah: null == ayah ? _self.ayah : ayah // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
