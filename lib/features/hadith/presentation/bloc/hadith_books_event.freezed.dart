// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hadith_books_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HadithBooksEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HadithBooksEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HadithBooksEvent()';
}


}

/// @nodoc
class $HadithBooksEventCopyWith<$Res>  {
$HadithBooksEventCopyWith(HadithBooksEvent _, $Res Function(HadithBooksEvent) __);
}


/// Adds pattern-matching-related methods to [HadithBooksEvent].
extension HadithBooksEventPatterns on HadithBooksEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HadithBooksLoadBooks value)?  loadBooks,TResult Function( HadithBooksLoadRandomHadith value)?  loadRandomHadith,TResult Function( HadithBooksUpdateSearchText value)?  updateSearchText,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HadithBooksLoadBooks() when loadBooks != null:
return loadBooks(_that);case HadithBooksLoadRandomHadith() when loadRandomHadith != null:
return loadRandomHadith(_that);case HadithBooksUpdateSearchText() when updateSearchText != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HadithBooksLoadBooks value)  loadBooks,required TResult Function( HadithBooksLoadRandomHadith value)  loadRandomHadith,required TResult Function( HadithBooksUpdateSearchText value)  updateSearchText,}){
final _that = this;
switch (_that) {
case HadithBooksLoadBooks():
return loadBooks(_that);case HadithBooksLoadRandomHadith():
return loadRandomHadith(_that);case HadithBooksUpdateSearchText():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HadithBooksLoadBooks value)?  loadBooks,TResult? Function( HadithBooksLoadRandomHadith value)?  loadRandomHadith,TResult? Function( HadithBooksUpdateSearchText value)?  updateSearchText,}){
final _that = this;
switch (_that) {
case HadithBooksLoadBooks() when loadBooks != null:
return loadBooks(_that);case HadithBooksLoadRandomHadith() when loadRandomHadith != null:
return loadRandomHadith(_that);case HadithBooksUpdateSearchText() when updateSearchText != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadBooks,TResult Function()?  loadRandomHadith,TResult Function( String text)?  updateSearchText,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HadithBooksLoadBooks() when loadBooks != null:
return loadBooks();case HadithBooksLoadRandomHadith() when loadRandomHadith != null:
return loadRandomHadith();case HadithBooksUpdateSearchText() when updateSearchText != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadBooks,required TResult Function()  loadRandomHadith,required TResult Function( String text)  updateSearchText,}) {final _that = this;
switch (_that) {
case HadithBooksLoadBooks():
return loadBooks();case HadithBooksLoadRandomHadith():
return loadRandomHadith();case HadithBooksUpdateSearchText():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadBooks,TResult? Function()?  loadRandomHadith,TResult? Function( String text)?  updateSearchText,}) {final _that = this;
switch (_that) {
case HadithBooksLoadBooks() when loadBooks != null:
return loadBooks();case HadithBooksLoadRandomHadith() when loadRandomHadith != null:
return loadRandomHadith();case HadithBooksUpdateSearchText() when updateSearchText != null:
return updateSearchText(_that.text);case _:
  return null;

}
}

}

/// @nodoc


class HadithBooksLoadBooks implements HadithBooksEvent {
  const HadithBooksLoadBooks();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HadithBooksLoadBooks);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HadithBooksEvent.loadBooks()';
}


}




/// @nodoc


class HadithBooksLoadRandomHadith implements HadithBooksEvent {
  const HadithBooksLoadRandomHadith();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HadithBooksLoadRandomHadith);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HadithBooksEvent.loadRandomHadith()';
}


}




/// @nodoc


class HadithBooksUpdateSearchText implements HadithBooksEvent {
  const HadithBooksUpdateSearchText(this.text);
  

 final  String text;

/// Create a copy of HadithBooksEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HadithBooksUpdateSearchTextCopyWith<HadithBooksUpdateSearchText> get copyWith => _$HadithBooksUpdateSearchTextCopyWithImpl<HadithBooksUpdateSearchText>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HadithBooksUpdateSearchText&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode {
    return Object.hash(runtimeType,text);
}

@override
String toString() {
    return 'HadithBooksEvent.updateSearchText(text: $text)';
}


}

/// @nodoc
abstract mixin class $HadithBooksUpdateSearchTextCopyWith<$Res> implements $HadithBooksEventCopyWith<$Res> {
  factory $HadithBooksUpdateSearchTextCopyWith(HadithBooksUpdateSearchText value, $Res Function(HadithBooksUpdateSearchText) _then) = _$HadithBooksUpdateSearchTextCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$HadithBooksUpdateSearchTextCopyWithImpl<$Res>
    implements $HadithBooksUpdateSearchTextCopyWith<$Res> {
  _$HadithBooksUpdateSearchTextCopyWithImpl(this._self, this._then);

  final HadithBooksUpdateSearchText _self;
  final $Res Function(HadithBooksUpdateSearchText) _then;

/// Create a copy of HadithBooksEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(HadithBooksUpdateSearchText(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
