// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hadith_books_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HadithBooksState {

 HadithBooksStatus get status; List<HadithBookEntity> get books; RandomHadithStatus get randomHadithStatus; Map<String, dynamic>? get randomHadithData; String get searchText; String? get errorMessage;
/// Create a copy of HadithBooksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HadithBooksStateCopyWith<HadithBooksState> get copyWith => _$HadithBooksStateCopyWithImpl<HadithBooksState>(this as HadithBooksState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HadithBooksState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HadithBooksState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.books, _this.books)&&(identical(other.randomHadithStatus, _this.randomHadithStatus) || other.randomHadithStatus == _this.randomHadithStatus)&&const DeepCollectionEquality().equals(other.randomHadithData, _this.randomHadithData)&&(identical(other.searchText, _this.searchText) || other.searchText == _this.searchText)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as HadithBooksState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.books),_this.randomHadithStatus,const DeepCollectionEquality().hash(_this.randomHadithData),_this.searchText,_this.errorMessage);
}

@override
String toString() {
  final _this = this as HadithBooksState;
  return 'HadithBooksState(status: ${_this.status}, books: ${_this.books}, randomHadithStatus: ${_this.randomHadithStatus}, randomHadithData: ${_this.randomHadithData}, searchText: ${_this.searchText}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $HadithBooksStateCopyWith<$Res>  {
  factory $HadithBooksStateCopyWith(HadithBooksState value, $Res Function(HadithBooksState) _then) = _$HadithBooksStateCopyWithImpl;
@useResult
$Res call({
 HadithBooksStatus status, List<HadithBookEntity> books, RandomHadithStatus randomHadithStatus, Map<String, dynamic>? randomHadithData, String searchText, String? errorMessage
});




}
/// @nodoc
class _$HadithBooksStateCopyWithImpl<$Res>
    implements $HadithBooksStateCopyWith<$Res> {
  _$HadithBooksStateCopyWithImpl(this._self, this._then);

  final HadithBooksState _self;
  final $Res Function(HadithBooksState) _then;

/// Create a copy of HadithBooksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? books = null,Object? randomHadithStatus = null,Object? randomHadithData = freezed,Object? searchText = null,Object? errorMessage = freezed,}) {
  return _then(HadithBooksState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HadithBooksStatus,books: null == books ? _self.books : books // ignore: cast_nullable_to_non_nullable
as List<HadithBookEntity>,randomHadithStatus: null == randomHadithStatus ? _self.randomHadithStatus : randomHadithStatus // ignore: cast_nullable_to_non_nullable
as RandomHadithStatus,randomHadithData: freezed == randomHadithData ? _self.randomHadithData : randomHadithData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HadithBooksState].
extension HadithBooksStatePatterns on HadithBooksState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HadithBooksState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HadithBooksState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HadithBooksState value)  $default,){
final _that = this;
switch (_that) {
case _HadithBooksState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HadithBooksState value)?  $default,){
final _that = this;
switch (_that) {
case _HadithBooksState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HadithBooksStatus status,  List<HadithBookEntity> books,  RandomHadithStatus randomHadithStatus,  Map<String, dynamic>? randomHadithData,  String searchText,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HadithBooksState() when $default != null:
return $default(_that.status,_that.books,_that.randomHadithStatus,_that.randomHadithData,_that.searchText,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HadithBooksStatus status,  List<HadithBookEntity> books,  RandomHadithStatus randomHadithStatus,  Map<String, dynamic>? randomHadithData,  String searchText,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _HadithBooksState():
return $default(_that.status,_that.books,_that.randomHadithStatus,_that.randomHadithData,_that.searchText,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HadithBooksStatus status,  List<HadithBookEntity> books,  RandomHadithStatus randomHadithStatus,  Map<String, dynamic>? randomHadithData,  String searchText,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _HadithBooksState() when $default != null:
return $default(_that.status,_that.books,_that.randomHadithStatus,_that.randomHadithData,_that.searchText,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _HadithBooksState implements HadithBooksState {
  const _HadithBooksState({this.status = HadithBooksStatus.initial,  List<HadithBookEntity> books = const [], this.randomHadithStatus = RandomHadithStatus.initial,  Map<String, dynamic>? randomHadithData, this.searchText = '', this.errorMessage}): _books = books,_randomHadithData = randomHadithData;
  

@override@JsonKey() final  HadithBooksStatus status;
 final  List<HadithBookEntity> _books;
@override@JsonKey() List<HadithBookEntity> get books {
  if (_books is EqualUnmodifiableListView) return _books;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_books);
}

@override@JsonKey() final  RandomHadithStatus randomHadithStatus;
 final  Map<String, dynamic>? _randomHadithData;
@override Map<String, dynamic>? get randomHadithData {
  final value = _randomHadithData;
  if (value == null) return null;
  if (_randomHadithData is EqualUnmodifiableMapView) return _randomHadithData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey() final  String searchText;
@override final  String? errorMessage;

/// Create a copy of HadithBooksState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HadithBooksStateCopyWith<_HadithBooksState> get copyWith => __$HadithBooksStateCopyWithImpl<_HadithBooksState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HadithBooksState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.books, _books)&&(identical(other.randomHadithStatus, randomHadithStatus) || other.randomHadithStatus == randomHadithStatus)&&const DeepCollectionEquality().equals(other.randomHadithData, _randomHadithData)&&(identical(other.searchText, searchText) || other.searchText == searchText)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_books),randomHadithStatus,const DeepCollectionEquality().hash(_randomHadithData),searchText,errorMessage);
}

@override
String toString() {
    return 'HadithBooksState(status: $status, books: $books, randomHadithStatus: $randomHadithStatus, randomHadithData: $randomHadithData, searchText: $searchText, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$HadithBooksStateCopyWith<$Res> implements $HadithBooksStateCopyWith<$Res> {
  factory _$HadithBooksStateCopyWith(_HadithBooksState value, $Res Function(_HadithBooksState) _then) = __$HadithBooksStateCopyWithImpl;
@override @useResult
$Res call({
 HadithBooksStatus status, List<HadithBookEntity> books, RandomHadithStatus randomHadithStatus, Map<String, dynamic>? randomHadithData, String searchText, String? errorMessage
});




}
/// @nodoc
class __$HadithBooksStateCopyWithImpl<$Res>
    implements _$HadithBooksStateCopyWith<$Res> {
  __$HadithBooksStateCopyWithImpl(this._self, this._then);

  final _HadithBooksState _self;
  final $Res Function(_HadithBooksState) _then;

/// Create a copy of HadithBooksState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? books = null,Object? randomHadithStatus = null,Object? randomHadithData = freezed,Object? searchText = null,Object? errorMessage = freezed,}) {
  return _then(_HadithBooksState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HadithBooksStatus,books: null == books ? _self._books : books // ignore: cast_nullable_to_non_nullable
as List<HadithBookEntity>,randomHadithStatus: null == randomHadithStatus ? _self.randomHadithStatus : randomHadithStatus // ignore: cast_nullable_to_non_nullable
as RandomHadithStatus,randomHadithData: freezed == randomHadithData ? _self._randomHadithData : randomHadithData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
