// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_calculation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrayerCalculationResult {

 PrayerType get nextPrayer; DateTime get nextPrayerDateTime; DateTime get previousPrayerDateTime; Duration get timeLeft; bool get areAllPrayersFinished;
/// Create a copy of PrayerCalculationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerCalculationResultCopyWith<PrayerCalculationResult> get copyWith => _$PrayerCalculationResultCopyWithImpl<PrayerCalculationResult>(this as PrayerCalculationResult, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PrayerCalculationResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerCalculationResult&&(identical(other.nextPrayer, _this.nextPrayer) || other.nextPrayer == _this.nextPrayer)&&(identical(other.nextPrayerDateTime, _this.nextPrayerDateTime) || other.nextPrayerDateTime == _this.nextPrayerDateTime)&&(identical(other.previousPrayerDateTime, _this.previousPrayerDateTime) || other.previousPrayerDateTime == _this.previousPrayerDateTime)&&(identical(other.timeLeft, _this.timeLeft) || other.timeLeft == _this.timeLeft)&&(identical(other.areAllPrayersFinished, _this.areAllPrayersFinished) || other.areAllPrayersFinished == _this.areAllPrayersFinished));
}


@override
int get hashCode {
  final _this = this as PrayerCalculationResult;
  return Object.hash(runtimeType,_this.nextPrayer,_this.nextPrayerDateTime,_this.previousPrayerDateTime,_this.timeLeft,_this.areAllPrayersFinished);
}

@override
String toString() {
  final _this = this as PrayerCalculationResult;
  return 'PrayerCalculationResult(nextPrayer: ${_this.nextPrayer}, nextPrayerDateTime: ${_this.nextPrayerDateTime}, previousPrayerDateTime: ${_this.previousPrayerDateTime}, timeLeft: ${_this.timeLeft}, areAllPrayersFinished: ${_this.areAllPrayersFinished})';
}


}

/// @nodoc
abstract mixin class $PrayerCalculationResultCopyWith<$Res>  {
  factory $PrayerCalculationResultCopyWith(PrayerCalculationResult value, $Res Function(PrayerCalculationResult) _then) = _$PrayerCalculationResultCopyWithImpl;
@useResult
$Res call({
 PrayerType nextPrayer, DateTime nextPrayerDateTime, DateTime previousPrayerDateTime, Duration timeLeft, bool areAllPrayersFinished
});




}
/// @nodoc
class _$PrayerCalculationResultCopyWithImpl<$Res>
    implements $PrayerCalculationResultCopyWith<$Res> {
  _$PrayerCalculationResultCopyWithImpl(this._self, this._then);

  final PrayerCalculationResult _self;
  final $Res Function(PrayerCalculationResult) _then;

/// Create a copy of PrayerCalculationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nextPrayer = null,Object? nextPrayerDateTime = null,Object? previousPrayerDateTime = null,Object? timeLeft = null,Object? areAllPrayersFinished = null,}) {
  return _then(PrayerCalculationResult(
nextPrayer: null == nextPrayer ? _self.nextPrayer : nextPrayer // ignore: cast_nullable_to_non_nullable
as PrayerType,nextPrayerDateTime: null == nextPrayerDateTime ? _self.nextPrayerDateTime : nextPrayerDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,previousPrayerDateTime: null == previousPrayerDateTime ? _self.previousPrayerDateTime : previousPrayerDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,timeLeft: null == timeLeft ? _self.timeLeft : timeLeft // ignore: cast_nullable_to_non_nullable
as Duration,areAllPrayersFinished: null == areAllPrayersFinished ? _self.areAllPrayersFinished : areAllPrayersFinished // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PrayerCalculationResult].
extension PrayerCalculationResultPatterns on PrayerCalculationResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerCalculationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerCalculationResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerCalculationResult value)  $default,){
final _that = this;
switch (_that) {
case _PrayerCalculationResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerCalculationResult value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerCalculationResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PrayerType nextPrayer,  DateTime nextPrayerDateTime,  DateTime previousPrayerDateTime,  Duration timeLeft,  bool areAllPrayersFinished)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerCalculationResult() when $default != null:
return $default(_that.nextPrayer,_that.nextPrayerDateTime,_that.previousPrayerDateTime,_that.timeLeft,_that.areAllPrayersFinished);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PrayerType nextPrayer,  DateTime nextPrayerDateTime,  DateTime previousPrayerDateTime,  Duration timeLeft,  bool areAllPrayersFinished)  $default,) {final _that = this;
switch (_that) {
case _PrayerCalculationResult():
return $default(_that.nextPrayer,_that.nextPrayerDateTime,_that.previousPrayerDateTime,_that.timeLeft,_that.areAllPrayersFinished);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PrayerType nextPrayer,  DateTime nextPrayerDateTime,  DateTime previousPrayerDateTime,  Duration timeLeft,  bool areAllPrayersFinished)?  $default,) {final _that = this;
switch (_that) {
case _PrayerCalculationResult() when $default != null:
return $default(_that.nextPrayer,_that.nextPrayerDateTime,_that.previousPrayerDateTime,_that.timeLeft,_that.areAllPrayersFinished);case _:
  return null;

}
}

}

/// @nodoc


class _PrayerCalculationResult implements PrayerCalculationResult {
  const _PrayerCalculationResult({required this.nextPrayer, required this.nextPrayerDateTime, required this.previousPrayerDateTime, required this.timeLeft, required this.areAllPrayersFinished});
  

@override final  PrayerType nextPrayer;
@override final  DateTime nextPrayerDateTime;
@override final  DateTime previousPrayerDateTime;
@override final  Duration timeLeft;
@override final  bool areAllPrayersFinished;

/// Create a copy of PrayerCalculationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerCalculationResultCopyWith<_PrayerCalculationResult> get copyWith => __$PrayerCalculationResultCopyWithImpl<_PrayerCalculationResult>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerCalculationResult&&(identical(other.nextPrayer, nextPrayer) || other.nextPrayer == nextPrayer)&&(identical(other.nextPrayerDateTime, nextPrayerDateTime) || other.nextPrayerDateTime == nextPrayerDateTime)&&(identical(other.previousPrayerDateTime, previousPrayerDateTime) || other.previousPrayerDateTime == previousPrayerDateTime)&&(identical(other.timeLeft, timeLeft) || other.timeLeft == timeLeft)&&(identical(other.areAllPrayersFinished, areAllPrayersFinished) || other.areAllPrayersFinished == areAllPrayersFinished));
}


@override
int get hashCode {
    return Object.hash(runtimeType,nextPrayer,nextPrayerDateTime,previousPrayerDateTime,timeLeft,areAllPrayersFinished);
}

@override
String toString() {
    return 'PrayerCalculationResult(nextPrayer: $nextPrayer, nextPrayerDateTime: $nextPrayerDateTime, previousPrayerDateTime: $previousPrayerDateTime, timeLeft: $timeLeft, areAllPrayersFinished: $areAllPrayersFinished)';
}


}

/// @nodoc
abstract mixin class _$PrayerCalculationResultCopyWith<$Res> implements $PrayerCalculationResultCopyWith<$Res> {
  factory _$PrayerCalculationResultCopyWith(_PrayerCalculationResult value, $Res Function(_PrayerCalculationResult) _then) = __$PrayerCalculationResultCopyWithImpl;
@override @useResult
$Res call({
 PrayerType nextPrayer, DateTime nextPrayerDateTime, DateTime previousPrayerDateTime, Duration timeLeft, bool areAllPrayersFinished
});




}
/// @nodoc
class __$PrayerCalculationResultCopyWithImpl<$Res>
    implements _$PrayerCalculationResultCopyWith<$Res> {
  __$PrayerCalculationResultCopyWithImpl(this._self, this._then);

  final _PrayerCalculationResult _self;
  final $Res Function(_PrayerCalculationResult) _then;

/// Create a copy of PrayerCalculationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nextPrayer = null,Object? nextPrayerDateTime = null,Object? previousPrayerDateTime = null,Object? timeLeft = null,Object? areAllPrayersFinished = null,}) {
  return _then(_PrayerCalculationResult(
nextPrayer: null == nextPrayer ? _self.nextPrayer : nextPrayer // ignore: cast_nullable_to_non_nullable
as PrayerType,nextPrayerDateTime: null == nextPrayerDateTime ? _self.nextPrayerDateTime : nextPrayerDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,previousPrayerDateTime: null == previousPrayerDateTime ? _self.previousPrayerDateTime : previousPrayerDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,timeLeft: null == timeLeft ? _self.timeLeft : timeLeft // ignore: cast_nullable_to_non_nullable
as Duration,areAllPrayersFinished: null == areAllPrayersFinished ? _self.areAllPrayersFinished : areAllPrayersFinished // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
