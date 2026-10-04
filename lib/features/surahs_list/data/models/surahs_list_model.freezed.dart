// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surahs_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SurahsListModel {

 int get number; String get surahName; int get ayahCount; String get locationArabic;
/// Create a copy of SurahsListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahsListModelCopyWith<SurahsListModel> get copyWith => _$SurahsListModelCopyWithImpl<SurahsListModel>(this as SurahsListModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SurahsListModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahsListModel&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.surahName, _this.surahName) || other.surahName == _this.surahName)&&(identical(other.ayahCount, _this.ayahCount) || other.ayahCount == _this.ayahCount)&&(identical(other.locationArabic, _this.locationArabic) || other.locationArabic == _this.locationArabic));
}


@override
int get hashCode {
  final _this = this as SurahsListModel;
  return Object.hash(runtimeType,_this.number,_this.surahName,_this.ayahCount,_this.locationArabic);
}

@override
String toString() {
  final _this = this as SurahsListModel;
  return 'SurahsListModel(number: ${_this.number}, surahName: ${_this.surahName}, ayahCount: ${_this.ayahCount}, locationArabic: ${_this.locationArabic})';
}


}

/// @nodoc
abstract mixin class $SurahsListModelCopyWith<$Res>  {
  factory $SurahsListModelCopyWith(SurahsListModel value, $Res Function(SurahsListModel) _then) = _$SurahsListModelCopyWithImpl;
@useResult
$Res call({
 int number, String surahName, int ayahCount, String locationArabic
});




}
/// @nodoc
class _$SurahsListModelCopyWithImpl<$Res>
    implements $SurahsListModelCopyWith<$Res> {
  _$SurahsListModelCopyWithImpl(this._self, this._then);

  final SurahsListModel _self;
  final $Res Function(SurahsListModel) _then;

/// Create a copy of SurahsListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? surahName = null,Object? ayahCount = null,Object? locationArabic = null,}) {
  return _then(SurahsListModel(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,surahName: null == surahName ? _self.surahName : surahName // ignore: cast_nullable_to_non_nullable
as String,ayahCount: null == ayahCount ? _self.ayahCount : ayahCount // ignore: cast_nullable_to_non_nullable
as int,locationArabic: null == locationArabic ? _self.locationArabic : locationArabic // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SurahsListModel].
extension SurahsListModelPatterns on SurahsListModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurahsListModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurahsListModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurahsListModel value)  $default,){
final _that = this;
switch (_that) {
case _SurahsListModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurahsListModel value)?  $default,){
final _that = this;
switch (_that) {
case _SurahsListModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number,  String surahName,  int ayahCount,  String locationArabic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurahsListModel() when $default != null:
return $default(_that.number,_that.surahName,_that.ayahCount,_that.locationArabic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number,  String surahName,  int ayahCount,  String locationArabic)  $default,) {final _that = this;
switch (_that) {
case _SurahsListModel():
return $default(_that.number,_that.surahName,_that.ayahCount,_that.locationArabic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number,  String surahName,  int ayahCount,  String locationArabic)?  $default,) {final _that = this;
switch (_that) {
case _SurahsListModel() when $default != null:
return $default(_that.number,_that.surahName,_that.ayahCount,_that.locationArabic);case _:
  return null;

}
}

}

/// @nodoc


class _SurahsListModel implements SurahsListModel {
  const _SurahsListModel({required this.number, required this.surahName, required this.ayahCount, required this.locationArabic});
  

@override final  int number;
@override final  String surahName;
@override final  int ayahCount;
@override final  String locationArabic;

/// Create a copy of SurahsListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurahsListModelCopyWith<_SurahsListModel> get copyWith => __$SurahsListModelCopyWithImpl<_SurahsListModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurahsListModel&&(identical(other.number, number) || other.number == number)&&(identical(other.surahName, surahName) || other.surahName == surahName)&&(identical(other.ayahCount, ayahCount) || other.ayahCount == ayahCount)&&(identical(other.locationArabic, locationArabic) || other.locationArabic == locationArabic));
}


@override
int get hashCode {
    return Object.hash(runtimeType,number,surahName,ayahCount,locationArabic);
}

@override
String toString() {
    return 'SurahsListModel(number: $number, surahName: $surahName, ayahCount: $ayahCount, locationArabic: $locationArabic)';
}


}

/// @nodoc
abstract mixin class _$SurahsListModelCopyWith<$Res> implements $SurahsListModelCopyWith<$Res> {
  factory _$SurahsListModelCopyWith(_SurahsListModel value, $Res Function(_SurahsListModel) _then) = __$SurahsListModelCopyWithImpl;
@override @useResult
$Res call({
 int number, String surahName, int ayahCount, String locationArabic
});




}
/// @nodoc
class __$SurahsListModelCopyWithImpl<$Res>
    implements _$SurahsListModelCopyWith<$Res> {
  __$SurahsListModelCopyWithImpl(this._self, this._then);

  final _SurahsListModel _self;
  final $Res Function(_SurahsListModel) _then;

/// Create a copy of SurahsListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? surahName = null,Object? ayahCount = null,Object? locationArabic = null,}) {
  return _then(_SurahsListModel(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,surahName: null == surahName ? _self.surahName : surahName // ignore: cast_nullable_to_non_nullable
as String,ayahCount: null == ayahCount ? _self.ayahCount : ayahCount // ignore: cast_nullable_to_non_nullable
as int,locationArabic: null == locationArabic ? _self.locationArabic : locationArabic // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
