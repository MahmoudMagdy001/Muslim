// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hadith_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HadithEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HadithEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HadithEvent()';
}


}

/// @nodoc
class $HadithEventCopyWith<$Res>  {
$HadithEventCopyWith(HadithEvent _, $Res Function(HadithEvent) __);
}


/// Adds pattern-matching-related methods to [HadithEvent].
extension HadithEventPatterns on HadithEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HadithInitializeData value)?  initializeData,TResult Function( HadithReloadData value)?  reloadData,TResult Function( HadithToggleHadithSave value)?  toggleHadithSave,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HadithInitializeData() when initializeData != null:
return initializeData(_that);case HadithReloadData() when reloadData != null:
return reloadData(_that);case HadithToggleHadithSave() when toggleHadithSave != null:
return toggleHadithSave(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HadithInitializeData value)  initializeData,required TResult Function( HadithReloadData value)  reloadData,required TResult Function( HadithToggleHadithSave value)  toggleHadithSave,}){
final _that = this;
switch (_that) {
case HadithInitializeData():
return initializeData(_that);case HadithReloadData():
return reloadData(_that);case HadithToggleHadithSave():
return toggleHadithSave(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HadithInitializeData value)?  initializeData,TResult? Function( HadithReloadData value)?  reloadData,TResult? Function( HadithToggleHadithSave value)?  toggleHadithSave,}){
final _that = this;
switch (_that) {
case HadithInitializeData() when initializeData != null:
return initializeData(_that);case HadithReloadData() when reloadData != null:
return reloadData(_that);case HadithToggleHadithSave() when toggleHadithSave != null:
return toggleHadithSave(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String bookSlug,  String chapterNumber,  String chapterName)?  initializeData,TResult Function()?  reloadData,TResult Function( HadithEntity hadith,  bool isArabic)?  toggleHadithSave,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HadithInitializeData() when initializeData != null:
return initializeData(_that.bookSlug,_that.chapterNumber,_that.chapterName);case HadithReloadData() when reloadData != null:
return reloadData();case HadithToggleHadithSave() when toggleHadithSave != null:
return toggleHadithSave(_that.hadith,_that.isArabic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String bookSlug,  String chapterNumber,  String chapterName)  initializeData,required TResult Function()  reloadData,required TResult Function( HadithEntity hadith,  bool isArabic)  toggleHadithSave,}) {final _that = this;
switch (_that) {
case HadithInitializeData():
return initializeData(_that.bookSlug,_that.chapterNumber,_that.chapterName);case HadithReloadData():
return reloadData();case HadithToggleHadithSave():
return toggleHadithSave(_that.hadith,_that.isArabic);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String bookSlug,  String chapterNumber,  String chapterName)?  initializeData,TResult? Function()?  reloadData,TResult? Function( HadithEntity hadith,  bool isArabic)?  toggleHadithSave,}) {final _that = this;
switch (_that) {
case HadithInitializeData() when initializeData != null:
return initializeData(_that.bookSlug,_that.chapterNumber,_that.chapterName);case HadithReloadData() when reloadData != null:
return reloadData();case HadithToggleHadithSave() when toggleHadithSave != null:
return toggleHadithSave(_that.hadith,_that.isArabic);case _:
  return null;

}
}

}

/// @nodoc


class HadithInitializeData implements HadithEvent {
  const HadithInitializeData({required this.bookSlug, required this.chapterNumber, required this.chapterName});
  

 final  String bookSlug;
 final  String chapterNumber;
 final  String chapterName;

/// Create a copy of HadithEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HadithInitializeDataCopyWith<HadithInitializeData> get copyWith => _$HadithInitializeDataCopyWithImpl<HadithInitializeData>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HadithInitializeData&&(identical(other.bookSlug, bookSlug) || other.bookSlug == bookSlug)&&(identical(other.chapterNumber, chapterNumber) || other.chapterNumber == chapterNumber)&&(identical(other.chapterName, chapterName) || other.chapterName == chapterName));
}


@override
int get hashCode {
    return Object.hash(runtimeType,bookSlug,chapterNumber,chapterName);
}

@override
String toString() {
    return 'HadithEvent.initializeData(bookSlug: $bookSlug, chapterNumber: $chapterNumber, chapterName: $chapterName)';
}


}

/// @nodoc
abstract mixin class $HadithInitializeDataCopyWith<$Res> implements $HadithEventCopyWith<$Res> {
  factory $HadithInitializeDataCopyWith(HadithInitializeData value, $Res Function(HadithInitializeData) _then) = _$HadithInitializeDataCopyWithImpl;
@useResult
$Res call({
 String bookSlug, String chapterNumber, String chapterName
});




}
/// @nodoc
class _$HadithInitializeDataCopyWithImpl<$Res>
    implements $HadithInitializeDataCopyWith<$Res> {
  _$HadithInitializeDataCopyWithImpl(this._self, this._then);

  final HadithInitializeData _self;
  final $Res Function(HadithInitializeData) _then;

/// Create a copy of HadithEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bookSlug = null,Object? chapterNumber = null,Object? chapterName = null,}) {
  return _then(HadithInitializeData(
bookSlug: null == bookSlug ? _self.bookSlug : bookSlug // ignore: cast_nullable_to_non_nullable
as String,chapterNumber: null == chapterNumber ? _self.chapterNumber : chapterNumber // ignore: cast_nullable_to_non_nullable
as String,chapterName: null == chapterName ? _self.chapterName : chapterName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class HadithReloadData implements HadithEvent {
  const HadithReloadData();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HadithReloadData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HadithEvent.reloadData()';
}


}




/// @nodoc


class HadithToggleHadithSave implements HadithEvent {
  const HadithToggleHadithSave({required this.hadith, required this.isArabic});
  

 final  HadithEntity hadith;
 final  bool isArabic;

/// Create a copy of HadithEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HadithToggleHadithSaveCopyWith<HadithToggleHadithSave> get copyWith => _$HadithToggleHadithSaveCopyWithImpl<HadithToggleHadithSave>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HadithToggleHadithSave&&(identical(other.hadith, hadith) || other.hadith == hadith)&&(identical(other.isArabic, isArabic) || other.isArabic == isArabic));
}


@override
int get hashCode {
    return Object.hash(runtimeType,hadith,isArabic);
}

@override
String toString() {
    return 'HadithEvent.toggleHadithSave(hadith: $hadith, isArabic: $isArabic)';
}


}

/// @nodoc
abstract mixin class $HadithToggleHadithSaveCopyWith<$Res> implements $HadithEventCopyWith<$Res> {
  factory $HadithToggleHadithSaveCopyWith(HadithToggleHadithSave value, $Res Function(HadithToggleHadithSave) _then) = _$HadithToggleHadithSaveCopyWithImpl;
@useResult
$Res call({
 HadithEntity hadith, bool isArabic
});


$HadithEntityCopyWith<$Res> get hadith;

}
/// @nodoc
class _$HadithToggleHadithSaveCopyWithImpl<$Res>
    implements $HadithToggleHadithSaveCopyWith<$Res> {
  _$HadithToggleHadithSaveCopyWithImpl(this._self, this._then);

  final HadithToggleHadithSave _self;
  final $Res Function(HadithToggleHadithSave) _then;

/// Create a copy of HadithEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? hadith = null,Object? isArabic = null,}) {
  return _then(HadithToggleHadithSave(
hadith: null == hadith ? _self.hadith : hadith // ignore: cast_nullable_to_non_nullable
as HadithEntity,isArabic: null == isArabic ? _self.isArabic : isArabic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of HadithEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HadithEntityCopyWith<$Res> get hadith {
  
  return $HadithEntityCopyWith<$Res>(_self.hadith, (value) {
    return _then(_self.copyWith(hadith: value));
  });
}
}

// dart format on
