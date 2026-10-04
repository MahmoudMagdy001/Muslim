// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surahs_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SurahsListState {

 SurahsListStatus get status; String? get message; List<SurahsListModel> get allSurahs; List<SurahsListModel> get filteredSurahs; String get searchText; List<SearchResult> get searchResults; List<JuzModel> get juzs; List<HizbModel> get hizbs; QuranViewType get currentViewType;
/// Create a copy of SurahsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahsListStateCopyWith<SurahsListState> get copyWith => _$SurahsListStateCopyWithImpl<SurahsListState>(this as SurahsListState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SurahsListState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahsListState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.allSurahs, _this.allSurahs)&&const DeepCollectionEquality().equals(other.filteredSurahs, _this.filteredSurahs)&&(identical(other.searchText, _this.searchText) || other.searchText == _this.searchText)&&const DeepCollectionEquality().equals(other.searchResults, _this.searchResults)&&const DeepCollectionEquality().equals(other.juzs, _this.juzs)&&const DeepCollectionEquality().equals(other.hizbs, _this.hizbs)&&(identical(other.currentViewType, _this.currentViewType) || other.currentViewType == _this.currentViewType));
}


@override
int get hashCode {
  final _this = this as SurahsListState;
  return Object.hash(runtimeType,_this.status,_this.message,const DeepCollectionEquality().hash(_this.allSurahs),const DeepCollectionEquality().hash(_this.filteredSurahs),_this.searchText,const DeepCollectionEquality().hash(_this.searchResults),const DeepCollectionEquality().hash(_this.juzs),const DeepCollectionEquality().hash(_this.hizbs),_this.currentViewType);
}

@override
String toString() {
  final _this = this as SurahsListState;
  return 'SurahsListState(status: ${_this.status}, message: ${_this.message}, allSurahs: ${_this.allSurahs}, filteredSurahs: ${_this.filteredSurahs}, searchText: ${_this.searchText}, searchResults: ${_this.searchResults}, juzs: ${_this.juzs}, hizbs: ${_this.hizbs}, currentViewType: ${_this.currentViewType})';
}


}

/// @nodoc
abstract mixin class $SurahsListStateCopyWith<$Res>  {
  factory $SurahsListStateCopyWith(SurahsListState value, $Res Function(SurahsListState) _then) = _$SurahsListStateCopyWithImpl;
@useResult
$Res call({
 SurahsListStatus status, String? message, List<SurahsListModel> allSurahs, List<SurahsListModel> filteredSurahs, String searchText, List<SearchResult> searchResults, List<JuzModel> juzs, List<HizbModel> hizbs, QuranViewType currentViewType
});




}
/// @nodoc
class _$SurahsListStateCopyWithImpl<$Res>
    implements $SurahsListStateCopyWith<$Res> {
  _$SurahsListStateCopyWithImpl(this._self, this._then);

  final SurahsListState _self;
  final $Res Function(SurahsListState) _then;

/// Create a copy of SurahsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? message = freezed,Object? allSurahs = null,Object? filteredSurahs = null,Object? searchText = null,Object? searchResults = null,Object? juzs = null,Object? hizbs = null,Object? currentViewType = null,}) {
  return _then(SurahsListState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SurahsListStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,allSurahs: null == allSurahs ? _self.allSurahs : allSurahs // ignore: cast_nullable_to_non_nullable
as List<SurahsListModel>,filteredSurahs: null == filteredSurahs ? _self.filteredSurahs : filteredSurahs // ignore: cast_nullable_to_non_nullable
as List<SurahsListModel>,searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,searchResults: null == searchResults ? _self.searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<SearchResult>,juzs: null == juzs ? _self.juzs : juzs // ignore: cast_nullable_to_non_nullable
as List<JuzModel>,hizbs: null == hizbs ? _self.hizbs : hizbs // ignore: cast_nullable_to_non_nullable
as List<HizbModel>,currentViewType: null == currentViewType ? _self.currentViewType : currentViewType // ignore: cast_nullable_to_non_nullable
as QuranViewType,
  ));
}

}


/// Adds pattern-matching-related methods to [SurahsListState].
extension SurahsListStatePatterns on SurahsListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurahsListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurahsListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurahsListState value)  $default,){
final _that = this;
switch (_that) {
case _SurahsListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurahsListState value)?  $default,){
final _that = this;
switch (_that) {
case _SurahsListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SurahsListStatus status,  String? message,  List<SurahsListModel> allSurahs,  List<SurahsListModel> filteredSurahs,  String searchText,  List<SearchResult> searchResults,  List<JuzModel> juzs,  List<HizbModel> hizbs,  QuranViewType currentViewType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurahsListState() when $default != null:
return $default(_that.status,_that.message,_that.allSurahs,_that.filteredSurahs,_that.searchText,_that.searchResults,_that.juzs,_that.hizbs,_that.currentViewType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SurahsListStatus status,  String? message,  List<SurahsListModel> allSurahs,  List<SurahsListModel> filteredSurahs,  String searchText,  List<SearchResult> searchResults,  List<JuzModel> juzs,  List<HizbModel> hizbs,  QuranViewType currentViewType)  $default,) {final _that = this;
switch (_that) {
case _SurahsListState():
return $default(_that.status,_that.message,_that.allSurahs,_that.filteredSurahs,_that.searchText,_that.searchResults,_that.juzs,_that.hizbs,_that.currentViewType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SurahsListStatus status,  String? message,  List<SurahsListModel> allSurahs,  List<SurahsListModel> filteredSurahs,  String searchText,  List<SearchResult> searchResults,  List<JuzModel> juzs,  List<HizbModel> hizbs,  QuranViewType currentViewType)?  $default,) {final _that = this;
switch (_that) {
case _SurahsListState() when $default != null:
return $default(_that.status,_that.message,_that.allSurahs,_that.filteredSurahs,_that.searchText,_that.searchResults,_that.juzs,_that.hizbs,_that.currentViewType);case _:
  return null;

}
}

}

/// @nodoc


class _SurahsListState implements SurahsListState {
  const _SurahsListState({this.status = SurahsListStatus.initial, this.message,  List<SurahsListModel> allSurahs = const [],  List<SurahsListModel> filteredSurahs = const [], this.searchText = '',  List<SearchResult> searchResults = const [],  List<JuzModel> juzs = const [],  List<HizbModel> hizbs = const [], this.currentViewType = QuranViewType.surah}): _allSurahs = allSurahs,_filteredSurahs = filteredSurahs,_searchResults = searchResults,_juzs = juzs,_hizbs = hizbs;
  

@override@JsonKey() final  SurahsListStatus status;
@override final  String? message;
 final  List<SurahsListModel> _allSurahs;
@override@JsonKey() List<SurahsListModel> get allSurahs {
  if (_allSurahs is EqualUnmodifiableListView) return _allSurahs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allSurahs);
}

 final  List<SurahsListModel> _filteredSurahs;
@override@JsonKey() List<SurahsListModel> get filteredSurahs {
  if (_filteredSurahs is EqualUnmodifiableListView) return _filteredSurahs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredSurahs);
}

@override@JsonKey() final  String searchText;
 final  List<SearchResult> _searchResults;
@override@JsonKey() List<SearchResult> get searchResults {
  if (_searchResults is EqualUnmodifiableListView) return _searchResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_searchResults);
}

 final  List<JuzModel> _juzs;
@override@JsonKey() List<JuzModel> get juzs {
  if (_juzs is EqualUnmodifiableListView) return _juzs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_juzs);
}

 final  List<HizbModel> _hizbs;
@override@JsonKey() List<HizbModel> get hizbs {
  if (_hizbs is EqualUnmodifiableListView) return _hizbs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hizbs);
}

@override@JsonKey() final  QuranViewType currentViewType;

/// Create a copy of SurahsListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurahsListStateCopyWith<_SurahsListState> get copyWith => __$SurahsListStateCopyWithImpl<_SurahsListState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurahsListState&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.allSurahs, _allSurahs)&&const DeepCollectionEquality().equals(other.filteredSurahs, _filteredSurahs)&&(identical(other.searchText, searchText) || other.searchText == searchText)&&const DeepCollectionEquality().equals(other.searchResults, _searchResults)&&const DeepCollectionEquality().equals(other.juzs, _juzs)&&const DeepCollectionEquality().equals(other.hizbs, _hizbs)&&(identical(other.currentViewType, currentViewType) || other.currentViewType == currentViewType));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,message,const DeepCollectionEquality().hash(_allSurahs),const DeepCollectionEquality().hash(_filteredSurahs),searchText,const DeepCollectionEquality().hash(_searchResults),const DeepCollectionEquality().hash(_juzs),const DeepCollectionEquality().hash(_hizbs),currentViewType);
}

@override
String toString() {
    return 'SurahsListState(status: $status, message: $message, allSurahs: $allSurahs, filteredSurahs: $filteredSurahs, searchText: $searchText, searchResults: $searchResults, juzs: $juzs, hizbs: $hizbs, currentViewType: $currentViewType)';
}


}

/// @nodoc
abstract mixin class _$SurahsListStateCopyWith<$Res> implements $SurahsListStateCopyWith<$Res> {
  factory _$SurahsListStateCopyWith(_SurahsListState value, $Res Function(_SurahsListState) _then) = __$SurahsListStateCopyWithImpl;
@override @useResult
$Res call({
 SurahsListStatus status, String? message, List<SurahsListModel> allSurahs, List<SurahsListModel> filteredSurahs, String searchText, List<SearchResult> searchResults, List<JuzModel> juzs, List<HizbModel> hizbs, QuranViewType currentViewType
});




}
/// @nodoc
class __$SurahsListStateCopyWithImpl<$Res>
    implements _$SurahsListStateCopyWith<$Res> {
  __$SurahsListStateCopyWithImpl(this._self, this._then);

  final _SurahsListState _self;
  final $Res Function(_SurahsListState) _then;

/// Create a copy of SurahsListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? message = freezed,Object? allSurahs = null,Object? filteredSurahs = null,Object? searchText = null,Object? searchResults = null,Object? juzs = null,Object? hizbs = null,Object? currentViewType = null,}) {
  return _then(_SurahsListState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SurahsListStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,allSurahs: null == allSurahs ? _self._allSurahs : allSurahs // ignore: cast_nullable_to_non_nullable
as List<SurahsListModel>,filteredSurahs: null == filteredSurahs ? _self._filteredSurahs : filteredSurahs // ignore: cast_nullable_to_non_nullable
as List<SurahsListModel>,searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,searchResults: null == searchResults ? _self._searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<SearchResult>,juzs: null == juzs ? _self._juzs : juzs // ignore: cast_nullable_to_non_nullable
as List<JuzModel>,hizbs: null == hizbs ? _self._hizbs : hizbs // ignore: cast_nullable_to_non_nullable
as List<HizbModel>,currentViewType: null == currentViewType ? _self.currentViewType : currentViewType // ignore: cast_nullable_to_non_nullable
as QuranViewType,
  ));
}


}

// dart format on
