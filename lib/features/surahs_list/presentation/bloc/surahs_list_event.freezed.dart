// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surahs_list_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SurahsListEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahsListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SurahsListEvent()';
}


}

/// @nodoc
class $SurahsListEventCopyWith<$Res>  {
$SurahsListEventCopyWith(SurahsListEvent _, $Res Function(SurahsListEvent) __);
}


/// Adds pattern-matching-related methods to [SurahsListEvent].
extension SurahsListEventPatterns on SurahsListEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SurahsListLoadSurahs value)?  loadSurahs,TResult Function( SurahsListSearchInQuran value)?  searchInQuran,TResult Function( SurahsListChangeViewType value)?  changeViewType,TResult Function( SurahsListSaveLastSurah value)?  saveLastSurah,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SurahsListLoadSurahs() when loadSurahs != null:
return loadSurahs(_that);case SurahsListSearchInQuran() when searchInQuran != null:
return searchInQuran(_that);case SurahsListChangeViewType() when changeViewType != null:
return changeViewType(_that);case SurahsListSaveLastSurah() when saveLastSurah != null:
return saveLastSurah(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SurahsListLoadSurahs value)  loadSurahs,required TResult Function( SurahsListSearchInQuran value)  searchInQuran,required TResult Function( SurahsListChangeViewType value)  changeViewType,required TResult Function( SurahsListSaveLastSurah value)  saveLastSurah,}){
final _that = this;
switch (_that) {
case SurahsListLoadSurahs():
return loadSurahs(_that);case SurahsListSearchInQuran():
return searchInQuran(_that);case SurahsListChangeViewType():
return changeViewType(_that);case SurahsListSaveLastSurah():
return saveLastSurah(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SurahsListLoadSurahs value)?  loadSurahs,TResult? Function( SurahsListSearchInQuran value)?  searchInQuran,TResult? Function( SurahsListChangeViewType value)?  changeViewType,TResult? Function( SurahsListSaveLastSurah value)?  saveLastSurah,}){
final _that = this;
switch (_that) {
case SurahsListLoadSurahs() when loadSurahs != null:
return loadSurahs(_that);case SurahsListSearchInQuran() when searchInQuran != null:
return searchInQuran(_that);case SurahsListChangeViewType() when changeViewType != null:
return changeViewType(_that);case SurahsListSaveLastSurah() when saveLastSurah != null:
return saveLastSurah(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool isArabic)?  loadSurahs,TResult Function( String keyword,  bool partial)?  searchInQuran,TResult Function( QuranViewType viewType)?  changeViewType,TResult Function( int surah,  int lastAyah)?  saveLastSurah,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SurahsListLoadSurahs() when loadSurahs != null:
return loadSurahs(_that.isArabic);case SurahsListSearchInQuran() when searchInQuran != null:
return searchInQuran(_that.keyword,_that.partial);case SurahsListChangeViewType() when changeViewType != null:
return changeViewType(_that.viewType);case SurahsListSaveLastSurah() when saveLastSurah != null:
return saveLastSurah(_that.surah,_that.lastAyah);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool isArabic)  loadSurahs,required TResult Function( String keyword,  bool partial)  searchInQuran,required TResult Function( QuranViewType viewType)  changeViewType,required TResult Function( int surah,  int lastAyah)  saveLastSurah,}) {final _that = this;
switch (_that) {
case SurahsListLoadSurahs():
return loadSurahs(_that.isArabic);case SurahsListSearchInQuran():
return searchInQuran(_that.keyword,_that.partial);case SurahsListChangeViewType():
return changeViewType(_that.viewType);case SurahsListSaveLastSurah():
return saveLastSurah(_that.surah,_that.lastAyah);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool isArabic)?  loadSurahs,TResult? Function( String keyword,  bool partial)?  searchInQuran,TResult? Function( QuranViewType viewType)?  changeViewType,TResult? Function( int surah,  int lastAyah)?  saveLastSurah,}) {final _that = this;
switch (_that) {
case SurahsListLoadSurahs() when loadSurahs != null:
return loadSurahs(_that.isArabic);case SurahsListSearchInQuran() when searchInQuran != null:
return searchInQuran(_that.keyword,_that.partial);case SurahsListChangeViewType() when changeViewType != null:
return changeViewType(_that.viewType);case SurahsListSaveLastSurah() when saveLastSurah != null:
return saveLastSurah(_that.surah,_that.lastAyah);case _:
  return null;

}
}

}

/// @nodoc


class SurahsListLoadSurahs implements SurahsListEvent {
  const SurahsListLoadSurahs({this.isArabic = true});
  

@JsonKey() final  bool isArabic;

/// Create a copy of SurahsListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahsListLoadSurahsCopyWith<SurahsListLoadSurahs> get copyWith => _$SurahsListLoadSurahsCopyWithImpl<SurahsListLoadSurahs>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahsListLoadSurahs&&(identical(other.isArabic, isArabic) || other.isArabic == isArabic));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isArabic);
}

@override
String toString() {
    return 'SurahsListEvent.loadSurahs(isArabic: $isArabic)';
}


}

/// @nodoc
abstract mixin class $SurahsListLoadSurahsCopyWith<$Res> implements $SurahsListEventCopyWith<$Res> {
  factory $SurahsListLoadSurahsCopyWith(SurahsListLoadSurahs value, $Res Function(SurahsListLoadSurahs) _then) = _$SurahsListLoadSurahsCopyWithImpl;
@useResult
$Res call({
 bool isArabic
});




}
/// @nodoc
class _$SurahsListLoadSurahsCopyWithImpl<$Res>
    implements $SurahsListLoadSurahsCopyWith<$Res> {
  _$SurahsListLoadSurahsCopyWithImpl(this._self, this._then);

  final SurahsListLoadSurahs _self;
  final $Res Function(SurahsListLoadSurahs) _then;

/// Create a copy of SurahsListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isArabic = null,}) {
  return _then(SurahsListLoadSurahs(
isArabic: null == isArabic ? _self.isArabic : isArabic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SurahsListSearchInQuran implements SurahsListEvent {
  const SurahsListSearchInQuran({required this.keyword, required this.partial});
  

 final  String keyword;
 final  bool partial;

/// Create a copy of SurahsListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahsListSearchInQuranCopyWith<SurahsListSearchInQuran> get copyWith => _$SurahsListSearchInQuranCopyWithImpl<SurahsListSearchInQuran>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahsListSearchInQuran&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.partial, partial) || other.partial == partial));
}


@override
int get hashCode {
    return Object.hash(runtimeType,keyword,partial);
}

@override
String toString() {
    return 'SurahsListEvent.searchInQuran(keyword: $keyword, partial: $partial)';
}


}

/// @nodoc
abstract mixin class $SurahsListSearchInQuranCopyWith<$Res> implements $SurahsListEventCopyWith<$Res> {
  factory $SurahsListSearchInQuranCopyWith(SurahsListSearchInQuran value, $Res Function(SurahsListSearchInQuran) _then) = _$SurahsListSearchInQuranCopyWithImpl;
@useResult
$Res call({
 String keyword, bool partial
});




}
/// @nodoc
class _$SurahsListSearchInQuranCopyWithImpl<$Res>
    implements $SurahsListSearchInQuranCopyWith<$Res> {
  _$SurahsListSearchInQuranCopyWithImpl(this._self, this._then);

  final SurahsListSearchInQuran _self;
  final $Res Function(SurahsListSearchInQuran) _then;

/// Create a copy of SurahsListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? keyword = null,Object? partial = null,}) {
  return _then(SurahsListSearchInQuran(
keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,partial: null == partial ? _self.partial : partial // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SurahsListChangeViewType implements SurahsListEvent {
  const SurahsListChangeViewType(this.viewType);
  

 final  QuranViewType viewType;

/// Create a copy of SurahsListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahsListChangeViewTypeCopyWith<SurahsListChangeViewType> get copyWith => _$SurahsListChangeViewTypeCopyWithImpl<SurahsListChangeViewType>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahsListChangeViewType&&(identical(other.viewType, viewType) || other.viewType == viewType));
}


@override
int get hashCode {
    return Object.hash(runtimeType,viewType);
}

@override
String toString() {
    return 'SurahsListEvent.changeViewType(viewType: $viewType)';
}


}

/// @nodoc
abstract mixin class $SurahsListChangeViewTypeCopyWith<$Res> implements $SurahsListEventCopyWith<$Res> {
  factory $SurahsListChangeViewTypeCopyWith(SurahsListChangeViewType value, $Res Function(SurahsListChangeViewType) _then) = _$SurahsListChangeViewTypeCopyWithImpl;
@useResult
$Res call({
 QuranViewType viewType
});




}
/// @nodoc
class _$SurahsListChangeViewTypeCopyWithImpl<$Res>
    implements $SurahsListChangeViewTypeCopyWith<$Res> {
  _$SurahsListChangeViewTypeCopyWithImpl(this._self, this._then);

  final SurahsListChangeViewType _self;
  final $Res Function(SurahsListChangeViewType) _then;

/// Create a copy of SurahsListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? viewType = null,}) {
  return _then(SurahsListChangeViewType(
null == viewType ? _self.viewType : viewType // ignore: cast_nullable_to_non_nullable
as QuranViewType,
  ));
}


}

/// @nodoc


class SurahsListSaveLastSurah implements SurahsListEvent {
  const SurahsListSaveLastSurah({required this.surah, this.lastAyah = 1});
  

 final  int surah;
@JsonKey() final  int lastAyah;

/// Create a copy of SurahsListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahsListSaveLastSurahCopyWith<SurahsListSaveLastSurah> get copyWith => _$SurahsListSaveLastSurahCopyWithImpl<SurahsListSaveLastSurah>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahsListSaveLastSurah&&(identical(other.surah, surah) || other.surah == surah)&&(identical(other.lastAyah, lastAyah) || other.lastAyah == lastAyah));
}


@override
int get hashCode {
    return Object.hash(runtimeType,surah,lastAyah);
}

@override
String toString() {
    return 'SurahsListEvent.saveLastSurah(surah: $surah, lastAyah: $lastAyah)';
}


}

/// @nodoc
abstract mixin class $SurahsListSaveLastSurahCopyWith<$Res> implements $SurahsListEventCopyWith<$Res> {
  factory $SurahsListSaveLastSurahCopyWith(SurahsListSaveLastSurah value, $Res Function(SurahsListSaveLastSurah) _then) = _$SurahsListSaveLastSurahCopyWithImpl;
@useResult
$Res call({
 int surah, int lastAyah
});




}
/// @nodoc
class _$SurahsListSaveLastSurahCopyWithImpl<$Res>
    implements $SurahsListSaveLastSurahCopyWith<$Res> {
  _$SurahsListSaveLastSurahCopyWithImpl(this._self, this._then);

  final SurahsListSaveLastSurah _self;
  final $Res Function(SurahsListSaveLastSurah) _then;

/// Create a copy of SurahsListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? surah = null,Object? lastAyah = null,}) {
  return _then(SurahsListSaveLastSurah(
surah: null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as int,lastAyah: null == lastAyah ? _self.lastAyah : lastAyah // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
