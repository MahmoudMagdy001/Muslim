// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quran_player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuranPlayerState {

 Duration get currentPosition; Duration get totalDuration; bool get isPlaying; int? get currentAyah; int? get currentSurah;
/// Create a copy of QuranPlayerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuranPlayerStateCopyWith<QuranPlayerState> get copyWith => _$QuranPlayerStateCopyWithImpl<QuranPlayerState>(this as QuranPlayerState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as QuranPlayerState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuranPlayerState&&(identical(other.currentPosition, _this.currentPosition) || other.currentPosition == _this.currentPosition)&&(identical(other.totalDuration, _this.totalDuration) || other.totalDuration == _this.totalDuration)&&(identical(other.isPlaying, _this.isPlaying) || other.isPlaying == _this.isPlaying)&&(identical(other.currentAyah, _this.currentAyah) || other.currentAyah == _this.currentAyah)&&(identical(other.currentSurah, _this.currentSurah) || other.currentSurah == _this.currentSurah));
}


@override
int get hashCode {
  final _this = this as QuranPlayerState;
  return Object.hash(runtimeType,_this.currentPosition,_this.totalDuration,_this.isPlaying,_this.currentAyah,_this.currentSurah);
}

@override
String toString() {
  final _this = this as QuranPlayerState;
  return 'QuranPlayerState(currentPosition: ${_this.currentPosition}, totalDuration: ${_this.totalDuration}, isPlaying: ${_this.isPlaying}, currentAyah: ${_this.currentAyah}, currentSurah: ${_this.currentSurah})';
}


}

/// @nodoc
abstract mixin class $QuranPlayerStateCopyWith<$Res>  {
  factory $QuranPlayerStateCopyWith(QuranPlayerState value, $Res Function(QuranPlayerState) _then) = _$QuranPlayerStateCopyWithImpl;
@useResult
$Res call({
 Duration currentPosition, Duration totalDuration, bool isPlaying, int? currentAyah, int? currentSurah
});




}
/// @nodoc
class _$QuranPlayerStateCopyWithImpl<$Res>
    implements $QuranPlayerStateCopyWith<$Res> {
  _$QuranPlayerStateCopyWithImpl(this._self, this._then);

  final QuranPlayerState _self;
  final $Res Function(QuranPlayerState) _then;

/// Create a copy of QuranPlayerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPosition = null,Object? totalDuration = null,Object? isPlaying = null,Object? currentAyah = freezed,Object? currentSurah = freezed,}) {
  return _then(QuranPlayerState(
currentPosition: null == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as Duration,totalDuration: null == totalDuration ? _self.totalDuration : totalDuration // ignore: cast_nullable_to_non_nullable
as Duration,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,currentAyah: freezed == currentAyah ? _self.currentAyah : currentAyah // ignore: cast_nullable_to_non_nullable
as int?,currentSurah: freezed == currentSurah ? _self.currentSurah : currentSurah // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuranPlayerState].
extension QuranPlayerStatePatterns on QuranPlayerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuranPlayerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuranPlayerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuranPlayerState value)  $default,){
final _that = this;
switch (_that) {
case _QuranPlayerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuranPlayerState value)?  $default,){
final _that = this;
switch (_that) {
case _QuranPlayerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration currentPosition,  Duration totalDuration,  bool isPlaying,  int? currentAyah,  int? currentSurah)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuranPlayerState() when $default != null:
return $default(_that.currentPosition,_that.totalDuration,_that.isPlaying,_that.currentAyah,_that.currentSurah);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration currentPosition,  Duration totalDuration,  bool isPlaying,  int? currentAyah,  int? currentSurah)  $default,) {final _that = this;
switch (_that) {
case _QuranPlayerState():
return $default(_that.currentPosition,_that.totalDuration,_that.isPlaying,_that.currentAyah,_that.currentSurah);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration currentPosition,  Duration totalDuration,  bool isPlaying,  int? currentAyah,  int? currentSurah)?  $default,) {final _that = this;
switch (_that) {
case _QuranPlayerState() when $default != null:
return $default(_that.currentPosition,_that.totalDuration,_that.isPlaying,_that.currentAyah,_that.currentSurah);case _:
  return null;

}
}

}

/// @nodoc


class _QuranPlayerState implements QuranPlayerState {
  const _QuranPlayerState({this.currentPosition = Duration.zero, this.totalDuration = Duration.zero, this.isPlaying = false, this.currentAyah, this.currentSurah});
  

@override@JsonKey() final  Duration currentPosition;
@override@JsonKey() final  Duration totalDuration;
@override@JsonKey() final  bool isPlaying;
@override final  int? currentAyah;
@override final  int? currentSurah;

/// Create a copy of QuranPlayerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuranPlayerStateCopyWith<_QuranPlayerState> get copyWith => __$QuranPlayerStateCopyWithImpl<_QuranPlayerState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuranPlayerState&&(identical(other.currentPosition, currentPosition) || other.currentPosition == currentPosition)&&(identical(other.totalDuration, totalDuration) || other.totalDuration == totalDuration)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.currentAyah, currentAyah) || other.currentAyah == currentAyah)&&(identical(other.currentSurah, currentSurah) || other.currentSurah == currentSurah));
}


@override
int get hashCode {
    return Object.hash(runtimeType,currentPosition,totalDuration,isPlaying,currentAyah,currentSurah);
}

@override
String toString() {
    return 'QuranPlayerState(currentPosition: $currentPosition, totalDuration: $totalDuration, isPlaying: $isPlaying, currentAyah: $currentAyah, currentSurah: $currentSurah)';
}


}

/// @nodoc
abstract mixin class _$QuranPlayerStateCopyWith<$Res> implements $QuranPlayerStateCopyWith<$Res> {
  factory _$QuranPlayerStateCopyWith(_QuranPlayerState value, $Res Function(_QuranPlayerState) _then) = __$QuranPlayerStateCopyWithImpl;
@override @useResult
$Res call({
 Duration currentPosition, Duration totalDuration, bool isPlaying, int? currentAyah, int? currentSurah
});




}
/// @nodoc
class __$QuranPlayerStateCopyWithImpl<$Res>
    implements _$QuranPlayerStateCopyWith<$Res> {
  __$QuranPlayerStateCopyWithImpl(this._self, this._then);

  final _QuranPlayerState _self;
  final $Res Function(_QuranPlayerState) _then;

/// Create a copy of QuranPlayerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPosition = null,Object? totalDuration = null,Object? isPlaying = null,Object? currentAyah = freezed,Object? currentSurah = freezed,}) {
  return _then(_QuranPlayerState(
currentPosition: null == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as Duration,totalDuration: null == totalDuration ? _self.totalDuration : totalDuration // ignore: cast_nullable_to_non_nullable
as Duration,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,currentAyah: freezed == currentAyah ? _self.currentAyah : currentAyah // ignore: cast_nullable_to_non_nullable
as int?,currentSurah: freezed == currentSurah ? _self.currentSurah : currentSurah // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
