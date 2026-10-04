// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_of_book_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChapterOfBookState {

 ChapterOfBookStatus get status; List<ChapterOfBookEntity> get chapters; String get searchText; String? get errorMessage;
/// Create a copy of ChapterOfBookState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterOfBookStateCopyWith<ChapterOfBookState> get copyWith => _$ChapterOfBookStateCopyWithImpl<ChapterOfBookState>(this as ChapterOfBookState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChapterOfBookState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterOfBookState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.chapters, _this.chapters)&&(identical(other.searchText, _this.searchText) || other.searchText == _this.searchText)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as ChapterOfBookState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.chapters),_this.searchText,_this.errorMessage);
}

@override
String toString() {
  final _this = this as ChapterOfBookState;
  return 'ChapterOfBookState(status: ${_this.status}, chapters: ${_this.chapters}, searchText: ${_this.searchText}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $ChapterOfBookStateCopyWith<$Res>  {
  factory $ChapterOfBookStateCopyWith(ChapterOfBookState value, $Res Function(ChapterOfBookState) _then) = _$ChapterOfBookStateCopyWithImpl;
@useResult
$Res call({
 ChapterOfBookStatus status, List<ChapterOfBookEntity> chapters, String searchText, String? errorMessage
});




}
/// @nodoc
class _$ChapterOfBookStateCopyWithImpl<$Res>
    implements $ChapterOfBookStateCopyWith<$Res> {
  _$ChapterOfBookStateCopyWithImpl(this._self, this._then);

  final ChapterOfBookState _self;
  final $Res Function(ChapterOfBookState) _then;

/// Create a copy of ChapterOfBookState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? chapters = null,Object? searchText = null,Object? errorMessage = freezed,}) {
  return _then(ChapterOfBookState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChapterOfBookStatus,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterOfBookEntity>,searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChapterOfBookState].
extension ChapterOfBookStatePatterns on ChapterOfBookState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChapterOfBookState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChapterOfBookState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChapterOfBookState value)  $default,){
final _that = this;
switch (_that) {
case _ChapterOfBookState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChapterOfBookState value)?  $default,){
final _that = this;
switch (_that) {
case _ChapterOfBookState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChapterOfBookStatus status,  List<ChapterOfBookEntity> chapters,  String searchText,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChapterOfBookState() when $default != null:
return $default(_that.status,_that.chapters,_that.searchText,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChapterOfBookStatus status,  List<ChapterOfBookEntity> chapters,  String searchText,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ChapterOfBookState():
return $default(_that.status,_that.chapters,_that.searchText,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChapterOfBookStatus status,  List<ChapterOfBookEntity> chapters,  String searchText,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ChapterOfBookState() when $default != null:
return $default(_that.status,_that.chapters,_that.searchText,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ChapterOfBookState implements ChapterOfBookState {
  const _ChapterOfBookState({this.status = ChapterOfBookStatus.initial,  List<ChapterOfBookEntity> chapters = const [], this.searchText = '', this.errorMessage}): _chapters = chapters;
  

@override@JsonKey() final  ChapterOfBookStatus status;
 final  List<ChapterOfBookEntity> _chapters;
@override@JsonKey() List<ChapterOfBookEntity> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}

@override@JsonKey() final  String searchText;
@override final  String? errorMessage;

/// Create a copy of ChapterOfBookState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterOfBookStateCopyWith<_ChapterOfBookState> get copyWith => __$ChapterOfBookStateCopyWithImpl<_ChapterOfBookState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterOfBookState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.chapters, _chapters)&&(identical(other.searchText, searchText) || other.searchText == searchText)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_chapters),searchText,errorMessage);
}

@override
String toString() {
    return 'ChapterOfBookState(status: $status, chapters: $chapters, searchText: $searchText, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ChapterOfBookStateCopyWith<$Res> implements $ChapterOfBookStateCopyWith<$Res> {
  factory _$ChapterOfBookStateCopyWith(_ChapterOfBookState value, $Res Function(_ChapterOfBookState) _then) = __$ChapterOfBookStateCopyWithImpl;
@override @useResult
$Res call({
 ChapterOfBookStatus status, List<ChapterOfBookEntity> chapters, String searchText, String? errorMessage
});




}
/// @nodoc
class __$ChapterOfBookStateCopyWithImpl<$Res>
    implements _$ChapterOfBookStateCopyWith<$Res> {
  __$ChapterOfBookStateCopyWithImpl(this._self, this._then);

  final _ChapterOfBookState _self;
  final $Res Function(_ChapterOfBookState) _then;

/// Create a copy of ChapterOfBookState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? chapters = null,Object? searchText = null,Object? errorMessage = freezed,}) {
  return _then(_ChapterOfBookState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChapterOfBookStatus,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterOfBookEntity>,searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
